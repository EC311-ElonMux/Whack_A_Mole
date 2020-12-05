`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2020 04:22:29 PM
// Design Name: 
// Module Name: time_to_bcd_to_disp
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


module time_to_bcd_to_disp(
    input [5:0] in,
    output [6:0] digit0,
    output [6:0] digit1
    );
    
    reg [3:0] dig1,dig2;

    integer i;
    always@(in) begin
        //Set up 3 registers to hold the 3 BCDs.
        dig1 = 4'b0000;
        dig2 = 4'b0000;
        
        for (i=5; i>=0; i=i-1) begin
            if(dig1 >= 4'b0101)
                dig1 = dig1 + 4'b0011;
            if(dig2 >= 4'b0101)
                dig2 = dig2 + 4'b0011;
                
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

endmodule
