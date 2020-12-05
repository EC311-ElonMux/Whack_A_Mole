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
    output [7:0] mole
    );
    
    wire [2:0] outmole;
    reg [7:0] imole;
    wire [2:0] otime;
    
    //Randomly  outputs a number from 0-7
    lfsr molepicker(
        .CLK100MHZ(CLK100MHZ),
        .rand(outmole)
        );
    lfsr_2 moletimepicker(
        .CLK100MHZ(CLK100MHZ),
        .rand(otime)
        );
        
    //Module that takes these outputs and converts to a mole
    mole_control controller(
        .CLK100MHZ(CLK100MHZ),
        .difficulty(difficulty),
        .enable(enable), 
        .mole(imole),
        .moletime(otime),
        .omole(mole)
    );
    
    always @(posedge CLK100MHZ)
    begin
        case (outmole)
            3'b000 : 
            begin
                imole = 8'b00000001;
            end
            3'b001 : 
            begin
                imole = 8'b00000010;
            end
            3'b010 :  
            begin
                imole = 8'b00000100;
            end
            3'b011 : 
            begin
                imole = 8'b00001000;
            end
            3'b100 : 
            begin
                imole = 8'b00010000;            
            end
            3'b101 : 
            begin
                imole = 8'b00100000;
            end
            3'b110 : 
            begin
                imole = 8'b01000000;
            end
            3'b111 : 
            begin
                imole = 8'b10000000;
            end
        endcase
    end
    
endmodule
