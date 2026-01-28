// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Jan 28 13:47:53 2026
// Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/aq/git/courses/digital-design-toolbox/lab13/lab_13_1/vivado/lab_13_led_right/led-blink.gen/sources_1/bd/top_led_bd/ip/top_led_bd_blink_counter_0_0/top_led_bd_blink_counter_0_0_stub.v
// Design      : top_led_bd_blink_counter_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blink_counter,Vivado 2022.2" *)
module top_led_bd_blink_counter_0_0(clk, led)
/* synthesis syn_black_box black_box_pad_pin="clk,led" */;
  input clk;
  output led;
endmodule
