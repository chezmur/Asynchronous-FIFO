`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.06.2026 15:51:36
// Design Name: 
// Module Name: tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb;
//Write domain values
reg w_clk;
reg w_reset; 
reg [15:0]data_in;
reg write;
wire full;

//Read Domain Values
reg  r_clk;
reg r_reset;
wire [15:0]data_out;
reg read;
wire empty;



top uut (
        // Write Domain Ports
        .w_clk    (w_clk),
        .w_reset  (w_reset),
        .write    (write),
        .data_in  (data_in),
        .full     (full),

        // Read Domain Ports
        .r_clk    (r_clk),
        .r_reset  (r_reset),
        .read     (read),
        .data_out (data_out),
        .empty    (empty)
);

always #5 w_clk = ~w_clk;
always #10 r_clk = ~r_clk;
integer i=0;

initial begin
    w_clk = 0;
    r_clk = 0;
    w_reset = 1;
    r_reset = 1;
    write = 0;
    read = 0;
    data_in = 16'd0;
    #40
    
    w_reset = 0;
    r_reset = 0;
    
    fork 
        begin
            while(i<24)
            begin
                @(posedge w_clk);
                if(!full)
                begin
                    write = 1;
                    data_in = 16'd0000+i;
                    i=i+1;
                end
                else  write = 0;
            end
            write = 0;
        end
        
        begin
            wait (empty == 1'b0);
            while(!empty) begin
             @(posedge r_clk); 
                if (!empty) read = 1;
                else read = 0;
            end
            end
    join
    
    #100
    $finish;
end


endmodule
