`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 03:44:46 PM
// Design Name: 
// Module Name: mole_timer
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


module mole_timer(
    input [1:0] difficulty,
    input mole,
    input enable,
    input [2:0] moletime,
    input CLK100MHZ,
    output reg omole
    );
    
    reg [28:0] currentcount = 0;
    reg [28:0] molestick = 0;
    reg [2:0] moleduration;
    
    always @(posedge CLK100MHZ)
    begin
        currentcount = currentcount + 1;
        //If a mole has just popped up
        if(enable == 1 && mole == 1)
        begin
            currentcount = 0;
            omole = 1;
            moleduration = moletime;
            //Set how long the mole should be up
            case(difficulty)
            2'b00: begin
                case(moleduration)
                    3'b000:begin
                        molestick = 260000000; //2.6 seconds
                    end
                    3'b001:begin
                        molestick = 280000000; //2.8 seconds
                    end
                    3'b010:begin
                        molestick = 300000000; //3 seconds
                    end
                    3'b011:begin
                        molestick = 320000000; //3.2 seconds
                    end
                    3'b100:begin
                        molestick = 340000000; //3.4 seconds
                    end
                    3'b101:begin
                        molestick = 360000000; //3.6 seconds
                    end
                    3'b110:begin 
                        molestick = 380000000; //3.8 seconds
                    end
                    3'b111:begin 
                        molestick = 400000000; //4 seconds
                    end
                endcase
                end
                2'b01: begin
                    case(moleduration)
                        3'b000:begin
                            molestick = 180000000; //1.8 seconds
                        end
                        3'b001:begin
                            molestick = 190000000; //1.9 seconds
                        end
                        3'b010:begin
                            molestick = 200000000; //2 seconds
                        end
                        3'b011:begin
                            molestick = 210000000; //2.1 seconds
                        end
                        3'b100:begin
                            molestick = 220000000; //2.2 seconds
                        end
                        3'b101:begin
                            molestick = 230000000; //2.3 seconds
                        end
                        3'b110:begin 
                            molestick = 240000000; //2.4 seconds
                        end
                        3'b111:begin 
                            molestick = 250000000; //2.5 seconds
                        end
                    endcase
                end
                2'b10: begin
                    case(moleduration)
                        3'b000:begin
                            molestick = 80000000; //0.8 seconds
                        end
                        3'b001:begin
                            molestick = 90000000; //0.9 seconds
                        end
                        3'b010:begin
                            molestick = 100000000; //1 seconds
                        end
                        3'b011:begin
                            molestick = 110000000; //1.1 seconds
                        end
                        3'b100:begin
                            molestick = 120000000; //1.2 seconds
                        end
                        3'b101:begin
                            molestick = 130000000; //1.3 seconds
                        end
                        3'b110:begin 
                            molestick = 140000000; //1.4 seconds
                        end
                        3'b111:begin 
                            molestick = 150000000; //1.5 seconds
                        end
                    endcase
                end
            endcase
        end
        //Check for pushing the mole down
        else if(omole == 1)
        begin
            //If the count is matching, then drop mole down
            if(currentcount >= molestick)
            begin
                omole = 0;
            end
        end
    end
    
endmodule
