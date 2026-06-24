`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 18:29:10
// Design Name: 
// Module Name: fifo_mem
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


module fifo_mem(
//Write domain inputs
input w_clk,
input [2:0]w_add,
input write,
input full,
input [15:0]data_in,
//Read Domain inputs
input r_clk,
input [2:0]r_add,
input read,
input empty,
output reg [15:0]data_out

    );

reg [15:0] mem [7:0];

always@(posedge w_clk)
begin
if(write&&!full)
mem[w_add] <= data_in;
end

always@(posedge r_clk)
begin
if(read&&!empty)
data_out<=mem[r_add];
end

endmodule
