#!/usr/bin/env python3
"""
Dify Capacity Planning Benchmark — 3M Users

Scale assumptions:
  - 3,000,000 total registered users
  - 300,000 DAU (10% active per day)
  - 10 queries per user per day
  - 80% of traffic concentrated in 8 peak hours
  - Avg SSE stream duration: 15s (LLM responds in streaming)

CCU vs RPS (Little's Law: CCU = RPS × avg_response_time):
  For a typical REST API (avg 100ms): 35 RPS → ~3.5 CCU
  For Dify SSE streaming (avg 15s):  35 RPS → ~520 CCU

  This is the critical difference: SSE keeps connections alive for the
  entire LLM generation time, so CCU is ~150× higher than RPS.

Calculated targets:
  Average RPS:   34.7 req/s   → Average CCU:  520
  Peak RPS:      83   req/s   → Peak CCU:   1,245
  Design RPS:   166   req/s   → Design CCU: 2,490  (2× safety factor)

Test modes (set via TEST_MODE env var):
  smoke   — 10 CCU, 1 min       (verify setup)
  normal  — up to 520 CCU       (average daily load)
  peak    — up to 1,245 CCU     (peak-hour load)
  spike   — up to 2,490 CCU     (stress/design limit)
  full    — all stages in order  (complete capacity run, ~30 min)
"""

import logging
import os
import sys
from pathlib import Path

from locust import LoadTestShape, events

sys.path.insert(0, str(Path(__file__).parent))
from sse_benchmark import DifyWorkflowUser, metrics  # noqa: F401 — registers the user class

logger = logging.getLogger(__name__)

# ─── Scale constants ────────────────────────────────────────────────────────
TOTAL_USERS      = 3_000_000
DAU_RATE         = 0.10           # 10% active per day
QUERIES_PER_USER = 10
PEAK_HOURS       = 8              # hours containing 80% of daily traffic
PEAK_TRAFFIC_PCT = 0.80
SAFETY_FACTOR    = 2.0            # design headroom multiplier
AVG_STREAM_SEC   = 15.0           # assumed avg SSE duration per LLM response

DAU              = int(TOTAL_USERS * DAU_RATE)
DAILY_REQUESTS   = DAU * QUERIES_PER_USER
AVG_RPS          = DAILY_REQUESTS / 86_400
PEAK_RPS         = (DAILY_REQUESTS * PEAK_TRAFFIC_PCT) / (PEAK_HOURS * 3600)
DESIGN_RPS       = PEAK_RPS * SAFETY_FACTOR

# Little's Law: CCU = RPS × avg_response_time
AVG_CCU    = max(10, int(AVG_RPS * AVG_STREAM_SEC))
PEAK_CCU   = int(PEAK_RPS * AVG_STREAM_SEC)
DESIGN_CCU = int(DESIGN_RPS * AVG_STREAM_SEC)

# ─── Stage profiles ──────────────────────────────────────────────────────────
# Each stage: duration (seconds), target users (≈ CCU), spawn_rate (users/sec)
STAGE_PROFILES: dict[str, list[dict[str, int]]] = {
    # Quick sanity check — just confirm the pipeline works
    "smoke": [
        {"duration": 60,  "users": 10,        "spawn_rate": 2},
    ],
    # Simulate average daily load
    "normal": [
        {"duration": 120, "users": 50,         "spawn_rate": 5},    # warm-up
        {"duration": 600, "users": AVG_CCU,    "spawn_rate": 20},   # steady state
        {"duration": 120, "users": 10,         "spawn_rate": 20},   # cool-down
    ],
    # Simulate the 8-hour peak window
    "peak": [
        {"duration": 120, "users": 50,         "spawn_rate": 5},
        {"duration": 300, "users": AVG_CCU,    "spawn_rate": 20},
        {"duration": 300, "users": PEAK_CCU,   "spawn_rate": 50},
        {"duration": 120, "users": 50,         "spawn_rate": 50},
    ],
    # Push to 2× design limit — find breaking point
    "spike": [
        {"duration": 60,  "users": AVG_CCU,    "spawn_rate": 50},
        {"duration": 180, "users": DESIGN_CCU, "spawn_rate": 100},
        {"duration": 120, "users": AVG_CCU,    "spawn_rate": 100},  # recovery check
    ],
    # Full progression: smoke → normal → peak → spike → recovery (~30 min)
    "full": [
        {"duration": 60,  "users": 10,         "spawn_rate": 2},    # Stage 1: smoke
        {"duration": 300, "users": AVG_CCU,    "spawn_rate": 20},   # Stage 2: ramp to normal
        {"duration": 600, "users": AVG_CCU,    "spawn_rate": 20},   # Stage 3: hold normal
        {"duration": 300, "users": PEAK_CCU,   "spawn_rate": 50},   # Stage 4: peak
        {"duration": 180, "users": DESIGN_CCU, "spawn_rate": 100},  # Stage 5: spike
        {"duration": 300, "users": AVG_CCU,    "spawn_rate": 100},  # Stage 6: recovery
    ],
}

