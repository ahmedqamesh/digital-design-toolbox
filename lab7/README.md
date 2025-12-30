## Lab 7 – Memory
The Lab focuses on memory-based design in digital systems [ROM (Read-Only Memory) and RAM (Random-Access Memory) usage ]
## Lab 7 – RAM and ROM-Based Counters

This lab covers ROM- and RAM-based designs, including a sine wave generator, simple RAM, and Gray counter.  
All designs use **VHDL** and are intended for **FPGA implementation**, with buttons/sliders as inputs and LEDs as outputs.

---

## Lab 71 – Sine Wave Generator Using ROM

**File:** `lab71_sine_rom.vhd`  
**Description:**  
Sine wave generator implemented using a ROM and a free-running counter.

- Inputs:
  - `Reset`
  - `Clock` (defined correctly in XDC)
- Outputs:
  - 8-bit sine wave sample output

**Design Details:**
- ROM type: read-first
- ROM size: 16 words × 8 bits
- ROM stores one full period of a sine wave
- Address input driven by a free-running binary counter
- Output sine wave frequency equals 1/16 of the sampling frequency
- Reset initializes the internal counter
- Testbench verifies correct sequencing of ROM samples

---

## Lab 72 – 3-bit × 4-word RAM

**File:** `lab72_ram_3x4.vhd`  
**Description:**  
Simple RAM with 3-bit data width and 4-word depth.

- Inputs:
  - `Address` (2-bit)
  - `Data_in` (3-bit)
  - `WE` (write enable button)
  - `Clock` (defined correctly in XDC)
- Outputs:
  - `Data_out` (3-bit, LEDs)

**Design Details:**
- RAM type: read-first
- Write operation controlled by `WE`
- Output always shows contents of currently addressed RAM cell

---

## Lab 73 – 4-bit Gray Counter Using ROM

**File:** `lab73_gray_counter_rom.vhd`  
**Description:**  
4-bit Gray code counter implemented using a ROM.

- Inputs:
  - `Reset`
  - `Clock`
- Outputs:
  - 4 LEDs displaying the Gray counter value

**Design Details:**
- Counter updates approximately once per second
- Reset sets counter output to zero
- ROM stores Gray code values for all counter states
- ROM address driven by a binary counter
- Design decomposed into:
  - Binary counter
  - Clock divider / enable generation
  - ROM lookup for Gray code
- Counter bit #1 used for autocheck

