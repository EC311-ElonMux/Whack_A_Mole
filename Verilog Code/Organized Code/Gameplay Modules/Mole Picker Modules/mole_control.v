`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 03:42:58 PM
// Design Name: 
// Module Name: mole_control
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


module mole_control(
    input CLK100MHZ,
    input [1:0] difficulty,
    input enable, 
    input [7:0] mole,
    input [2:0] moletime,
    output [7:0] omole
    );
    
    mole_timer mole0(
            .difficulty(difficulty),
            .mole(mole[0]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[0])
            );
    mole_timer mole1(
            .difficulty(difficulty),
            .mole(mole[1]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[1])
            );
    mole_timer mole2(
            .difficulty(difficulty),
            .mole(mole[2]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[2])
            );
    mole_timer mole3(
            .difficulty(difficulty),
            .mole(mole[3]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[3])
            );
    mole_timer mole4(
            .difficulty(difficulty),
            .mole(mole[4]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[4])
            );
    mole_timer mole5(
            .difficulty(difficulty),
            .mole(mole[5]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[5])
            );
    mole_timer mole6(
            .difficulty(difficulty),
            .mole(mole[6]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[6])
            );
    mole_timer mole7(
            .difficulty(difficulty),
            .mole(mole[7]),
            .enable(enable),
            .moletime(moletime),
            .CLK100MHZ(CLK100MHZ),
            .omole(omole[7])
            );
    
endmodule
