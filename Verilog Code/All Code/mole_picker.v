`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2020 03:13:26 PM
// Design Name: 
// Module Name: mole_picker
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


module mole_picker(
    input CLK100MHZ,
    input enable, //Input that tells the module to send out a mole
    input [1:0] difficulty,
    input [7:0] molehit,
    output [7:0] mole
    );
    
    //Wire that contains mole in LFSR format
    wire [2:0] randmole;
    //Wire that contains the time for the mole to stay up
    wire [2:0] randtime;
    //Register containing translation from LFSR to 8 bit encoding
    reg [7:0] imole;
    
    //Randomly outputs a number from 0-7, 3 bit encoding.
    lfsr molepicker(
        .CLK100MHZ(CLK100MHZ),
        .rand(randmole)
        );
    lfsr_2 moletimepicker(
        .CLK100MHZ(CLK100MHZ),
        .rand(randtime)
        );
        
    //Module that takes these outputs and converts to mole positions in 8 bit encoding
    //With their own counters that control when they drop down by themselves
    mole_control controller(
        .CLK100MHZ(CLK100MHZ),
        .difficulty(difficulty),
        .enable(enable), 
        .mole(imole),
        .moletime(randtime),
        .molehit(molehit),
        .omole(mole)
    );
    
    //Always block that translates from LFSR to 8 bit
    always @(posedge CLK100MHZ)
    begin
        //LFSR to Min Bit Width
        case (randmole)
            3'b000 : imole = 8'b00000001;
            3'b001 : imole = 8'b00000010;
            3'b010 : imole = 8'b00000100;
            3'b011 : imole = 8'b00001000;
            3'b100 : imole = 8'b00010000;
            3'b101 : imole = 8'b00100000;
            3'b110 : imole = 8'b01000000;
            3'b111 : imole = 8'b10000000;
        endcase
    end
    
endmodule
