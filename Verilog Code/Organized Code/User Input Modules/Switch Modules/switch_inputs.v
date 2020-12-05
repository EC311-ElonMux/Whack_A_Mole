`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2020 10:45:42 PM
// Design Name: 
// Module Name: switch_inputs
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


module switch_inputs(
    input [7:0] switches,
    input CLK100MHZ,
    output [7:0] positionhit
    );
    
    level_change_detect sw0(
        .level_in(switches[0]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[0])
    );
    
    level_change_detect sw1(
        .level_in(switches[1]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[1])
    ); 
    
    level_change_detect sw2(
        .level_in(switches[2]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[2])
    ); 
    
    level_change_detect sw3(
        .level_in(switches[3]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[3])
    ); 
    
    level_change_detect sw4(
        .level_in(switches[4]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[4])
    ); 
    
    level_change_detect sw5(
        .level_in(switches[5]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[5])
    ); 
    
    level_change_detect sw6(
        .level_in(switches[6]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[6])
    );
    
    level_change_detect sw7(
        .level_in(switches[7]), 
        .clk(CLK100MHZ),
        .level_out(positionhit[7])
    );
    
endmodule
