`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/30/2020 10:21:42 PM
// Design Name: 
// Module Name: score_tracker
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


module score_tracker(
    input CLK100MHZ,
    input enable,
    input gamestart,
    input gameend,
    input [7:0] input_pos,  //The input of mole's position
    input [7:0] switch_hit, //Input of which switch that changed
    output reg molehit,     //Output indicating if a mole has been hit
    output reg [7:0] cmole = 0,
    output reg [7:0] score = 0  // the current score
    );
    always @(posedge CLK100MHZ)
    begin
        //If the game has not started/reset then reset score and moles
        if(gamestart == 0)
        begin
            cmole = 0;
            score = 0;
            molehit = 0;
        end
        else // Game has been started and in the process of playing
        begin
            if(gameend == 1) //If game has played all the way through
            begin
                molehit = 0;
                cmole = 0;
            end
            else
            begin          
                if(enable == 1) //Indicates that new mole is output
                begin
                    cmole = input_pos;
                    molehit = 0;
                end
                else 
                begin
                    if(switch_hit[0] == cmole[0] && switch_hit[0] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[0] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[1] == cmole[1] && switch_hit[1] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[1] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[2] == cmole[2] && switch_hit[2] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[2] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[3] == cmole[3] && switch_hit[3] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[3] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[4] == cmole[4] && switch_hit[4] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[4] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[5] == cmole[5] && switch_hit[5] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[5] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[6] == cmole[6] && switch_hit[6] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[6] = 0;
                        molehit = 1;
                    end
                    if(switch_hit[7] == cmole[7] && switch_hit[7] > 0) //Only triggers if a switch has been hit
                    begin
                        score = score +1;
                        cmole[7] = 0;
                        molehit = 1;
                    end
                    
                end
            end
        end
    end
endmodule