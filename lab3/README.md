# Lab 3 – Multiplexers, Demultiplexers, Switches, and 7-Segment Display
This lab covers binary counters, bidirectional counters, clock dividers, and a ring counter with ~1 s period.  
All designs use **VHDL** and are intended for **FPGA implementation**, with buttons/switches as inputs and LEDs as outputs.

---

# Overview
This lab exercise implements and tests various digital components on the **Basys3 FPGA board**, including:

1. **4-to-1 Multiplexer (lab31)** – selects one of 4 single-bit inputs to a single output LED.
2. **1-to-4 Demultiplexer (lab32)** – routes a single-bit input to one of 4 LED outputs based on 2-bit address.
3. **4×4 Single-Bit Switch (lab33)** – connects one of 4 input buttons to one of 4 output LEDs using instances of multiplexer and demultiplexer.
4. **4×1 Multiplexer to Seven-Segment Display (lab34)** – displays one of four 4-bit binary inputs on the rightmost digit of a 7-segment display.
5. **Testbench for Demultiplexer (test_bench.vhd)** – simulates `lab32` with a toggling data input and cycling address inputs.

---

## Lab31 – 4-to-1 Multiplexer
- **Inputs:** 4 buttons (`din`) and 2 switches (`addr`)
- **Output:** 1 LED (`dout`)
- **Function:** Selects which button is routed to the LED based on the address.
- **Notes:** Implemented using a process with a `case` statement.

## Lab32 – 1-to-4 Demultiplexer
- **Input:** 1 button (`din`) and 2 switches (`addr`)
- **Outputs:** 4 LEDs (`dout`)
- **Function:** Routes the single button input to the selected LED based on the address.
- **Notes:** All other outputs are set to `'0'`.

## Lab33 – 4×4 Switch
- **Inputs:** 4 buttons (`din`), 2 sets of 2-bit switches (`addr1`, `addr2`)
- **Outputs:** 4 LEDs (`dout`)
- **Function:** Routes one of the four buttons to one of the four LEDs based on two addresses.
- **Implementation:** Instantiates `lab31` as a multiplexer and `lab32` as a demultiplexer; uses internal signal for connection.

## Lab34 – 4×1 Multiplexer to Seven-Segment Display
- **Inputs:** 4 4-bit switches (`din0`, `din1`, `din2`, `din3`) and 2-bit address (`addr`)
- **Outputs:** 7-segment signals (`dout`) and anode control (`an`)
- **Function:** Displays the selected 4-bit input on the rightmost digit of the 7-segment display.
- **Notes:** Uses a function to convert binary values to 7-segment encoding (supports 0–F).

## Testbench – lab32
- **Purpose:** Simulates the demultiplexer.
- **Data Input:** Alternating `101010...` sequence.
- **Address Input:** Cycles `"00"`, `"01"`, `"10"`, `"11"` continuously.
- **Verification:** Observe the output LED corresponding to the address to verify correct routing.

---

## File List
| File        | Description |
|------------|-------------|
| `lab31.vhd` | 4-to-1 multiplexer implementation |
| `lab32.vhd` | 1-to-4 demultiplexer implementation |
| `lab33.vhd` | 4×4 switch using lab31 and lab32 components |
| `lab34.vhd` | 4×1 multiplexer to seven-segment display |
| `test_bench.vhd` | Testbench for lab32 |

---

## Usage
1. Load the VHDL files into **Vivado**.
2. Synthesize and implement each design for the **Basys3 FPGA board**.
3. Connect inputs:
   - Buttons for `din` inputs.
   - Switches for `addr` inputs.
4. Observe outputs:
   - LEDs for lab31, lab32, and lab33.
   - 7-segment display for lab34.
5. For simulation, run `test_bench.vhd` to verify `lab32` behavior.

---

## Notes
- All designs use **processes and case statements** for combinational logic.
- The 7-segment display is **common-anode**, active-LOW for segments.
- The exercise demonstrates practical usage of **multiplexers, demultiplexers, and signal routing** in FPGA design.

