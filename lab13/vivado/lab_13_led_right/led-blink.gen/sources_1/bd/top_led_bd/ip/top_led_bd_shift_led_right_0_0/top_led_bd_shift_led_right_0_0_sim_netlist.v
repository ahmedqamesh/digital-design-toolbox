// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Wed Jan 28 13:47:54 2026
// Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode funcsim
//               /home/aq/git/courses/digital-design-toolbox/lab13/lab_13_1/vivado/lab_13_led_right/led-blink.gen/sources_1/bd/top_led_bd/ip/top_led_bd_shift_led_right_0_0/top_led_bd_shift_led_right_0_0_sim_netlist.v
// Design      : top_led_bd_shift_led_right_0_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z010clg400-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "top_led_bd_shift_led_right_0_0,shift_led_right,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* ip_definition_source = "module_ref" *) 
(* x_core_info = "shift_led_right,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module top_led_bd_shift_led_right_0_0
   (clk,
    enable_shift,
    led_o);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk, FREQ_HZ 50000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, CLK_DOMAIN top_led_bd_processing_system7_0_0_FCLK_CLK0, INSERT_VIP 0" *) input clk;
  input enable_shift;
  output [7:0]led_o;

  wire clk;
  wire enable_shift;
  wire [7:0]led_o;

  top_led_bd_shift_led_right_0_0_shift_led_right U0
       (.clk(clk),
        .enable_shift(enable_shift),
        .led_o(led_o));
endmodule

(* ORIG_REF_NAME = "shift_led_right" *) 
module top_led_bd_shift_led_right_0_0_shift_led_right
   (led_o,
    enable_shift,
    clk);
  output [7:0]led_o;
  input enable_shift;
  input clk;

  wire clk;
  wire enable_shift;
  wire [7:0]led_o;
  wire \led_o_r[6]_i_1_n_0 ;
  wire \led_o_r[7]_i_1_n_0 ;

  LUT2 #(
    .INIT(4'h8)) 
    \led_o_r[6]_i_1 
       (.I0(led_o[0]),
        .I1(enable_shift),
        .O(\led_o_r[6]_i_1_n_0 ));
  LUT3 #(
    .INIT(8'hB8)) 
    \led_o_r[7]_i_1 
       (.I0(led_o[0]),
        .I1(enable_shift),
        .I2(led_o[7]),
        .O(\led_o_r[7]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[0] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[1]),
        .Q(led_o[0]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[1] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[2]),
        .Q(led_o[1]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[2] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[3]),
        .Q(led_o[2]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[3] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[4]),
        .Q(led_o[3]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[4] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[5]),
        .Q(led_o[4]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[5] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[6]),
        .Q(led_o[5]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b0)) 
    \led_o_r_reg[6] 
       (.C(clk),
        .CE(enable_shift),
        .D(led_o[7]),
        .Q(led_o[6]),
        .R(\led_o_r[6]_i_1_n_0 ));
  FDRE #(
    .INIT(1'b1)) 
    \led_o_r_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(\led_o_r[7]_i_1_n_0 ),
        .Q(led_o[7]),
        .R(1'b0));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
