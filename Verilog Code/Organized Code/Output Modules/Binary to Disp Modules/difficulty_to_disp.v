`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2020 07:40:16 PM
// Design Name: 
// Module Name: difficulty_to_disp
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


module difficulty_to_disp(
    input [1:0] in,
    output reg [6:0] digit
    );
    always @(*) begin
        digit =  7'b1111111;
        case(in) 
            2'b00 : begin// 0 
                digit = 7'b0000001;
                end
            2'b01 : begin//1
                digit = 7'b1001111;
                end
            2'b10 : begin //2
                digit = 7'b0010010;
                end
            2'b11 : begin //3
                digit = 7'b0000110;
                end
            endcase
        end
endmodule
