`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.06.2026 15:08:19
// Design Name: 
// Module Name: top
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


module top(
//Write Domain Inputs
input w_clk,
input w_reset,
input write,
input [15:0]data_in,
output full,

//Read Domain inputs
input r_clk,
input r_reset,
input read,
output [15:0]data_out,
output empty
    );
    
    wire [3:0]w_ptr;
    wire  [3:0]r_ptr;
    wire [3:0]sync_read_ptr;
    wire [3:0]sync_write_ptr;
    
    //Synching the write pointer with the read domain clock
    ff_sync read_sync(r_clk,r_reset,w_ptr,sync_write_ptr);
    
    //Synching the read pointer with the write domain clock
    ff_sync write_sync(w_clk,w_reset,r_ptr,sync_read_ptr);
    
    //Write Domain Module
    wire [2:0]write_address;
    w_ctr write_domain(w_clk, w_reset,write,sync_read_ptr,w_ptr,write_address,full);
    
    
    //Read Domain Module
    wire [2:0]read_address;
     r_ctr read_domain(r_clk, r_reset,read,sync_write_ptr,r_ptr,read_address,empty); 
    
    fifo_mem fifo(w_clk, write_address, write,full, data_in, r_clk, read_address, read, empty, data_out);
endmodule
