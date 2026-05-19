#!/bin/bash
# Run Dify capacity planning benchmark (3M users scenario)

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

STRESS_TEST_DIR="${SCRIPT_DIR}"
HOST="http://localhost:5001"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
REPORT_DIR="${STRESS_TEST_DIR}/reports"
CSV_PREFIX="${REPORT_DIR}/capacity_${TIMESTAMP}"
HTML_REPORT="${REPORT_DIR}/capacity_report_${TIMESTAMP}.html"

mkdir -p "${REPORT_DIR}"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; CYAN='\033[0;36m'; NC='\033[0m'

# ─── Usage ────────────────────────────────────────────────────────────────────
usage() {
  echo -e "${CYAN}Usage:${NC}  $0 [smoke|normal|peak|spike|full]"
  echo
  echo "  smoke   —  10 CCU,   1 min  — verify setup"
  echo "  normal  — 520 CCU,  14 min  — average daily load"
  echo "  peak    — 1250 CCU, 14 min  — peak-hour simulation"
  echo "  spike   — 2490 CCU,  6 min  — stress / design limit"
  echo "  full    — all stages, ~30 min — complete capacity run (default)"
  echo
  echo "Examples:"
  echo "  $0 smoke          # quick sanity check"
  echo "  $0 peak           # only peak-hour test"
  echo "  $0 full           # full 30-min capacity run"
}

# ─── Parse args ───────────────────────────────────────────────────────────────
TEST_MODE="${1:-full}"
case "$TEST_MODE" in
  smoke|normal|peak|spike|full) ;;
  -h|--help) usage; exit 0 ;;
  *) echo -e "${RED}Unknown mode: $TEST_MODE${NC}"; usage; exit 1 ;;
esac

echo -e "${BLUE}╔═══════════════════════════════════════════════════════════════╗${NC}"
echo -e "${BLUE}║      DIFY CAPACITY PLANNING BENCHMARK — 3M USERS             ║${NC}"
echo -e "${BLUE}║      Mode: $(printf '%-51s' "${TEST_MODE^^}")║${NC}"
echo -e "${BLUE}╚═══════════════════════════════════════════════════════════════╝${NC}"
echo

# ─── Pre-flight checks ────────────────────────────────────────────────────────
echo -e "${YELLOW}Pre-flight checks...${NC}"

if ! curl -s -f http://localhost:5001/health > /dev/null 2>&1; then
  echo -e "${RED}✗ Dify API is not running on port 5001${NC}"
  echo -e "  Start with: ${CYAN}cd api && uv run gunicorn --bind 0.0.0.0:5001 --workers 4 --worker-class gevent app:app${NC}"
  exit 1
fi
echo -e "${GREEN}✓ Dify API reachable${NC}"

if ! curl -s -f http://localhost:5004/v1/models > /dev/null 2>&1; then
  echo -e "${RED}✗ Mock OpenAI server not running on port 5004${NC}"
  echo -e "  Start with: ${CYAN}python ${STRESS_TEST_DIR}/setup/mock_openai_server.py${NC}"
  exit 1
fi
echo -e "${GREEN}✓ Mock OpenAI server reachable${NC}"

STATE_FILE="${STRESS_TEST_DIR}/setup/config/stress_test_state.json"
if [ ! -f "$STATE_FILE" ]; then
  echo -e "${RED}✗ Stress test not configured. Run: python ${STRESS_TEST_DIR}/setup_all.py${NC}"
  exit 1
fi
echo -e "${GREEN}✓ Stress test state found${NC}"
echo

# ─── Scale summary ────────────────────────────────────────────────────────────
echo -e "${CYAN}Scale targets (3M users):${NC}"
echo "  Average RPS → Average CCU  :  35 req/s → 520 concurrent SSE connections"
echo "  Peak RPS    → Peak CCU     :  83 req/s → 1,245 concurrent SSE connections"
echo "  Design RPS  → Design CCU   : 166 req/s → 2,490 concurrent SSE connections"
echo
echo -e "${YELLOW}Note:${NC} CCU = RPS × avg_stream_duration (Little's Law)"
echo "  SSE holds a connection for the full LLM response (~15s), so"
echo "  CCU is ~150× higher than for a typical 100ms REST API."
echo

# ─── Select run mode ──────────────────────────────────────────────────────────
echo -e "${YELLOW}Run mode:${NC}"
echo "  1) Headless (CLI only) — default"
echo "  2) Web UI  (http://localhost:8089)"
read -rp "Choice [1]: " choice
choice="${choice:-1}"
echo

# ─── Run locust ───────────────────────────────────────────────────────────────
LOCUST_SCRIPT="${STRESS_TEST_DIR}/capacity_benchmark.py"

if [ "$choice" = "2" ]; then
  echo -e "${BLUE}Starting Locust web UI on http://localhost:8089 ...${NC}"
  TEST_MODE="$TEST_MODE" uv --project api run locust \
    -f "$LOCUST_SCRIPT" \
    --host "${HOST}" \
    --web-port 8089
else
  echo -e "${BLUE}Running in headless mode (TEST_MODE=${TEST_MODE})...${NC}"
  echo

  TEST_MODE="$TEST_MODE" uv --project api run locust \
    -f "$LOCUST_SCRIPT" \
    --host "${HOST}" \
    --headless \
    --print-stats \
    --csv="$CSV_PREFIX" \
    --html="$HTML_REPORT" \
    2>&1 | tee "${REPORT_DIR}/capacity_${TIMESTAMP}.log"

  echo
  echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
  echo -e "${GREEN}  CAPACITY TEST COMPLETE${NC}"
  echo -e "${GREEN}═══════════════════════════════════════════════════════════════${NC}"
  echo -e "  HTML report : ${CYAN}${HTML_REPORT}${NC}"
  echo -e "  CSV stats   : ${CYAN}${CSV_PREFIX}_stats.csv${NC}"
  echo -e "  JSON metrics: ${CYAN}${REPORT_DIR}/sse_metrics_*.json${NC} (latest)"
  echo

  # ─── Parse key metrics ────────────────────────────────────────────────────
  if [ -f "${CSV_PREFIX}_stats.csv" ]; then
    echo -e "${CYAN}Key metrics:${NC}"
    python3 - <<PYEOF
import csv

csv_file = "${CSV_PREFIX}_stats.csv"
try:
    with open(csv_file) as f:
        rows = list(csv.DictReader(f))
    for row in rows:
        if row.get("Name") == "Aggregated":
            print(f"  Requests         : {row.get('Request Count', 'N/A')}")
            print(f"  Failures         : {row.get('Failure Count', '0')}")
            print(f"  Median resp time : {row.get('Median Response Time', 'N/A')} ms")
            print(f"  95th pct         : {row.get('95%', 'N/A')} ms")
            print(f"  RPS (actual)     : {row.get('Requests/s', 'N/A')}")
            break
except Exception as e:
    print(f"  (could not parse CSV: {e})")
PYEOF
  fi
fi
