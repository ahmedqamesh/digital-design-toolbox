## Lab 14 - MultiBoot Mechanism
# The idea of MultiBooting
The FPGA application triggers a MultiBoot operation, causing the FPGA to reconfigure from a different bitstream. The fallback functionality allows for system recovery from any failure to load the MultiBoot image, and loads the golden image.<br>
The solution involves a flash memory that has a reserved areas to store these components:
1. The golden bitstream: stored in the upper address space (0x0) and includes: <br>
a. Address location specified  **WBSTAR** (Warm Boot Start Address) register.<br>
b. The Internal PROGRAM (**IPROG**) command. <br>
2. The MultiBoot bitstream (update) will be stored in <br>

## MultiBooting Mechanism
<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/8f157af4-db57-4989-a9f1-32b4725d2996"></p>

1. After powering up, the golden image from address 0x0.
2. The golden image triggers a MultiBoot operation.
3. The **IPROG** command loads the update bitstream from address stored in **WBSTAR**. 
4. Check for errors in the configuration:<br>
a. If configuration logic fails : Fallback occurs (e.g. Fallback triggered by CRC error)and configuration logic pulls **INIT_B** and **DONE** Low >> clears the configuration memory >> restarts the configuration process ( loading the golden bitstream at flash address 0).<br>
b. If no errors , the update bitstream will be loaded successfully.

###  **Conditions that Trigger Fallback**:
1. **IDCODE error** 
2. **Cyclic redundancy check (CRC) error**
3. **Watchdog timer timeout error**

# Preparing the Bitstreams for MultiBoot Application. 
The Bitstream needs some properties to allow multibooting, thus can be included within the constraints file for the gold image and the fallback image while preparing the project.<br>
**Step 1**: Golden image constraints<br> 
Within the constraints file for the gold image, we need to enable the fallback option. We also need to provide the location of the update image, which should be attempted to be loaded first.
<pre><code>set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property BITSTREAM.CONFIG.PROG_MODE INTERNAL [current_project]
set_property BITSTREAM.CONFIG.NEXT_CONFIG_REBOOT ENABLE [current_design]
set_property BITSTREAM.CONFIG.NEXT_CONFIG_ADDR 0x0200000 [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
</code></pre>
**Step 2**: Fallback (update) image constraints<br>For the update image, its constraint file should be as below enabling the configuration fallback but without the config address specified.
<pre><code>set_property BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE [current_design]
set_property BITSTREAM.CONFIG.PROG_MODE INTERNAL [current_project]
set_property BITSTREAM.CONFIG.NEXT_CONFIG_REBOOT ENABLE [current_design]
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
</code></pre>

**Explaination**:<br>
1. `BITSTREAM.CONFIG.CONFIGFALLBACK ENABLE` enables the Fallback option. [This enables loading the default bitstream when configuration attempt fails].
2. `CONFIG.PROG_MODE INTERNAL` allwos the FPGA to use an internal configuration mode for configuration. This means that the configuration bitstream is stored within the FPGA itself, and the FPGA will boot and configure itself upon power-up or as directed by external control signals.
3. `BITSTREAM.CONFIG.NEXT_CONFIG_REBOOT`allows the FPGA  to reboot (restart) itself automatically after loading a new configuration
4. `BITSTREAM.CONFIG.NEXT_CONFIG_ADDR` sets the start address (in **WBSTAR** register) for the next configuration image. [here We choose exactltly the midpoint of the SPI Flash, You can set this address to any other value depending on your SPI flash size]
5. `BITSTREAM.GENERAL.COMPRESS` compresses the bitstream file.
6. `BITSTREAM.CONFIG.SPI_BUSWIDTH` (By default SPI_BUSWIDTH is x1). Compared to classical SPI, which only uses one data line, Dual and Quad SPI use 2 and 4 data lines which will increase the data throughput 2 or 4 times.

### Create Memory configuration File
FPGA configuration files can be written to the Quad-SPI Flash memory (in this version it is FL128SAIF00), and setting the mode jumper [JP1] will cause the FPGA to automatically read a configuration from this device at power on.
<p align="center"><img width="500" height="300"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/579b4fb2-5065-4fc3-b709-02035458dc6f"></p>
1. create the Configuration Memory file in Vivado IDE. Click on Tools >> Generate Memory Configuration File. This will bring up the Write Memory Configuration File dialog box as shown below.<br>
2. Generate a combined MCS file which contains both images (golden and update)— with the gold image at address 0x0000_0000 and the update image at a **specified** offset 0x0100_0000.<br>

**Note** : for SPI Dual Quad (x8) Devices, calculating the target address will be as follow<br>
a. 2x 256 Mb (Megabit) Quad SPI Flash devices is equivalent to  256/8 MB (MegaByte).<br>
b. Total storage size: 2 * 32 MB = 64 MB<br>
c. Load addresses: (**Golden**: 0x0000_0000 * 2 = 0x0000_0000, **Update**: 0x0100_0000 * 2 = 0x0200_0000 <br>
d. If the size of the golden bitstream is 138Mb (128 MB <138 MB < 265 MB, it needs a space of 256 MB in the memory). Lets assume that the update image is of the same size 138 Mb which means that it needs another 265 MB. 

3. An on-board “mode” jumper (JP1) selects whether the FPGA will be programmed by the Quad-SPI flash on power up.

# Validation in Hardware
In order to test that the fallback to the gold image will work if the update image went wrong. A new MCS file includs a corrupted update image will be created.
1. Corrupt the update image by opening the file in a hex editor (e.g. hexedit in CENTOS) and modifying a value. This will cause the CRC to fail and the device to fall back to the gold image.
`hexedit mopshub_design_32bus_wrapper_feedback.bit`
<p align="center"><img width="500" height="200"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/e51ed308-7a6b-4cb3-9547-eb3a5d14bf3c"></p>
2. Save the output as mopshub_design_32bus_wrapper_feedback_corrupt.bit
3.  Save the corrupted update bitstream and generate a new flash programming file (.mcs) with this corrupted bitstream.
<p align="center"><img width="500" height="200"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/001b4284-3cf7-45cc-b3b3-84328dfdbd42"></p>

4. You can also view the BOOT_STATUS register in the Vivado tool to verify the design completed fallback successfully:
a. The BIT10_1 and BIT13_1 flags show that IPROG was attempted, and a CRC_ERROR was detected.
b. The BIT01_0 flag shows that the fallback bitstream loaded successfully. 


### Sources:
1. [MultiBoot and Fallback Using ICAP in UltraScale+ FPGAs](https://www.eeweb.com/wp-content/uploads/articles-multiboot-and-fallback-using-icap-in-ultrascale-fpgas.pdf)
2. [Spansion S25FL128S Datasheet](https://www.infineon.com/dgdl/Infineon-S25FL128S_S25FL256S_128_Mb_(16_MB)_256_Mb_(32_MB)_3.0V_SPI_Flash_Memory-DataSheet-v18_00-EN.pdf?fileId=8ac78c8c7d0d8da4017d0ecfb6a64a17&utm_source=cypress&utm_medium=referral&utm_campaign=202110_globe_en_all_integration-files)
3. [MultiBoot with 7 Series FPGAs and SPI](https://docs.xilinx.com/v/u/en-US/xapp1247-multiboot-spi).
4. [MicroZed Chronicles: FPGA MultiBoot](https://www.hackster.io/news/microzed-chronicles-fpga-multiboot-1c0a327d5940)
