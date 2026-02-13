`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:      KIT - Institute for Data Processing and Electronics (IPE)
// Engineer:     Ahmed Qamesh
// 
// Create Date:  17.10.2025 21:15:52
// Design Name:  ICAP UART Controller
// Module Name:  uart_interface
// Project Name: Lab 13 - Partial Reconfiguration (DFX)
// Target Devices: Red Pitaya STEMlab 125-14 (Zynq-7010)
// Tool Versions: Vivado 2020.1+
// 
//////////////////////////////////////////////////////////////////////////////////


module uart_interface(
    input clk,
    input rstn,
    input uart_txd_in,
    input new_data_tx, //Ready for transmission
    input [7:0] data_tx, //Data for transmission

    output uart_rxd_out,
    output busy,
    output new_data_rx, //Data received
    output [7:0] data_rx //Received data 
);
    //8 data bits, 1 stop bit, no parity, 115200 baud, sampling @ 100 clk cycles
    //  clk_per_bit = 868 to achieve 115,200 Baud with a 100 MHz clock:
    //  clk_per_bit = 100 to achieve 115,200 Baud with 11,520,000 Hz clock:
    parameter clk_per_bit = 868;
    parameter ctr_size = 7; //8 bit data size
    
    wire rst;
    
    assign rst = !rstn; 

    // Receive serial data
    serial_rx #(.CLK_PER_BIT(clk_per_bit), .CTR_SIZE(ctr_size)) serial_rx_inst (
        .clk(clk),
        .rst(rst),
        .rx(uart_txd_in),
        .new_data(new_data_rx), //Data received
        .data(data_rx) //Received data
    );

    // Transmit serial data
    serial_tx #(.CLK_PER_BIT(clk_per_bit), .CTR_SIZE(ctr_size)) serial_tx_inst (
        .clk(clk),
        .rst(rst),
        .tx(uart_rxd_out),
        .tx_block(0), //Unused
        .busy(busy),
        .new_data(new_data_tx), //Ready for transmission
        .data(data_tx) //Data for transmission
    );
    



endmodule
