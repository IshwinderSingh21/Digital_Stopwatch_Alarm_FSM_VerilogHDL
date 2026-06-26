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
