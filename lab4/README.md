# VHDL Digital Design Labs

This repository contains a collection of VHDL laboratory exercises focused on digital arithmetic, logic operations, and FPGA-oriented design.  
All designs are written in **VHDL** and are intended for **FPGA implementation**, using switches (sliders) as inputs and LEDs or seven-segment displays as outputs.

---

## Lab 41 – 3-bit Unsigned Summator

**File:** `lab41.vhd`  
**Description:**  
A 2-input summator for **3-bit unsigned integers**.

- Two 3-bit inputs (sliders)
- One 4-bit output (LEDs) representing the sum

This design demonstrates basic unsigned binary addition.

---

## Lab 42 – Signed Summator with Constant

**File:** `lab42.vhd`  
**Description:**  
Summator of a **7-bit signed integer** and a constant value (**cnst = 3**).

- One 7-bit signed input `x`
- One 8-bit signed output `y`
- MSB is treated as the **sign bit**
- Correct signed arithmetic is applied

---

## Lab 43 – Cyclic Left Shifter (2 bits)

**File:** `lab43.vhd`  
**Description:**  
A cyclic left shifter by **2 bits**.

- One 4-bit input (sliders)
- Two 4-bit outputs (LEDs):
  - Original input value
  - Shifted result

Least Significant Bits (LSBs) of the output correspond to the original number.

---

## Lab 44 – 2-bit Unsigned Multiplier with Seven-Segment Display

**File:** `lab44.vhd`  
**Description:**  
Multiplier for **two 2-bit unsigned integers**.

- Two 2-bit inputs (sliders)
- One 7-bit output driving a **seven-segment display**
- Seven-segment LEDs labeled **a–g**


---

## Lab 45 – Logical, Arithmetic, and Cyclic Shift Unit

**File:** `lab45.vhd`  
**Description:**  
A multifunction shift device supporting logical, arithmetic, and cyclic shifts.

**Inputs:**
- 1-bit shift direction (`lr`)
- 2-bit shift command (`cmd`)
- 6-bit input data (`din`)

**Outputs:**
- 6-bit original input (`dout_din`)
- 6-bit shifted result (`dout_shifted`)

Unused command combinations leave the input unchanged.

---

## Lab 46 – 16-bit Signed Multiplier Using Xilinx IP Core

**Description:**  
Multiplier for **two 16-bit signed numbers**, created using **Xilinx IP Core Generator**.

Two configurations are analyzed:

### 1. DSP-Based Implementation
- `Use Mults` mode enabled
- Implemented entirely using **embedded DSP blocks**
- No LUTs or flip-flops used

### 2. LUT-Based Implementation
- `Use LUTs` mode enabled
- Implemented using **LUTs and flip-flops only**
- No DSP blocks used

**Result:**  
The number of **DSP elements and LUTs** used in both configurations is compared as part of the task.

---

## Lab 47 – Constant Multiplier (5/7)

**File:** `lab47.vhd`  
**Description:**  
Multiplier of an **8-bit unsigned integer** by the rational constant **5/7**.

- Output width: **10 bits**
- Includes **2 fractional bits**
- Binary approximation of 5/7 is selected
- **Truncation** rounding method is applied
- Result is valid for all 8-bit unsigned inputs

---

## References and Learning Resources

All designs are based on well-established digital design principles and FPGA documentation:

1. IEEE Standard VHDL Language Reference  
   https://standards.ieee.org/ieee/1076/6700/

2. Digital Design and Computer Architecture – Harris & Harris  
   https://www.elsevier.com/books/digital-design-and-computer-architecture/harris/9780123944245

3. Xilinx Vivado Design Suite – IP Catalog User Guide  
   https://docs.xilinx.com/r/en-US/ug896-vivado-ip

4. Seven-Segment Display Fundamentals  
   https://learn.sparkfun.com/tutorials/using-seven-segment-displays/all

5. Signed and Unsigned Arithmetic in VHDL  
   https://docs.xilinx.com/r/en-US/ug901-vivado-synthesis/Arithmetic-Operators

---

## Author

**Ahmed Qamesh**  
Date: 28/12/2025
