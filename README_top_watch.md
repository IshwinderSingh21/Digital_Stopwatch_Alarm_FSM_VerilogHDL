# 🎛️ Top-Level Wrapper Architecture (`top_watch.v`)

## Description
The `top_watch` module serves as the primary structural routing backplane of the entire digital clock system. It structurally instantiates and bridges the clock management network, input conditioning filters, central control FSM, and timing counters into a single synchronized system matrix.

## Hardware Connections & Routing
* **Asynchronous Input Conditioning:** Links raw tactile input lines (`btn_mode`, `btn_control`) directly to the synchronizer and debouncer pipeline to clear mechanical contact glitches.
* **Internal Bus Interconnects:** Interconnects the multi-bit output buses from the arithmetic counter banks directly to the multiplexer input lines.
* **Global Control Path:** Routes the master state tracking tokens exported by the central brain directly into the display module to govern dynamic panel routing.
