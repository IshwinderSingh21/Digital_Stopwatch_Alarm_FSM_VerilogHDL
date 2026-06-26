# ⏱️ Timekeeping Counter Infrastructure (`time_counters.v`)

## Description
The arithmetic computing engine of the clock. It manages independent, synchronously incremented register banks to track standard timekeeping and stopwatch intervals cleanly.

## Internal Register Buffers
* **Wall Clock Network:** `hour_tens` [1:0], `hour_units` [3:0], `min_tens` [2:0], `min_units` [3:0], `sec_tens` [2:0], `sec_units` [3:0].
* **Stopwatch Network:** `sw_min_tens` [2:0], `sw_min_units` [3:0], `sw_sec_tens` [2:0], `sw_sec_units` [3:0].

## Cascade & Boundary Logic
Increments registers on the rising edges of down-sampled pulse flags. When a lower register hits its cap (e.g., seconds reaching `59`), it generates a synchronous high-level enable flag to increment the next position, executing a perfect wrap-around loop at the 24-hour boundary ($23:59:59 \rightarrow 00:00:00$).
