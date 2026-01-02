## Lab 10.1 – Fixed-Point to Floating-Point Converter

**File:** `lab10_1_fixed_to_float.vhd`  
**Description:**  
Converter module from fixed-point integer to IEEE 754 single-precision floating-point format.

- **Inputs:**
  - `Int_in` (1,16,0)
  - `Clock`
- **Outputs:**
  - `Float_out` (IEEE 754 single precision)  

**Design Details:**
- Converts (1,16,0) fixed-point integer to floating-point format.
- Operation has a **2-clock-cycle delay**: output appears two cycles after input.
- Fixed-point zero maps to **positive floating-point zero**.
- Testbench provides multiple integer inputs to verify correct floating-point conversion.

