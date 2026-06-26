# Digital_Stopwatch_Alarm_FSM_VerilogHDL

## 🚀 Project Overview
This repository contains a modular Verilog HDL implementation and behavioral simulation of a multi-function digital clock system. Controlled by a centralized Finite State Machine (FSM), the architecture supports concurrent background timekeeping, independent high-resolution stopwatch operations (start, lap freeze, and clear), and custom 5-bit alphanumeric display formatting. 

The entire system interfaces with an **active-low multiplexed 6-digit 7-segment display**. To ensure high reliability and glitch-free simulation, the hardware logic isolates timing registers, utilizes a 1 kHz display refresh scanner, and integrates input conditioning (synchronization and debouncing) for external tactile buttons. 

The complete design has been exhaustively validated across an 8-stage verification matrix using Icarus Verilog (`iverilog`) and visualized via GTKWave with zero uninitialized (`xx`) state errors.

---

## 📁 Repository Structure

* **`src/`**: Houses all 8 modular Verilog source files (`top_watch.v`, `control_states_fsm.v`, `time_counters.v`, `seven_seg_mux.v`, `clock_divider.v`, `debouncer.v`, `synchronizer.v`, and `top_watch_tb.v`).
* **`images/`**: Contains the complete behavioral verification waveforms captured from GTKWave (`initial_reset.png`, and `testcase1.png` through `testcase8.png`).

---

## 🔄 Display Interface & Anode Mapping
The display driver employs high-speed dynamic multiplexing, sequentially pulling exactly one common anode line low (`0`) at a frequency of 1 kHz while routing the matching data nibble or custom alphanumeric token to the active-low segment bus (`seg[6:0]`).

| Digit Index | Anode Active Bit (`anode[5:0]`) | Timekeeping Mapping | Menu Text Mapping |
| :---: | :---: | :---: | :---: |
| **`3'd5`** (Far Left) | `6'b011111` (`0x1F`) | Hours Tens (`hour_tens`) | Alphanumeric Slot 5 |
| **`3'd4`** | `6'b101111` (`0x2F`) | Hours Units (`hour_units`) | Alphanumeric Slot 4 |
| **`3'd3`** | `6'b110111` (`0x3B`) | Minutes Tens (`min_tens`) | Alphanumeric Slot 3 |
| **`3'd2`** | `6'b111011` (`0x3D`) | Minutes Units (`min_units`) | Alphanumeric Slot 2 |
| **`3'd1`** | `6'b111101` (`0x3E`) | Seconds Tens (`sec_tens`) | Alphanumeric Slot 1 |
| **`3'd0`** (Far Right) | `6'b111110` (`0x3F`) | Seconds Units (`sec_units`) | Alphanumeric Slot 0 |

---

## 📊 8-Stage Verification Matrix
The testbench dynamically applies stimulus to transition through your exact functional execution phases:

1. **Initial Reset (`initial_reset.png`)**: Validates that asserting `rst` forces registers to zero, sets `seg` to `40` (character `0`), and sets `anode` to `3F` (all displays safely blanked out at startup).
2. **Test Case 1: Stopwatch Mode Activation (`testcase1.png`)**: Asserts the mode selector to transition the central FSM into the stopwatch state, ensuring the system isolates standard clock registers.
3. **Test Case 2: Stopwatch Counting & Operation (`testcase2.png`)**: Drives the control line to start high-resolution interval counting, verifying stopwatch registers increment accurately.
4. **Test Case 3: Stopwatch Pause / Lap Freeze (`testcase3.png`)**: Asserts control inputs to freeze the display lines (holding the lap value visible) while the timing engine runs silently in the background.
5. **Test Case 4: Stopwatch Reset (`testcase4.png`)**: Issues a clear sequence to wipe the stopwatch memory tracks and return the tracking registers back to a clean zero base.
6. **Test Case 5: Alarm Configuration State (`testcase5.png`)**: Transitions the system into the dedicated Alarm mode, validating that the 5-bit character matrix maps custom menu text parameters onto the display layout.
7. **Test Case 6: Time Adjustment Setup (`testcase6.png`)**: Drives the configuration FSM into the active Time Set state, enabling direct adjustment modifications to the hours and minutes data channels.
8. **Test Case 7: Normal Timekeeping Cascades (`testcase7.png`)**: Monitors the active ripple sequence where seconds rolling over cleanly increments minutes, and minutes ripple into hours under standard run mode.
9. **Test Case 8: Boundary Wrap-Around Execution (`testcase8.png`)**: Validates the ultimate edge condition, ensuring the system loops safely from `23:59:59` back to `00:00:00` on the next active time-pulse.
