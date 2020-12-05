`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/21/2020 12:29:25 PM
// Design Name: 
// Module Name: top
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
//////////////////////////////////////////////////////////////////////////////


module top_square(
    input wire CLK,             // board clock: 100 MHz on Arty/Basys3/Nexys
    input wire RST_BTN,
    input wire [7:0] random_num,         
    output wire VGA_HS_O,       // horizontal sync output
    output wire VGA_VS_O,       // vertical sync output
    output wire [3:0] VGA_R,    // 4-bit VGA red output
    output wire [3:0] VGA_G,    // 4-bit VGA green output
    output wire [3:0] VGA_B     // 4-bit VGA blue output
    );

    wire rst = ~RST_BTN;    // reset is active low on Arty & Nexys Video
    

    // generate a 25 MHz pixel strobe
    reg [15:0] cnt;
    reg pix_stb;
    always @(posedge CLK)
        {pix_stb, cnt} <= cnt + 16'h4000;  // divide by 4: (2^16)/4 = 0x4000

    wire [9:0] x;  // current pixel x position: 10-bit value: 0-1023
    wire [8:0] y;  // current pixel y position:  9-bit value: 0-511

    vga640x480 display (
        .i_clk(CLK),
        .i_pix_stb(pix_stb),
        .i_rst(rst),
        .o_hs(VGA_HS_O), 
        .o_vs(VGA_VS_O), 
        .o_x(x), 
        .o_y(y)
    );

    // Four overlapping squares
    wire SQ1,SQ2,SQ3,SQ4,SQ5,SQ6,SQ7,SQ8,SQ9,SQ10,SQ11,SQ12,SQ13,SQ14,SQ15,SQ16,SQ17,SQ18;
    reg green;
    assign SQ1 = ((x > 100) & (y > 60) & (x < 540) & (y < 420)) ? 1 : 0;
    assign SQ2 = ((x > 180) & (y > 60) & (x < 280) & (y < 420)) ? 1 : 0; // Red Square
    assign SQ3 = ((x > 360) & (y > 60) & (x < 460) & (y < 420)) ? 1 : 0; // Red Square
    assign SQ4 = ((x > 100) & (y > 280) & (x < 181) & (y < 340)) ? 1 : 0; // Red Square
    assign SQ5 = ((x > 100) & (y > 140) & (x < 181) & (y < 200)) ? 1 : 0; // Red Square
    assign SQ6 = ((x > 279) & (y > 280) & (x < 361) & (y < 340)) ? 1 : 0; // Red Square
    assign SQ7 = ((x > 279) & (y > 140) & (x < 361) & (y < 200)) ? 1 : 0; // Red Square
    assign SQ8 = ((x > 459) & (y > 280) & (x < 540) & (y < 340)) ? 1 : 0; // Red Square
    assign SQ9 = ((x > 459) & (y > 140) & (x < 540) & (y < 200)) ? 1 : 0; // Red Square
    assign SQ10 = ((x > 100) & (y > 60) &  (x < 181) & (y < 140)) ? 1 : 0; // Green Square
    assign SQ11 = ((x > 100) & (y > 200) & (x < 181) & (y < 280)) ? 1 : 0; // Green Square
    assign SQ12 = ((x > 100) & (y > 340) & (x < 181) & (y < 420)) ? 1 : 0; // Green Square
    assign SQ13 = ((x > 279) & (y > 60 ) & (x < 361) & (y < 140)) ? 1 : 0; // Green Square
    assign SQ14 = ((x > 279) & (y > 200) & (x < 361) & (y < 280)) ? 1 : 0; // Green Square
    assign SQ15 = ((x > 279) & (y > 340) & (x < 361) & (y < 420)) ? 1 : 0; // Green Square
    assign SQ16 = ((x > 459) & (y > 60 ) & (x < 540) & (y < 140)) ? 1 : 0; // Green Square
    assign SQ17 = ((x > 459) & (y > 200) & (x < 540) & (y < 280)) ? 1 : 0; // Green Square
    assign SQ18 = ((x > 459) & (y > 340) & (x < 540) & (y < 420)) ? 1 : 0; // Green Square
    
    
 assign VGA_R[3] = SQ1 - SQ2 - SQ3 - SQ4 - SQ5 - SQ6 - SQ7 - SQ8 - SQ9;
 assign VGA_G[3] = green;
  
  always @ (*)
  begin 
    green = 0;
    if(random_num[0] == 1)
        begin
            green = green + SQ10;
        end
    if(random_num[1] == 1)
        begin
            green = green + SQ11;
        end
    if(random_num[2] == 1)
        begin
            green = green + SQ12;
        end
    if(random_num[3] == 1)
        begin
            green = green + SQ13;
        end
    if(random_num[4] == 1)
        begin
            green = green + SQ14;
        end
    if(random_num[5] == 1)
        begin
            green = green + SQ15;
        end
    if(random_num[6] == 1)
        begin
            green = green + SQ16;
        end
    if(random_num[7] == 1)
        begin
            green = green + SQ17;
        end
  end 
    
    
endmodule

