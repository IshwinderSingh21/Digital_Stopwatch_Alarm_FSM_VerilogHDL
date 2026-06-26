# 🔬 Verification Testbench Architecture (`top_watch_tb.v`)

## Description
A comprehensive behavioral simulation wrapper designed to dynamically assert inputs, handle time compression, and comprehensively test boundary edge cases.

## Testbench Features
* **Time Acceleration:** Bypasses real-world hardware clock divider constants to efficiently test multi-hour counter ripples within a microsecond simulation window.
* **Automated Stimulus Matrix:** Sequentially fires reset loops, mode transitions, stopwatch controls, and boundary checks to capture your 8 exact test case outputs.
* **VCD File Generation:** Outputs the structured waveform database (`watch_sim.vcd`) directly visualized inside GTKWave.
