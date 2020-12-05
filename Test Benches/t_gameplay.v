`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2020 09:55:48 PM
// Design Name: 
// Module Name: t_gameplay
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


module t_gameplay();


    reg CLK100MHZ = 0;
    
    reg [1:0] levl = 2'b00;
    reg [2:0] input_pos = 3;
    wire [2:0] mole_pos1;
    wire [5:0] score;
    
    gameplay game_play(
        .levl(levl),
        .CLK100MHZ(CLK100MHZ),
        .input_pos(input_pos),
        .score(score),
        .mole_pos1(mole_pos1)
    );
    
    always
    begin
        #1 CLK100MHZ = ~CLK100MHZ;
    end
    
endmodule
