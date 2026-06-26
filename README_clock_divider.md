# ⏱️ Clock Management Network (`clock_divider.v`)

## Description
The frequency management core of the system. It down-samples the high-frequency system oscillator clock into precise, usable timing pulses via sequential binary toggle counters.

## Generated Time Bases
* **1 Hz Pulse Flag:** Serves as the primary trigger to increment standard wall clock arrays (seconds, minutes, hours).
* **100 Hz Pulse Flag:** Drives the high-speed execution matrix for precision stopwatch interval tracking.
* **1 kHz Pulse Flag:** Sets the scanning rate for the display multiplexer to guarantee flicker-free illumination.
