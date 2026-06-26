# 🔄 Display Driver & Logic Decoder (`seven_seg_mux.v`)

## Description
A hardwired combinational and sequential driver optimized to multiplex multi-bit time registers across a shared active-low 6-digit 7-segment bus interface.

## Hardware Initialization Safe-Guard
To completely eliminate uninitialized data corruption (where memory defaults to unknown simulation tokens `x`), this module routes an explicit, continuous initialization guard line directly on the indexing path:

```verilog
assign digit_select = (rst) ? 3'd0 : digit_counter;
