Lab 13: Dynamic Function eXchange (DFX)
## Concepts to learn
In-system hardware reconfiguration using the Internal Configuration Access Port (ICAP). Partitioning a design into Static and Reconfigurable regions. Managing floorplanning constraints and decoupling logic during bitstream loading.

## Technologies used
- Internal Configuration Access Port (ICAPE2): Hardware primitive for self-reconfiguration.
- DFX Controller / State Machine: Custom RTL to manage the configuration sequence.
- BUFGCE: Global Clock Buffer with Clock Enable for glitch-free decoupling.
- Pblocks: Physical floorplanning constraints for defining reconfigurable regions.
- Zynq Processing System (PS7): Providing the central clock backbone and system reset.

## Project Structure
```
├─ .assets/
│ 
├─ cfg/
│ ├─ redpitaya-ports.xdc      -- Pin assignments (LEDs, Clock)
│ └─ partition_floorplan.xdc  -- Pblock definitions and cell placement
│
├─ sources/
│   ├─ rtl/
│   │ ├─ icap_sm.v           -- ICAP State Machine (CSB, WEN control)
│   │ ├─ protocol_unit.v     -- UART Parser for bitstream data (7E frame)
│   │ ├─ decoupling.v        -- Isolation layer for clocks/resets
│   │ ├─ reset_sync.v        -- 2-stage synchronous reset bridge
│   │ ├─ shift_led_right.v   -- RM_1: Right logical shift register
│   │ └─ shift_led_left.v    -- RM_2: Left logical shift register
│
└─ sim/
  └─ tb_icap_controller.v    -- Simulation for the ICAP handshake
``` 
 
## Setup Instructions
```
# -----------------------------------------------------------------
# 1. Get the repo
# -----------------------------------------------------------------
git clone git@github.com:ahmedqamesh/digital-design-toolbox.git
git checkout lab13-reconfiguration
```
## Exercise 1: Building the ICAP Controller & Static Logic
```
source ex1_create_partial_reconfig_design.tcl
# or vivado -source ex1_create_partial_reconfig_design.tcl
```

