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
    input enable,       //Signal that moles updated
    input gamestart,    //Signal that game started
    input gameend,      //Signal that game ended
    input [7:0] input_pos,  //The input of mole's position
    input [7:0] switch_hit, //Input of which switch was hit
    output reg [7:0] molehit = 0,   //Output indicating which mole has been hit
    output reg [7:0] cmole = 0, //Output of mole that is displayed to FPGA/VGA
    output reg [7:0] score = 0  //the current score
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
                if(enable == 1) //Indicates that new mole is output, so update values
                begin
                    cmole = input_pos;
                    molehit = 0;
                end
                else 
                begin
                    //Checks if the switch that went high matches a mole currently high                   
                    if(switch_hit[0] == cmole[0] && switch_hit[0] == 1) //Only triggers if switch 0 has been hit
                    begin
                        score = score + 1;
                        cmole[0] = 0;
                        molehit = 8'b00000001;
                    end
                    if(switch_hit[1] == cmole[1] && switch_hit[1] == 1) //Only triggers if switch 1 has been hit
                    begin
                        score = score + 1;
                        cmole[1] = 0;
                        molehit = 8'b00000010;
                    end
                    if(switch_hit[2] == cmole[2] && switch_hit[2] == 1) //Only triggers if switch 2 has been hit
                    begin
                        score = score + 1;
                        cmole[2] = 0;
                        molehit = 8'b00000100;
                    end
                    if(switch_hit[3] == cmole[3] && switch_hit[3] == 1) //Only triggers if switch 3 has been hit
                    begin
                        score = score + 1;
                        cmole[3] = 0;
                        molehit = 8'b00001000;
                    end
                    if(switch_hit[4] == cmole[4] && switch_hit[4] == 1) //Only triggers if switch 4 has been hit
                    begin
                        score = score + 1;
                        cmole[4] = 0;
                        molehit = 8'b00010000;
                    end
                    if(switch_hit[5] == cmole[5] && switch_hit[5] == 1) //Only triggers if switch 5 has been hit
                    begin
                        score = score + 1;
                        cmole[5] = 0;
                        molehit = 8'b00100000;
                    end
                    if(switch_hit[6] == cmole[6] && switch_hit[6] == 1) //Only triggers if switch 6 has been hit
                    begin
                        score = score + 1;
                        cmole[6] = 0;
                        molehit = 8'b01000000;
                    end
                    if(switch_hit[7] == cmole[7] && switch_hit[7] == 1) //Only triggers if switch 7 has been hit
                    begin
                        score = score + 1;
                        cmole[7] = 0;
                        molehit = 8'b10000000;
                    end 
                end
            end
        end
    end
endmodule