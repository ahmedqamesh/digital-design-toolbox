// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
// Date        : Sun Dec 28 19:50:09 2025
// Host        : aq-21me000tge running 64-bit Ubuntu 24.04.3 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ mult_gen_0_sim_netlist.v
// Design      : mult_gen_0
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "mult_gen_0,mult_gen_v12_0_18,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "mult_gen_v12_0_18,Vivado 2022.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (CLK,
    A,
    B,
    P);
  (* x_interface_info = "xilinx.com:signal:clock:1.0 clk_intf CLK" *) (* x_interface_parameter = "XIL_INTERFACENAME clk_intf, ASSOCIATED_BUSIF p_intf:b_intf:a_intf, ASSOCIATED_RESET sclr, ASSOCIATED_CLKEN ce, FREQ_HZ 10000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0" *) input CLK;
  (* x_interface_info = "xilinx.com:signal:data:1.0 a_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME a_intf, LAYERED_METADATA undef" *) input [1:0]A;
  (* x_interface_info = "xilinx.com:signal:data:1.0 b_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME b_intf, LAYERED_METADATA undef" *) input [1:0]B;
  (* x_interface_info = "xilinx.com:signal:data:1.0 p_intf DATA" *) (* x_interface_parameter = "XIL_INTERFACENAME p_intf, LAYERED_METADATA undef" *) output [3:0]P;

  wire [1:0]A;
  wire [1:0]B;
  wire CLK;
  wire [3:0]P;
  wire [47:0]NLW_U0_PCASC_UNCONNECTED;
  wire [1:0]NLW_U0_ZERO_DETECT_UNCONNECTED;

  (* C_A_TYPE = "0" *) 
  (* C_A_WIDTH = "2" *) 
  (* C_B_TYPE = "0" *) 
  (* C_B_VALUE = "10000001" *) 
  (* C_B_WIDTH = "2" *) 
  (* C_CCM_IMP = "0" *) 
  (* C_CE_OVERRIDES_SCLR = "0" *) 
  (* C_HAS_CE = "0" *) 
  (* C_HAS_SCLR = "0" *) 
  (* C_HAS_ZERO_DETECT = "0" *) 
  (* C_LATENCY = "1" *) 
  (* C_MODEL_TYPE = "0" *) 
  (* C_MULT_TYPE = "0" *) 
  (* C_OUT_HIGH = "3" *) 
  (* C_OUT_LOW = "0" *) 
  (* C_ROUND_OUTPUT = "0" *) 
  (* C_ROUND_PT = "0" *) 
  (* C_VERBOSITY = "0" *) 
  (* C_XDEVICEFAMILY = "artix7" *) 
  (* c_optimize_goal = "1" *) 
  (* downgradeipidentifiedwarnings = "yes" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_mult_gen_v12_0_18 U0
       (.A(A),
        .B(B),
        .CE(1'b1),
        .CLK(CLK),
        .P(P),
        .PCASC(NLW_U0_PCASC_UNCONNECTED[47:0]),
        .SCLR(1'b0),
        .ZERO_DETECT(NLW_U0_ZERO_DETECT_UNCONNECTED[1:0]));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2022.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
C/5Mh/YfQK+xvzcE2CGtETuPBeLiyJko5tNa9mMrxf8GTM/0mqqMZ+vYDutRWwlkGLoBJ0ubJ2JM
hSYnF9uwe22zt9N5LFdSRZxMoN1o6c2PdIJyFX9QiG+G0k5olg9eEzsigfNpc9kE5brQ+zVlZ0BV
klXrD05hnhWq+ZJys/w=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
nhu9PWmxjSOqIMDTXJV+4qo0FPiBJCygcWuN/bfQzqY2oUKKM8378Fb2UT55vg8n4G10m17vIBgN
+Wy6buZC7GhxULhm+9qKdG61k/7yfhvEyQUBzudlOBUaIUk7ZAeE6SGH26C8h1WgBFSBJBshielG
kmSnefelvtJmMqQynpqanYQE+2/nM45zHVEXMtgEl8NM+ittmjnbmsjMG+VmkcpjTiitr8v+SSgM
RUwmbOuITmj1SaUWkm+IJTDW4bnipSqF0iXScNDVurlEpJm4oLvKdM1ottYIIcXR6+Fa5dGLRubI
LjYe8sQ49kCgXyYdFk4JbJANd3OdYx/U0839pw==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
oLOGB6O+5m7WVYa3aB6L+szJIkfErI3K6c0Z4Xd6Cc9YLnPbUoTR/E3N7bfACANo1RtCR1KrgOT9
QRzSpMaWuUNpHkoBWkpOvvqpujGg7n+KNjtsXpeAJDMZq0hpkCFMyTIbglQJfVL4ds7LBIztVpT+
XPSPp0rHN6MvUs/o0sQ=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
b3H7uIeGCIVDgn3FEC671rtMncRXCjR9RBfw6OuWzlyF5wFk4ElX2tB2gwrWUb2Com7mmOGUcT8m
dWBnb4fgFyaI4CcP0cDJZ1RBfKHzHsnVnUtydmh17jwFjOhuG4oqUfxDBVOziYixuf8xqsPD1kIx
AAGgp8eCh/3TTWsXe8MqUHFhWLAFBHiM+g9tiFtJxHBAyX5v+8avU7rSRQOteILiCl/aE/ZTg1U1
TZRYZm9xCtpTek8kcIXycf8cf1vmkeYfjYqsPcKnLXjswHKcSvCTgJBvdf6/NU1hADbYz5krZkN6
cP43YF8Es6pXZ5MZxRyvAulHMEmC1vBKEV4L2Q==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
hNojWTRiv5xJXFjSuajQtOI6VJWjSVIasMceSy/iOADWwlykMyPQqJwBZv9vgyG2lsbPzupIZZOt
sY4+VQKC49eSzzBiqlXJuuRgTh4eG5Sj78MJPFi8Z4JHdANbBDjcsfEyFcFinPG8C+6ObqSWv3sT
fh66lPvK05YKvRong1DaI4yDI+LeF0XCXF9jXawejRWPqZyQQRofEUn3P6/HL3rOQ9WrwtOgLOh4
eld6oolD6hKjdN6z7BtfypoG1+c9GyXB8peQYSYy2mC/UhPM2He7IScIeEh8FKNZOETke8ShtPdd
8KijcT3YF0mZbR+JEAYmPRwljDtmkR1nmLPJ5g==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2021_07", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
vNoNhNOiLgedrjzCipcIWa66MfCSJrQLJjludHrumavTx1oA+4ROcs5sx9EIY16AxVabVb6PSj/B
6g7QMmhWOHO5XWCGsLGngpWlMaz7FPJIrMDMH0FqHULVZgn+ytshKF3OiHU9DKUfGAkx2o6xKR8J
v2jv+NfcjYrjtp1y5L007VCIwcNtkKJJXaDQjJxbYYOB0uzxwQIXRo+SEib+esXDvZD6Ikc55nl4
wE0bh+voYoBpOgDoGMiOgpg8YJnYWFS+aCT4aHJqb0+12fK4HJHyN34p2V9mna/PBHxQttZEjbwL
t5GBDgl9IiQOzvoyMMwa3D9yJPGWNEJTOJaUbw==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
UWO1yL0EL8CXhMsuZN3v7pq9vqI3Hx8I4AdpxQRWS35PlhqAcAjYeBVG9msiPa5PzWiULLQfpvtc
jErP46XJGtGsEiYBMIv0Sy4sw0m1buhgPQC3ebkJgAk3bspWMUEsvYaN1IfFXabxN+RYANz3tJ2Y
oHgpnvvpm8OrlQUsgkwwn7FgVUGvBHoaj3vopWTMROl61+OL1aj+VLKQvwlZuA30e5yG7JAT159Y
e+xbMUxDz+W4RK0kPzZxnlU6X2HGieEEqGVzuAHvbaqUsRHZF294LqHX4u2WuTM74rvH69Kh5wL6
jYEYgCU9ma4gBAA98slrAnjNqn4bY2f9DG+now==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
iXm1XonW4ervg3D4DUJphNzJ6vN12GMfC70OgzuNrZ2kX9fFpWbL5IBPnCTMNnNWQy0GGe6hvPmb
j7EpeR3MIhJR5BcSdHMR4BVvSo0AEM+UmieNsuTc7dTw++8EucnKuLvloLldJo1b29DO+LZfqkGP
M9z2zkXfSVOqQRNGzxLR5gGJLHNfjxGz8MOIJ3HaDDAbO1eEgkWN9ZeesYwJrgERNSubcEhjLzl8
dVi5A1iTEa6WcsQ7XpUZkZTrHlM+/ZUnuZelrt2eHwx7m5XAZzHXbVz6YPrxLVx80IcJzqkykiEp
dMotGjzHWB0+tNy/gRFTUB5rpFt3LtF2+O9mZEf4nNluB9zmYqmvU9T4zeiID3NuEe4WOZjruJ0Q
gBPt5imaHECnAFxZ7QWVRp1rGkX8eS8I5qjfVJm8+pKqvjc1MGkAv2Vh4RG+n36yShUI44QIDYIY
zqj5fbexc27+CEmjJEFy/Cwik0yDg15IXyQYIkVLbBBdXfuQsGR6lI0A

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
e2TCE/IVroj0BoMutEWWgUoHdqmqHN4Vq1aGvl8tHLqPMgKPyusaF/EU/+MvsIWjDyZip1MmWOcx
jQu5Oy8IWt51LTRIQJ0x+kU2WDMNmZRHSdVAR8ORyzaV+63xJ+1FR21OuVBTsdN0zc5+xPOZn251
Ih7Dkw8u+guep7Yr4t3jgw+4crsiBVVM+5WJvUb5HgZZLCirWswHL2EOSwrlxmh1UfYzXoib6RPE
Ra/hqZSom0279kPBw6Fx+riPQZSw7jyFJal9sJMpp1RQHG0wo0DgA0V8Ot4NHxUc9Fwq4+hnCyfi
r2lvbn1yjpQbLFKBIZrlQAud1cQVbPc9abtdFA==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-PREC-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
BAg6eTeHQqJAuUaIt+9xR5Hb06YCXxs7FFbcxRjRYq8B8zOIMy/CeWwnGruRk2D8el/uMutpOm93
+XM2u4Aa+qC61n1gDRyJO6o62GAgvFC1KGg64GyFJ82aa4AdzxvBhlFt4F+bQD857S2/Tmte0mE7
r0YmqpngZQwegPcIqBC5tgrqYjg9IOm80SjNMcTdA44IC7coVZMJPCKjEr+VYlSScblpcdaw5dZD
alvWufNmQsInmkDYSWqitZIOUHnx93LWspr6O4pgAKHtBf3nOyZGjxDWBJLLwOkU5d9wdL3E0jMI
6wQwjww4HXa7RoO8tjvUDjegxqv9lQo18nXwhQ==

`pragma protect key_keyowner="Synplicity", key_keyname="SYNP15_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
SMTt62qkqgIx6RI82u4JAL1cc0upSdacTwta2zzH4IChqtkttG3T0oVyljsneFZr6xoP3wSX/hjo
jRD9j9SvQOoWlECm0yetc1hTNiwLd6c8d22glKZ0fu+QsaKFinOgQfcVCcZYuuMvFoUqmLnjO8Gv
nWgaxGpBFPl39nE0ZayYpsc48EozcGAYAASzUuQjnBI2FbSev7d3dI2PgSqgkKN0q5UpNSCVZ7qJ
EIeZyo78Qb5iwT8m1ysuPxllrfUi1zhOCdvjoUjueBOQ44BvfxlZgvCEXgfpgY/CmnEfYCm3gDB8
ereFAb8gvxyFHABVJcp5L7m7B+GEFkSYkjW97Q==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 11264)
`pragma protect data_block
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
`pragma protect end_protected
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
