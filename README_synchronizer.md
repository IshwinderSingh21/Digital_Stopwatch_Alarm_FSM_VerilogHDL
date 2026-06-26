# 🔄 Input Synchronizer Module (`synchronizer.v`)

## Description
The `synchronizer` module is a critical metastability protection barrier. It realigns external, asynchronous button presses safely to the active rising edges of the internal system clock before passing the signals into the debouncer tracking filters.

## Hardware Architecture
* **Dual-Stage D-Flip-Flop Chain:** Uses a cascaded 2-stage shift register to capture raw external signals.
* **Metastability Resolution:** The first flip-flop absorbs any unstable timing violations caused by asynchronous button presses landing too close to a clock edge. The second flip-flop outputs a stable, fully synchronized clock-domain signal.
* **Glitch Prevention:** Eliminates timing race conditions and state machine corruption within the main FSM controller.
