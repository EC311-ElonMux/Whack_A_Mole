`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 05:09:02 PM
// Design Name: 
// Module Name: score_to_bcd_to_disp
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


module score_to_bcd_to_disp(
    input [7:0] in,
    output [6:0] digit0,
    output [6:0] digit1,
    output [6:0] digit2
    );
    
    reg [3:0] dig1,dig2,dig3;

    integer i;
    always@(in) begin
        //Set up 3 registers to hold the 3 BCDs.
        dig1 = 4'b0000;
        dig2 = 4'b0000;
        dig3 = 4'b0000;
        
        for (i=7; i>=0; i=i-1) begin
            if(dig1 >= 4'b0101)
                dig1 = dig1 + 4'b0011;
            if(dig2 >= 4'b0101)
                dig2 = dig2 + 4'b0011;
            if(dig3 >= 4'b0101)
                dig3 = dig3 + 4'b0011;
            
            dig3 = dig3 << 1;
            dig3[0] = dig2[3];
            dig2 = dig2 << 1;
            dig2[0] = dig1[3];
            dig1 = dig1 <<1;
            dig1[0] = in[i];
        end        
    end
    bcd_to_disp conv1(
        .in(dig1),
        .digit(digit0)
    );
    bcd_to_disp conv2(
        .in(dig2),
        .digit(digit1)
    );
    bcd_to_disp conv3(
        .in(dig3),
        .digit(digit2)
    );

endmodule