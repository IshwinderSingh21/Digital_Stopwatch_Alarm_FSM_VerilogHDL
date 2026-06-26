# Digital_Stopwatch_Alarm_FSM_VerilogHDL

A modular Verilog HDL implementation and behavioral simulation of a multi-function digital clock system. Controlled by a central Finite State Machine (FSM), the architecture features concurrent background timekeeping, independent stopwatch operations (start/freeze), and custom 5-bit alphanumeric display formatting over an active-low multiplexed 6-digit 7-segment display interface. Validated dynamically via an 8-stage verification testbench using Icarus Verilog and GTKWave.

---

## 📁 Repository Structure

```text
├── images/
│   ├── initial_reset.png
│   ├── testcase1.png
│   ├── testcase2.png
│   ├── testcase3.png
│   ├── testcase4.png
│   ├── testcase5.png
│   ├── testcase6.png
│   ├── testcase7.png
│   └── testcase8.png
└── src/
    ├── clock_divider.v
    ├── control_states_fsm.v
    ├── debouncer.v
    ├── seven_seg_mux.v
    ├── synchronizer.v
    ├── time_counters.v
    ├── top_watch.v
    └── top_watch_tb.v

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
The testbench dynamically applies stimulus to verify boundary conditions, input synchronization, and state transitions:

1. **Initial System Reset (`initial_reset.png`)**: Validates that asserting `rst` forces registers to zero, sets `seg` to `40` (character `0`), and sets `anode` to `3F` (all displays blanked).
2. **Test Case 1: Mode Switching Logic (`testcase1.png`)**: Verifies the walking-zero anode pattern (`3E -> 3D -> 3B...`) and dynamic routing when shifting states via `btn_mode`.
3. **Test Case 2: Control Input Processing (`testcase2.png`)**: Verifies that `btn_control` accurately triggers stopwatch run, lap freeze, and clear functions.
4. **Test Case 3: Timekeeping Cascade (`testcase3.png`)**: Validates clock counter tracking (Seconds $\rightarrow$ Minutes $\rightarrow$ Hours ripple).
5. **Test Case 4: Stopwatch Resolution (`testcase4.png`)**: Validates high-resolution sub-second tracking accuracy.
6. **Test Case 5: Character Decoding (`testcase5.png`)**: Verifies 5-bit lookup tables for custom status text strings without distortion.
7. **Test Case 6: Mid-Cycle Reset Recovery (`testcase6.png`)**: Validates instant return to ground-state conditions during active counting.
8. **Test Case 7: Button Input Debounce Delay (`testcase7.png`)**: Proves asynchronous button edges are safely registered and delayed across clock boundaries.
9. **Test Case 8: 24-Hour Wrap-Around (`testcase8.png`)**: Assures full boundary wrap-around execution ($23:59:59 \rightarrow 00:00:00$).
