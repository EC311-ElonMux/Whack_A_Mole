`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2020 12:10:12 AM
// Design Name: 
// Module Name: high_edge_detect
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


module high_edge_detect(
    input level_in, clk, n_reset,
    output level_out
    );
    reg  delay_reg  ;
    always @(posedge  clk,  negedge  n_reset)
    begin
        if  ( n_reset == 0)
        begin
            delay_reg  <=  0;
        end
        else begin
            delay_reg  <=  level_in;
        end
    end
       assign  level_out  =  (delay_reg)  &  (~level_in);
endmodule