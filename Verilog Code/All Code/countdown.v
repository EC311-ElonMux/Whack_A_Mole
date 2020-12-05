`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2020 07:28:38 PM
// Design Name: 
// Module Name: countdown
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


module countdown(
    input CLK100MHZ,
    input gamestart,
    input [5:0] gametime,
    output reg [5:0] timeleft,
    output reg gameend = 1
    );
    
    reg [26:0] count = 0; //27 bits to count up to 100 million
    
    initial begin
        count = 0;
        gameend = 0;
    end
    
    always @ (posedge CLK100MHZ)
    begin
    count = count + 1;
    //If game hasnt started then no need to count
        if(gamestart == 0)
        begin
            timeleft = gametime;
            gameend = 0;
        end 
        else 
        begin
            if(count == 100000000) // If count == 100 million, then reset count+decrement time seconds
            begin
                if(timeleft > 1)    
                begin
                    timeleft = timeleft - 1;
                    count <= 0;
                end
                else if (timeleft == 1)
                begin
                    timeleft = timeleft -1;
                    count <= 0;
                    gameend <= 1;
                end
                else
                begin
                    count <= 0;
                end
            end
        end
    end
    
endmodule