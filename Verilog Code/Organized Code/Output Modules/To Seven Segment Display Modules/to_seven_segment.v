`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2020 05:31:03 PM
// Design Name: 
// Module Name: to_seven_segment
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


module to_seven_segment(
    input CLK100MHZ,
    input gamestart,
    input gameend,
    input lr,
    input [6:0] score100,
    input [6:0] score10,
    input [6:0] score1,
    input [6:0] time10,   
    input [6:0] time1, 
    input [6:0] difficultycode,
    output reg [7:0] anode,
    output reg [6:0] cathode
    );
    //Code to create a 2.6 ms refresh rate 
    reg [19:0] refresh_counter = 0;
    wire [2:0] LED_counter; 
    assign LED_counter = refresh_counter[19:17];
    //Code to create a Blinking number
    reg [26:0] blink_counter = 0;
    wire [1:0] blink;
    assign blink = blink_counter[26:25];
    
    always @(posedge CLK100MHZ)
        begin 
            refresh_counter <= refresh_counter + 1;
            blink_counter <= blink_counter + 1;
            if(LED_counter == 3'b111)
            begin  
                refresh_counter <= 0;
            end
        end

    //Now code that denotes the anode and then activates the display with cathodes
    always@(*) begin
        anode = 8'b11111111;
        cathode = 7'b1111111;
        //Differentiate between game started or not
        case(gamestart)
            //Game not started, displaying difficulty and time set
            1'b0: 
            begin
                //If blink == 0 then flash the item being set
                if(blink ==0)
                begin
                    case(lr)
                        1'b0:
                        begin
                            case (LED_counter)
                                3'b000: begin
                                    anode = 8'b11111110; 
                                    cathode = difficultycode;
                                end
                                3'b001: begin
                                    anode = 8'b11111101; 
                                    cathode = 7'b1111111;
                                end
                                3'b010: begin
                                    anode = 8'b11111011; 
                                    cathode = 7'b1111111;
                                end
                                3'b011: begin
                                    anode = 8'b11110111; 
                                    cathode = 7'b1111111;
                                end
                                3'b100: begin
                                    anode = 8'b11101111; 
                                    cathode = 7'b1111111;
                                end
                                3'b101: begin
                                    anode = 8'b11011111; 
                                    cathode = 7'b1111111;
                                end
                                3'b110: begin
                                    anode = 8'b01111111;
                                    cathode = 7'b1111111;
                                end
                            endcase
                        end
                        1'b1:
                        begin
                            case (LED_counter)
                                3'b000: begin
                                    anode = 8'b11111110; 
                                    cathode = 7'b1111111;
                                end
                                3'b001: begin
                                    anode = 8'b11111101; 
                                    cathode = 7'b1111111;
                                end
                                3'b010: begin
                                    anode = 8'b11111011; 
                                    cathode = 7'b1111111;
                                end
                                3'b011: begin
                                    anode = 8'b11110111; 
                                    cathode = 7'b1111111;
                                end
                                3'b100: begin
                                    anode = 8'b11101111; 
                                    cathode = time1;
                                end
                                3'b101: begin
                                    anode = 8'b11011111; 
                                    cathode = time10;
                                end
                                3'b110: begin
                                    anode = 8'b01111111;
                                    cathode = 7'b1111111;
                                end
                            endcase
                        end
                    endcase
                end
                else
                begin
                    case (LED_counter)
                        3'b000: begin
                            anode = 8'b11111110; 
                            cathode = difficultycode;
                        end
                        3'b001: begin
                            anode = 8'b11111101; 
                            cathode = 7'b1111111;
                        end
                        3'b010: begin
                            anode = 8'b11111011; 
                            cathode = 7'b1111111;
                        end
                        3'b011: begin
                            anode = 8'b11110111; 
                            cathode = 7'b1111111;
                        end
                        3'b100: begin
                            anode = 8'b11101111; 
                            cathode = time1;
                        end
                        3'b101: begin
                            anode = 8'b11011111; 
                            cathode = time10;
                        end
                        3'b110: begin
                            anode = 8'b01111111;
                            cathode = 7'b1111111;
                        end
                    endcase
                end
            end
            //Game Started state
            1'b1: 
            begin
                //If game ended, blink score and timer
                if(gameend == 1)
                begin
                    if(blink ==0)
                      begin
                        case (LED_counter)
                            3'b000: begin
                                anode = 8'b11111110; 
                                cathode = 7'b1111111;
                            end
                            3'b001: begin
                                anode = 8'b11111101; 
                                cathode = 7'b1111111;
                            end
                            3'b010: begin
                                anode = 8'b11111011; 
                                cathode = 7'b1111111;
                            end
                            3'b011: begin
                                anode = 8'b11110111; 
                                cathode = 7'b1111111;
                            end
                            3'b100: begin
                                anode = 8'b11101111; 
                                cathode = 7'b1111111;
                            end
                            3'b101: begin
                                anode = 8'b11011111; 
                                cathode = 7'b1111111;
                            end
                            3'b110: begin
                                anode = 8'b01111111;
                                cathode = 7'b1111111;
                            end
                        endcase
                    end
                    else
                    begin
                        case (LED_counter)
                            3'b000: begin
                                anode = 8'b11111110; 
                                cathode = score1;
                            end
                            3'b001: begin
                                anode = 8'b11111101; 
                                cathode = score10;
                            end
                            3'b010: begin
                                anode = 8'b11111011; 
                                cathode = score100;
                            end
                            3'b011: begin
                                anode = 8'b11110111; 
                                cathode = 7'b1111111;
                            end
                            3'b100: begin
                                anode = 8'b11101111; 
                                cathode = time1;
                            end
                            3'b101: begin
                                anode = 8'b11011111; 
                                cathode = time10;
                            end
                            3'b110: begin
                                anode = 8'b01111111;
                                cathode = 7'b1111111;
                            end
                        endcase
                    end
                end
                //no need for blink just display time and score if game not ended
                else
                begin
                    case (LED_counter)
                        3'b000: begin
                            anode = 8'b11111110; 
                            cathode = score1;
                        end
                        3'b001: begin
                            anode = 8'b11111101; 
                            cathode = score10;
                        end
                        3'b010: begin
                            anode = 8'b11111011; 
                            cathode = score100;
                        end
                        3'b011: begin
                            anode = 8'b11110111; 
                            cathode = 7'b1111111;
                        end
                        3'b100: begin
                            anode = 8'b11101111; 
                            cathode = time1;
                        end
                        3'b101: begin
                            anode = 8'b11011111; 
                            cathode = time10;
                        end
                        3'b110: begin
                            anode = 8'b01111111;
                            cathode = 7'b1111111;
                        end
                    endcase
                end
            end
        endcase
    end
endmodule
