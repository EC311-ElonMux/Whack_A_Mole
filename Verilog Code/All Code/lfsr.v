`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 07:23:09 PM
// Design Name: 
// Module Name: lfsr
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


module lfsr(
    input CLK100MHZ,
    output [2:0] rand
    );
    //Creating a 20 register LSFR.
    //Will repeat itself after 2^20 - 1 cycles
    //Polynomial is x^20 + x^17 + 1, so have taps from 20 and 17
    //Initial seed is going to be the value of 0001 0100 1101 1110 0001 
    reg [19:0] chain = 20'b00010100110111100001 ;
    reg XNOR;
    
    
    always @(posedge CLK100MHZ)
    begin
        chain <= {chain[18:0], XNOR};
    end
    
    always @(*)
    begin
        XNOR <= chain[19] ^~ chain[16];
    end
    
    //Output the bits from various locations
    //Output from 3rd, 15th, and 6th register
    assign rand[2] = chain[2];
    assign rand[1] = chain[14];
    assign rand[0] = chain[5];
    
endmodule
