# Dify Stress Test Suite

## Requirements
- [uv](https://docs.astral.sh/uv/)

## Cách chạy bài test
- Cập nhập URL trong file bash script trước khi chạy 

- Quick sanity check (1 min, 10 CCU)
```
./scripts/stress-test/run_capacity_test.sh smoke
```

- Test average daily load (14 min, up to 520 CCU)
```
./scripts/stress-test/run_capacity_test.sh normal
```

- Test peak-hour load (14 min, up to 1,250 CCU)
```
./scripts/stress-test/run_capacity_test.sh peak
```

- Full staged run: smoke → normal → peak → spike (~30 min)
```
./scripts/stress-test/run_capacity_test.sh full
```

Hoặc set TEST_MODE để dùng web UI:

```
TEST_MODE=peak ./scripts/stress-test/run_capacity_test.sh

chọn option 2 → mở http://localhost:8089
```
