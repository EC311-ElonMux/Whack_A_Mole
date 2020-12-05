`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2020 04:13:30 PM
// Design Name: 
// Module Name: level_change_detect
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


module level_change_detect(
    input level_in, clk,
    output level_out
    );
    
    wire high, low;
    
    high_edge_detect ah0(
        .level_in(level_in), 
        .clk(clk),
        .n_reset(1),
        .level_out(high)
    );
    
    low_edge_detect al0(
        .level_in(level_in), 
        .clk(clk),
        .n_reset(1),
        .level_out(low)
    );
    
    or(level_out,high,low);
    
endmodule
