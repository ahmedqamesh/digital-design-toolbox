## Lab 16
## Concepts to learn
Debugging of internal FPGA signals. Debugging strategies and what to debug

## Technologies used


- Integrated Logic Analyzer ([ILA](https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/ila.html))
- Virtual Input/Output ([VIO](https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/vio.html))
- __Optional__ [IBERT](https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/ibert_ultrascale_gth.html) for UltraScale™/UltraScale+™ GTH Transceivers
- __Optional__ [In-System IBERT](https://www.amd.com/en/products/adaptive-socs-and-fpgas/intellectual-property/in_system_ibert.html)

## Project Structure
```
├─ .assets/
│ 
├─ cfg/
│ └─ redpitaya-ports.xdc.xdc   		-- pin assignments for the board (LED)
│
├─ sources/
│    └─rtl
│ 	├─ blink_counter.vhd          	-- free‑running counter
│ 	├─ shift_led_right.vhd      -- Right logical shift register – triggered on the pulse
│ 	└─ shift_led_left.vhd       -- Left logical shift register – triggered on the pulse
│
└─ sim/
  └─ sim_top.vhd       		-- blinky simulator
``` 
 
## Setup Instructions
```
# -----------------------------------------------------------------
# 1. Get the repo
# -----------------------------------------------------------------
git clone git@gitlab.kit.edu:kit/ipe-sdr/teaching/kseta-fpga/ipe-fpga-courses.git
git checkout debugging-exercise
```
## Exercise 1: Build a project with a shift register and PS for Zynq

![shift_led_right_with_ps_zynq](https://github.com/ahmedqamesh/digital-design-toolbox/blob/main/.assets/images/ex1_create_shift_led_right.png)

```
source ex1_create_blinky_shift_right.tcl
# or vivado -source ex1_create_blinky_shift_right.tcl
```

## Exercise 2: Generate an Integrated Logic Analyzer (ILA)

![shift_led_right_with_ps_zynq](https://github.com/ahmedqamesh/digital-design-toolbox/blob/main/.assets/images/ex2_adding_ILA.png)

Run the following script from the tcl window in Vivado
```
source ex2-adding-ILA.tcl
# or vivado -source ex2-adding-ILA.tcl
```
## Exercise 3: Generate a Virtual Input/Output (VIO)

![shift_led_right_with_ps_zynq](https://github.com/ahmedqamesh/digital-design-toolbox/blob/main/.assets/images/ex3-adding-VIO.png)

Run the following script from the tcl window in Vivado
```
source ex3-adding-VIO.tcl
# or vivado -source ex3-adding-VIO.tcl
```

