`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.12.2022 22:49:14
// Design Name: DFX Isolation Layer
// Module Name: decoupling
// Project Name: Partial Reconfiguration Lab
// Target Devices: Zynq-7000 (xc7z010clg400-1)
// Description: Decouples the Reconfigurable Partition during bitstream loading.
//              Uses BUFGCE for glitch-free clock gating.
// 
//////////////////////////////////////////////////////////////////////////////////
module decoupling(
    input enable,
    input [7:0] led,
    input clk,
    input rstn,
    
    output [7:0] ledd,
    output clkd,
    output rstnd    
    );
    
    reg en;
    
    always @ (posedge clk) begin
        if (enable) begin
            en <= 1;
        end else begin
            en <= 0;
        end
    end
    
    assign ledd = en ? led : 0;
    assign clkd = en ? clk : 0;
    assign rstnd = en ? rstn : 0;
    
endmodule
