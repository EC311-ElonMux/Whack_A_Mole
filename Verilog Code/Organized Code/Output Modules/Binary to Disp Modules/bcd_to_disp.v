`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2020 06:16:23 PM
// Design Name: 
// Module Name: bcd_to_disp
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


module bcd_to_disp(
    input [3:0] in,
    output reg [6:0] digit
    );
    always @(*) begin
        digit =  7'b1111111;
        case(in) 
            4'b0000 : begin// 0 
                digit = 7'b0000001;
                end
            4'b0001 : begin//1
                digit = 7'b1001111;
                end
            4'b0010 : begin //2
                digit = 7'b0010010;
                end
            4'b0011 : begin //3
                digit = 7'b0000110;
                end
            4'b0100 : begin //4
                digit = 7'b1001100;
                end
            4'b0101 : begin //5
                digit = 7'b0100100;
                end 
            4'b0110 : begin //6
                digit = 7'b0100000;
                end
            4'b0111 : begin //7
                digit = 7'b0001111;
                end
            4'b1000 : begin //8
                digit = 7'b0000000;
                end
            4'b1001 : begin //9
                digit = 7'b0000100;
                end
            endcase
        end
endmodule
