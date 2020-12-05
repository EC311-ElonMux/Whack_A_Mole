`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2020 04:20:17 PM
// Design Name: 
// Module Name: t_molepicker
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


module t_molepicker();
    reg CLK100MHZ = 0;
    reg enable = 0;
    wire [2:0] mole, moletime;
    wire pastenable;
    //Picks the moles and how long it stays
    mole_picker molepick(
        .CLK100MHZ(CLK100MHZ),
        .enable(enable),
        .pastenable(pastenable),
        .mole(mole),
        .moletime(moletime)
        );
    always
    begin
        #1 CLK100MHZ = ~CLK100MHZ;
    end
    
    always
    begin
        #10 enable = ~enable;
    end
    
endmodule
