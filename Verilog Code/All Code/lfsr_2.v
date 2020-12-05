`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2020 03:20:17 PM
// Design Name: 
// Module Name: lfsr_2
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


module lfsr_2(
    input CLK100MHZ,
    output [2:0] rand
    );
    //Creating a 20 register LSFR.
    //Will repeat itself after 2^20 - 1 cycles
    //Polynomial is x^20 + x^17 + 1, so have taps from 20 and 17
    //Initial seed is going to be the value of 1001 10101011 01011111 
    reg [19:0] chain = 20'b10011010101101011111;
    reg XNOR;
    
    
    always @(posedge CLK100MHZ)
    begin
        chain <= {chain[18:0], XNOR};
    end
    
    always @(*)
    begin
        XNOR <= chain[19] ^~ chain[16];
    end
    
    //output the bits from various locations
    //Output from 3rd, 15th, and 6th register
    assign rand[2] = chain[2];
    assign rand[1] = chain[14];
    assign rand[0] = chain[5];
    
endmodule
