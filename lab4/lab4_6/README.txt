lab46:
Description:Multiplier for two 16-bit signed numbers using Xilinx IP Core Generator (IP catalog). 
Use Xilinx IP Core Generator (IP catalog) to create the IP core.  
Check in the synthesis/implementation results:
1. in 'Use Mults' mode in IP Core the multiplier is totally implemented in the embedded DSP element and no flip-flops and LUTs are used
2. in the 'Use LUTs' mode the multiplier is implemented using general purpose logic resources - LUTs and flip-flops only.
The number of LUTs and DSP elements for both versions of multiplier is the result of the task. 
