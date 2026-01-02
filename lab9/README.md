## Lab 9.1 – Fixed-Point Adder

**File:** `lab911_fixed_point_adder.vhd`  
**Description:**  
Fixed-point adder handling operands with different binary-point positions.

- **Inputs:**
  - `A` (1,16,8)
  - `B` (1,8,12)
  - `Clock`
- **Outputs:**
  - `Sum` (21-bit, full precision)  

**Design Details:**
- Align binary points before addition.
- Handle overflow by extending output bit-width by 1 if needed.
- Addition in **one clock cycle**.
- Testbench uses multiple input pairs with various signs.

---

## Lab 9.2 – Fixed-Point Multiplier

**File:** `lab92_fixed_point_multiplier.vhd`  
**Description:**  
Fixed-point multiplier for (1,8,4) numbers.

- **Inputs:**
  - `A` (1,8,4)
  - `B` (1,8,4)
  - `Clock`
- **Outputs:**
  - `Product` (1,8,4)  

**Design Details:**
- Multiply in full precision, then truncate to target format.
- Multiplication in **one clock cycle**.
- Testbench uses multiple input pairs with various signs.

