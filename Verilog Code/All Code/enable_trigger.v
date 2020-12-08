`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/24/2020 08:46:42 PM
// Design Name: 
// Module Name: enable_trigger
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


module enable_trigger(
    input CLK100MHZ,
    input [1:0] difficulty,
    output enable
    );
        
   reg [28:0] currentcount = 0;
   reg renable = 0;
   
   //Detects when inputs goes from low to high
   low_edge_detect ah0(
        .level_in(renable), 
        .clk(clk),
        .n_reset(1),
        .level_out(enable)
    );
    
    always @(posedge CLK100MHZ)
    begin
        currentcount = currentcount + 1;
        case (difficulty)
            2'b00: 
            begin
                if(currentcount == 200000000)//2 seconds between new mole
                begin
                    renable = 1;
                end
                else if (currentcount > 200000050)
                begin
                    renable = 0;
                    currentcount = 0;
                end
                else
                begin
                   renable = 0;
                end
            end
            2'b01:
            begin
                if(currentcount == 120000000) //1.2 second between mole
                begin
                    renable = 1;
                end
                else if (currentcount > 120000050)
                begin
                    renable = 0;
                    currentcount = 0;
                end
                else
                begin
                    renable = 0;
                end
            end
            2'b10:
            begin
                if(currentcount == 80000000)//0.8 seconds between mole
                begin
                    renable = 1;
                end
                else if (currentcount > 80000050)
                begin
                    renable = 0;
                    currentcount = 0;
                end
                else
                begin
                    renable = 0;
                end
            end
            default:
            begin
                renable = 0;
            end
        endcase
    end
    
endmodule
