`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12.06.2026 20:47:28
// Design Name: 
// Module Name: r_ctr
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


module r_ctr(
input r_clk,
input r_reset,
input read,
input [3:0]w_grayptr,
output reg [3:0]r_grayptr,
output [2:0]r_add,
output reg empty

    );
    wire [3:0]r_graycode;
    wire [3:0]r_ptr_next;
    wire empty_flag;
    
    
    reg [3:0]r_ptr;
    
    assign r_ptr_next = r_ptr +(read&&!empty);
    assign r_graycode = r_ptr_next ^ (r_ptr_next>>1);
    assign empty_flag = (r_graycode == w_grayptr);
    assign r_add = r_ptr[2:0];
    always@(posedge r_clk or posedge r_reset)
    begin
        if(r_reset)    
        begin
            r_ptr<= 4'd0;
            empty<=1;
            
            r_grayptr<=4'd0;
        end               

        else 
        begin
             
                    r_ptr <= r_ptr_next;                     //Write Pointer gets updated

                    r_grayptr <= r_graycode;              //Graycode output gets updated
                    empty<=empty_flag;
        end
    
    end
endmodule