TEST_MODE = os.getenv("TEST_MODE", "full").lower()
if TEST_MODE not in STAGE_PROFILES:
    logger.warning("Unknown TEST_MODE '%s', falling back to 'smoke'", TEST_MODE)
    TEST_MODE = "smoke"


class CapacityTestShape(LoadTestShape):
    """
    Drives locust virtual users through the staged load profile.

    Why CCU ≈ locust users here:
      DifyWorkflowUser uses constant(0) wait time, meaning each virtual user
      holds exactly one SSE connection until the stream finishes, then starts
      the next immediately. So locust_users ≈ concurrent SSE connections ≈ CCU.
    """

    stages = STAGE_PROFILES[TEST_MODE]

    def tick(self) -> tuple[int, float] | None:
        run_time = self.get_run_time()
        for stage in self.stages:
            if run_time < stage["duration"]:
                return stage["users"], float(stage["spawn_rate"])
            run_time -= stage["duration"]
        return None  # All stages complete


# ─── Event hooks ─────────────────────────────────────────────────────────────

@events.test_start.add_listener  # type: ignore[misc]
def on_test_start(environment: object, **kwargs: object) -> None:
    total_duration = sum(s["duration"] for s in STAGE_PROFILES[TEST_MODE])
    logger.info("=" * 72)
    logger.info("  DIFY CAPACITY PLANNING BENCHMARK — 3,000,000 USERS")
    logger.info("=" * 72)
    logger.info("  SCALE INPUTS")
    logger.info(f"    Total registered users : {TOTAL_USERS:>12,d}")
    logger.info(f"    DAU (10%%)              : {DAU:>12,d}")
    logger.info(f"    Queries / user / day   : {QUERIES_PER_USER:>12,d}")
    logger.info(f"    Daily requests         : {DAILY_REQUESTS:>12,d}")
    logger.info("-" * 72)
    logger.info("  THROUGHPUT TARGETS (RPS = requests / second)")
    logger.info(f"    Average RPS            : {AVG_RPS:>11.1f}  req/s")
    logger.info(f"    Peak RPS (8h window)   : {PEAK_RPS:>11.1f}  req/s  (80% traffic in 8h)")
    logger.info(f"    Design RPS (2× safety) : {DESIGN_RPS:>11.1f}  req/s")
    logger.info("-" * 72)
    logger.info("  CONCURRENCY TARGETS  [Little's Law: CCU = RPS × avg_stream_sec]")
    logger.info(f"    Avg SSE duration       : {AVG_STREAM_SEC:>11.0f}  s")
    logger.info(f"    Average CCU            : {AVG_CCU:>12,d}  (= {AVG_RPS:.1f} × {AVG_STREAM_SEC:.0f}s)")
    logger.info(f"    Peak CCU               : {PEAK_CCU:>12,d}  (= {PEAK_RPS:.1f} × {AVG_STREAM_SEC:.0f}s)")
    logger.info(f"    Design CCU             : {DESIGN_CCU:>12,d}  (= {DESIGN_RPS:.1f} × {AVG_STREAM_SEC:.0f}s)")
    logger.info("=" * 72)
    logger.info(f"  TEST MODE: {TEST_MODE.upper()}   (total ~{total_duration // 60} min)")
    logger.info("")
    logger.info(f"  {'Stage':<8} {'CCU':>8} {'Duration':>10} {'Spawn/s':>8}  {'Represents'}")
    logger.info(f"  {'-'*8} {'-'*8} {'-'*10} {'-'*8}  {'-'*30}")
    for i, stage in enumerate(STAGE_PROFILES[TEST_MODE], 1):
        u = stage["users"]
        if u <= 50:
            label = "warm-up / cool-down"
        elif u <= AVG_CCU:
            label = f"average load  ({AVG_RPS:.1f} RPS)"
        elif u <= PEAK_CCU:
            label = f"peak load     ({PEAK_RPS:.1f} RPS)"
        else:
            label = f"spike / limit ({DESIGN_RPS:.1f} RPS)"
        logger.info(f"  {i:<8} {u:>8,d} {stage['duration']:>9}s {stage['spawn_rate']:>8}  {label}")
    logger.info("=" * 72)
