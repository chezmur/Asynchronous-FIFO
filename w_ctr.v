`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 20:47:16
// Design Name: 
// Module Name: w_ctr
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


module w_ctr(
input w_clk,
input w_reset,
input write,
input [3:0]r_grayptr,
output reg [3:0]w_grayptr,
output [2:0]w_add,
output reg full
    );
    

    wire [3:0]w_graycode;
    wire [3:0]w_ptr_next;
    wire full_flag;
    
    reg [3:0]w_ptr;
    
    
    assign w_ptr_next = w_ptr +(write&&!full);
    assign w_graycode = w_ptr_next ^ (w_ptr_next>>1);
    assign full_flag = (w_graycode == {~r_grayptr[3:2], r_grayptr[1:0]});
    assign w_add = w_ptr[2:0];
    always@(posedge w_clk or posedge w_reset)
    begin
        if(w_reset)    
        begin
            w_ptr<= 4'd0;
            full<=0;
            
            w_grayptr<=4'd0;
        end               

        else 
        begin
             
                    w_ptr <= w_ptr_next;                     //Write Pointer gets updated
                               
                    w_grayptr <= w_graycode;              //Graycode output gets updated
                    full<=full_flag;
        end
    
    end
endmodule
