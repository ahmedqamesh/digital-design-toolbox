//////////////////////////////////////////////////////////////////////////////////
// Module Name: reset_sync
// Description: Synchronizes an asynchronous active-low reset to a clock domain.
//              Prevents BD 41-1348 and metadata-stability.
//////////////////////////////////////////////////////////////////////////////////

module reset_sync (
    (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 clk CLK" *)
    input  wire clk,
    input  wire ext_rstn, // Asynchronous input (e.g., from pin)
// This attribute tells Vivado this reset is now associated with 'clk'
    (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 sync_rstn RST" *)
    (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW, ASSOCIATED_CLOCK clk" *)
    
    output wire sync_rstn // Synchronized output
);

    reg [1:0] sync_reg = 2'b00;

    always @(posedge clk) begin
        if (!ext_rstn) begin
            sync_reg <= 2'b00;
        end else begin
            sync_reg <= {sync_reg[0], 1'b1};
        end
    end

    assign sync_rstn = sync_reg[1];

endmodule
