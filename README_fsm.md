# 🧠 Central Finite State Machine (`control_states_fsm.v`)

## Description
This module acts as the central execution controller for the system. It tracks the current operational state and outputs 5-bit alphanumeric token arrays to determine what information is sent to the display matrix.

## System Configuration States
* **`2'b00` (Standard Clock Mode):** Directs the system to route background wall clock paths to the 6-digit cluster layout.
* **`2'b01` (Stopwatch Mode):** Freezes standard clock updates on screen and shifts display multiplexing to read stopwatch memory tracks.
* **`2'b10` (Set Mode Text Menu):** Freezes standard time tracking and loads custom text setup characters onto the screen.
* **`2'b11` (Alarm Mode Text Menu):** Switches the common display layout to generate warning and setup menus.
