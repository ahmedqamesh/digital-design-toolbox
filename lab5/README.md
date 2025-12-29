# VHDL Digital Design Labs

This repository contains a collection of VHDL laboratory exercises focused on digital logic and FPGA-oriented design.  
All designs are written in **VHDL** and are intended for **FPGA implementation**, using switches (sliders) as inputs and LEDs as outputs.

---

## Lab 51 – JK Flip-Flop with Enable

**File:** `lab51_jk_ff.vhd`  
**Description:**  
JK flip-flop with enable, asynchronous clear, and preset inputs.

- Inputs:
  - `J`, `K` (sliders)
  - `Enable`, `Clear`, `Preset` (buttons)
  - `Clock` (100 MHz)
- Output: `Q` (LED)

---

## Lab 52 – 16-bit Cyclic Shift Register

**File:** `lab52_shift_reg.vhd`  
**Description:**  
16-bit right cyclic shift register with synchronous reset.

- Inputs:
  - `Reset` (button, initializes to `1011111010101111`)
  - `Clock` (100 MHz)
- Outputs: 16 LEDs (register contents)

---

## Lab 53 – 8-bit Cycle Delay Block

**File:** `lab53_delay_block.vhd`  
**Description:**  
8-bit cycle delay block with simulation testbench.

- Inputs:
  - `CLK`
  - `Din` (8-bit)
- Output: `Dout` (8-bit, first cycle undefined)

---

## Lab 54 – Pseudo-Random Sequence Generator (WiMAX)

**File:** `lab54_prsg_wimax.vhd`  
**Description:**  
Pseudo-random sequence generator with XOR output.

- Inputs:
  - `Reset` (initial state `101010001110110`)
  - `Clock`
- Output: `Dout` (sequence bit)

---

## Lab 55 – Convolutional Encoder (171,133)

**File:** `lab55_conv_encoder.vhd`  
**Description:**  
Convolutional encoder using PRSG from Lab 54 as input.

- Inputs:
  - `Reset`, `Clock`
- Output: 2-bit encoded data (`MSB = 133 branch`, `LSB = 171 branch`)
- Testbench: verifies timing diagrams and first few output bits

---

## References

1. IEEE Standard VHDL Language Reference  
   https://standards.ieee.org/ieee/1076/6700/

2. Digital Design and Computer Architecture – Harris & Harris  
   https://www.elsevier.com/books/digital-design-and-computer-architecture/harris/9780123944245

3. Xilinx Vivado Design Suite – User Guides  
   https://docs.xilinx.com

---

## Author

**Ahmed Qamesh**  
Date: 29/12/2025

