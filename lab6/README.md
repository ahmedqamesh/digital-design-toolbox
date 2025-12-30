## Lab 6 – Counters and Clock Dividers

This lab covers binary counters, bidirectional counters, clock dividers, and a ring counter with ~1 s period.  
All designs use **VHDL** and are intended for **FPGA implementation**, with buttons/switches as inputs and LEDs as outputs.

---

## Lab 61 – 30-bit Binary Modulo 2³⁰ Counter

**File:** `lab61_modulo_counter.vhd`  
**Description:**  
30-bit binary counter with modulo 2³⁰ operation and synchronous reset.

- Inputs:
  - `Reset` (south button, synchronous)
  - `Clock` (100 MHz, defined in XDC)
- Outputs:
  - 8 LEDs showing the 8 MSBs of the counter
  - Bits 15–8 used for autocheck
- Counter counts continuously after reset and wraps to all zeros

---

## Lab 62 – Clock Divider with ~1 s Meander Output

**File:** `lab62_clock_divider.vhd`  
**Description:**  
Clock divider based on a binary counter, generating a 1-second period meander.

- Inputs:
  - `Clock` (onboard clock)
- Output:
  - 1 LED flashing with ~1 s period
- No reset required
- Output LED driven by a counter bit with ~1 s period
- Autocheck: period = 256 cycles, duty cycle = 2

---

## Lab 63 – 30-bit Bidirectional Modulo 2³⁰ Counter

**File:** `lab63_bidirectional_counter.vhd`  
**Description:**  
30-bit binary counter with modulo 2³⁰ operation, synchronous reset, and selectable counting direction.

- Inputs:
  - `Reset` (synchronous, initializes to all zeros)
  - `Clock`
  - `Mode` (0 – count up, 1 – count down)
- Outputs:
  - 8 LEDs showing 8 MSBs
  - Bits 8–1 used for autocheck
- Counter wraps when maximum/minimum value is reached

---

## Lab 64 – Ring Counter with ~1 s Period

**File:** `lab64_ring_counter.vhd`  
**Description:**  
Ring counter using a shifter and counter-based enable signal to produce ~1 second period.

- Inputs:
  - `Reset` (south button, synchronous for counter and shifter)
  - `Clock`
- Outputs:
  - 8 LEDs showing shifter contents
- Counter initial value: all zeros
- Shifter initial value: `00000001`, right shift (MSB → LSB)
- Enable signal generated as a 1-clock-cycle strobe once per ~1 s
- Counter bit #1 used for autocheck

