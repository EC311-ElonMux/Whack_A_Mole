`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/22/2020 08:21:33 PM
// Design Name: 
// Module Name: gameplay
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


module gameplay(
    input [1:0] levl,  // the difficulty level, easy, medium, hard
    input CLK100MHZ,
    input [2:0] input_pos,  // the input of mole's position
    output reg [5:0] score = 0,  // the current score
    output [2:0] mole_pos1  // the generated mole's position
    // output[2:0] mole_pos2 // planning on high level games adding more moles. 
    );
    
    reg enable = 0;
    wire [2:0] moletime;
    reg [24:0] counter = 0;
    reg [2:0] input_buffer;
    
    mole_picker ez(
        .CLK100MHZ(CLK100MHZ),
        .enable(enable),
        .moletime(mole_pos1),
        .mole(moletime)
    );
    
    always @(posedge CLK100MHZ)
        begin 
            counter <= counter + 1;
        end


    assign hard_counter = counter[24];  // different counter should have different time window that the mole displays
    assign medium_counter = counter[24:23];  // the digits still need to be tuned. 
    //assign ez_counter = counter[24:22];
     assign ez_counter = counter[1:0];
    
    always @(*)
    begin
        case(levl)
            2'b00 : begin
                if(ez_counter != 0) begin  // might have a problem since mole_picker might not be a fixed value
                    enable = 1;
                    input_buffer = input_pos;
                    if(input_buffer == mole_pos1) begin
                        enable = 0;
                        score = score + 1;
                        input_buffer = 3'bz;
                    end
                end
            end
            
            2'b01 : begin
                if(medium_counter != 0) begin
                    enable = 1;
                    input_buffer = input_pos;
                    if(input_buffer == mole_pos1) begin
                        enable = 0;
                        score = score + 1;
                        input_buffer = 3'bz;
                    end
                end
            end
            
            2'b10 : begin
                if(hard_counter != 0) begin
                    enable = 1;
                    input_buffer = input_pos;
                    if(input_buffer == mole_pos1) begin
                        enable = 0;
                        score = score + 1;
                        input_buffer = 3'bz;
                    end
                end            
            end
         endcase  
     end
endmodule
