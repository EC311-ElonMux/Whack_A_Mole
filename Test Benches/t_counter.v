`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2020 07:04:55 PM
// Design Name: 
// Module Name: t_counter
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


module t_counter();
reg CLK100MHZ = 0;
reg [1:0] difficulty = 0;
wire[31:0] currentcount;
wire enable;

enable_trigger count(
    .CLK100MHZ(CLK100MHZ),
    .currentcount(currentcount),
    .difficulty(difficulty),
    .enable(enable)
    );
    
    always begin
    #2 CLK100MHZ = ~CLK100MHZ;
    end
    
endmodule
