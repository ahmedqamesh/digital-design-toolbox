## Lab 81 – Convolutional Encoder (7,5) Using FSM

**File:** `lab81_conv_encoder_fsm.vhd`  
**Description:**  
Convolutional encoder for (7,5) code implemented using a finite state machine (FSM).
![lab81](https://github.com/ahmedqamesh/digital-design-toolbox/blob/main/assets/lab81.png)
- Inputs:
  - `Reset`
  - `Clock`
  - `Data_in` (1-bit)
- Outputs:
  - `Dout` (2-bit coded output)

**Design Details:**
- FSM style: Mealy/Moore, two-process description
- Initial encoder state: all zeros
- Initial output: all zeros
- XOR of branch 7 → MSB of output
- XOR of branch 5 → LSB of output
- Each input bit produces 2 output bits
- Testbench uses an all-ones input sequence
- Testbench generates reset and clock signals
- Simulation verifies correct output waveforms
