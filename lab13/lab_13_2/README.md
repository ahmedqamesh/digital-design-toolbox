# Lab 13 – Partial Reconfiguration
Partial Reconfiguration (partial reconfiguration) is becoming more and more common in today's FPGA applications. This tutorial is an example to illustrate the operation process of partial reconfiguration.<br>
The vivado version used here is 2020.2.<br> 
1. Decide which module you need to treat as a **Reconfiguration Module** and replace it with **another module**.
* **In our example**: we replaces **_shift_led_right_** (RM) with **_shift_led_left_**.
> **A Reconfigurable Module (RM)** is the netlist or HDL description that is implemented within a reconfigurable partition.
2. Start the configuration of Partial Reconfiguration<br>
a. First open the project and add one of the Reconfiguration Modules to the project. <br>
b. Choose to add all the modules to the project.<br>
c. Select **Tools**->**Enable Dynamic Function eXchange**.<br>
<p align="center"><img width="500" height="400"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/af3c4aef-216e-4667-bbcb-9b992e0dbabf"></p>
Vivado will generate a warning that this step cannot be undone.<br>

* The project now is a DFX project, which means that it allows for the reconfiguration of modules within an active design. 

3. Define the top module using a block design (top_reconfig) .<br>
a. An HDL wrapper and its output product must be generated.<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/b4715e33-d088-4c76-9b6c-3b7cea37cec5"></p>
b. Select the (RM) module (**shift_led_left**) within the block designand right click. Select **Create hierarchicay** (we call it here **partition**).<br>
c. Validate the block design.<br>
d. Select the hierarchical block and right click. Select **Create Block Design Container** (we call it here **shift_left**).<br> 
* This will convert the hierarchical block into a Block Design Container.<br> 
> **Block Design Container (BDC)** is a new feature in Vivado IP Integrator which allows one or more block designs to be instantiated inside another block design. It allows also DFX flow.

4. Enabled for DFX  of the new **Block Design Container**  (partition).<br>
a. validate the block design.<p align="center"><img width="400" height="300"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/579bad2f-cefc-4b1e-b16c-2d5259ef78b3"></p>
b. Run implementation.<br>

5. Partition Boundaries Planning.<br>
a. Highlight the Leaf Cells by right click on the **partition** and choose **Highlight the Leaf Cells**.

b. Create a partition boundary to prevent any timing or routing problems. With right click Floorplanning and Draw Pblock is selected on the cell to create a partition boundary to pull. This should not be too big and not too small.<p align="center"><img width="400" height="300"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/16152236-4885-45d3-94a4-f382e2979933"></p>
c. As seen in the previous fig. it is essential to uncheck **IS_SOFT** ( IS_SOFT can cause the partition boundary to not be strictly adhered to).<br>
d. Check **RESET_AFTER_RECONFIG** ( **RESET_AFTER_RECONFIG** initializes the logic to its initial values after reconfiguration).<br>
e. Switch **SNAPPING_MODE** to ON (**SNAPPING_MODE** allows Vivado to automatically adjust a region in relation to resource requirements in case a bigger design will replace it).<br>
f. Create a **DRC report**: to do this, select **Reports** in the menu bar at the top and then **Report DRC**. A window will open,
in which the following rules should be activated (Just choose PR).<p align="center"><img width="400" height="600"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/3cba317c-4334-4b3e-b5dc-3d81594a4b4c"></p>

6. **Create reconfigurable module**.<br> 
a. go back to the top BD and select partition. In the sub-block properties and setting the config **ENABLE_DFX** to 1.<br> 
b. Right  click on the **Block Design Container**.<br> 
c. Select **create reconfigurable module**. <br> 
d. Add another circuit **shift_right** (This will open an empty block design with the input and output ports).<br> 
e. Add Here you can add  **shift_right_led** module.<br> 

7. Explore the new **Block Design Container**:<br>
a. A double click on the container opens the options.
b. The option  **Freeze the boundary of this container** should be **selected** (Selecting this option will lock the boundaries and parameter propagation from the top-level BD will not take place).<br>
c. Two Block designs (**shift_left** and **shift_right**) should be assigned to it (a new BD can be added from block designs that are present in the project can always be added).
* In this example the **shift_left** BD is used as the master instance<p align="center"><img width="750" height="650"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/b2711dc9-8f13-4576-bc9d-5997d8b90981"></p>

8. Prepare the Design for Implementation <br>
a. In the Flow Navigator, click the **Generate Block Design** command under the IP INTEGRATOR header. <br>
b. In the resulting dialog box, Out of context per IP or Out of context per Block Design, then click Generate (Global will revert to Out of context per Block Design to confirm to DFX rules).<p align="center"><img width="400" height="500"  src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/d28b8ced-754e-4bb4-8b63-64875731f481"></p>

9. Running the Dynamic Function eXchange Wizard.<br>
a. select Tools in the menu bar and then **Dynamic Function eXchange Wizard**. another window will open where the reconfigurable modules (**shift_left_inst_0** and **shift_right_inst_0**) and their partition are shown.<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/62fb4f3a-e247-457e-bcbf-0a46f5b7a34f"></p>
b. Click **Next**, then choose **automatically create configurations**<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/4d8f1cae-3374-4daa-a241-bac46af5503e"></p>
c. Edit Configurations via the **Plus** symbol (another configuration can be added). Then on the list click and select **greybox**<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/cc16045f-aeb0-4536-bb0a-2e6aebb3898c"></p>
d. Click **Next**, then choose **automatically create configurations**<p align="center"><img src="https://github.com/ahmedqamesh/local_workspace/assets/8536649/70ab3615-586f-4bfd-ab8d-3e77912c66ea"></p>
e. Click **Finish**<br>

10. Implement the Design and Generate the bitstream (Vivado tool will generate several bitstreams, in this example 
<pre><code>
#left_reg partition 
top_reconfig.runs/impl_1/top_reconfig_bd_i_partition_shift_left_inst_0_partial.bit #only the dynamic part
top_reconfig.runs/impl_1/top_reconfig_bd_wrapper.bit # Static and dynamic part
#right_reg partition
top_reconfig.runs/child_0_impl_1/top_reconfig_bd_i_partition_shift_right_inst_0_partial.bit
top_reconfig.runs/child_0_impl_1/top_reconfig_bd_wrapper.bit
#Empty partition
top_reconfig.runs/child_1_impl_1/top_reconfig_bd_i_partition_greybox_partial.bit
top_reconfig.runs/child_1_impl_1/top_reconfig_bd_wrapper.bit
</code></pre>
As seen, each dynamic bitstream is accompined by another full bitstream that holds both

##Notes
* ecc/crc frame_ecce2 adding it to the design
* crcerror/eccerror correct_and_continue does it still raise the flag?
* continious scrubbing of external flash
* icape2 seu hardness?
* icape2 iprog/alternatives? 
* internal configuration register access through different primitives?
* simulate an SEU on the FPGA configuration memory (with icap maybe?)
* partial reconfiguration of the mopshub design
* decoupling ip dfx but no triplication?

# Useful Xilinx Documentation:
* https://docs.xilinx.com/r/en-US/ug470_7Series_Config/7-Series-FPGAs-Configuration-User-Guide
* https://docs.xilinx.com/r/en-US/ug953-vivado-7series-libraries/

