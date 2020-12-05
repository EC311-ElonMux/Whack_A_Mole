`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/19/2020 07:37:05 PM
// Design Name: 
// Module Name: t_lfsr
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


module t_lfsr();

reg clk = 0;
reg [6:0] counter = 0;
wire [2:0] out;

lfsr test(
    .CLK100MHZ(clk),
    .rand(out)
    );

always
begin
    #10 clk = ~clk;
        counter = counter +1;
    if(counter == 100)
    begin
        $finish;
    end
end

endmodule