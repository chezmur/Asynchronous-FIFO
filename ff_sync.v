`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.06.2026 13:15:27
// Design Name: 
// Module Name: ff_sync
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


module ff_sync(
input clk,
input reset,
input [3:0]d,
output reg [3:0]q

    );
    reg [3:0]q0;
    always@(posedge clk)
    begin
    
    if(reset)
    begin
    q<=4'd0;
    q0<=4'd0;
    end
    
    else
    begin
    q0<=d;
    q<=q0;
    end
    
    end
    
endmodule
