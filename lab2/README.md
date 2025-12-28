## Lab 2 – 3-to-8 Decoder (lab21)

**Description:**  
Implements a **3-input to 8-output binary decoder**.  
Three switches select one of eight outputs, and exactly one LED is turned ON corresponding to the binary input value.

**Key Features:**
- Pure combinational logic
- One-hot output encoding
- Direct switch-to-LED mapping

---

## Lab 3 – 8-Input Encoder (lab22)

**Description:**  
Implements an **8-input encoder** with validity checking.  
If exactly one input switch is active, the encoder outputs its binary index on the lower three LEDs.  
Forbidden input combinations produce an error code.

**Key Features:**
- One-hot input validation
- Valid output: `dout(3) = 0`
- Invalid input output: `dout = "1000"`
- Non-priority encoder

---

## Lab 4 – Binary to Gray Code Converter (lab23)

**Description:**  
Converts a 4-bit binary number into its corresponding **Gray code** representation.  
Binary input is set using switches, and the Gray code output is displayed on LEDs.

**Key Features:**
- Standard Binary → Gray conversion
- Minimal XOR-based logic
- Fully combinational design

# Lab 5 – 4-bit Binary to Seven-Segment Converter (lab24)
---
**Description:**  
This lab implements a 4-bit binary to 7-segment display converter on the **Basys3 FPGA board**.  
- **Input:** 4 switches (`din`)  
- **Output:** Rightmost 7-segment display (`dout`)  
- **Digit Control:** `an <= "1110"` (only rightmost digit enabled)  
- **Notes:** Common-anode display with active-LOW cathodes; decimal point (DP) not used.

# Lab 5 – Integer log2 Function for 5-bit Input (lab25)
---
**Description:**  
This lab implements an integer `log2(x)` function for 5-bit non-negative integers on the **Basys3 FPGA board** using a priority encoder. The result is displayed on the rightmost 7-segment display.  

- **Input:** 5 switches (`din`) representing a binary number from 0 to 31  
- **Output:** Rightmost 7-segment display (`dout`) showing the integer part of `log2(din)`  
- **Digit Control:** `an <= "1110"` (only rightmost digit enabled)  
- **Notes:** Common-anode display with active-LOW cathodes; decimal point (DP) not used.  

**Implementation Details:**  
- Uses a priority encoder to detect the highest-order ‘1’ in the input  
- Converts the resulting value to 7-segment display encoding  
- Only the rightmost digit of a 4-digit 7-segment display is enabled


