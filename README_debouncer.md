# 🛡️ Input Conditioning Pipeline (`debouncer.v` & `synchronizer.v`)

## Description
Protects the FSM state routing networks from input glitches, signal degradation, and clock domain violations during hardware operation.

## Component Breakdowns
* **`synchronizer.v`**: A dual-stage flip-flop shift register that realigns external asynchronous button events safely to the active edges of the internal system clock.
* **`debouncer.v`**: A stable digital counter filter that locks out high-frequency mechanical switch contact bouncing, preventing single button presses from double-triggering states.
