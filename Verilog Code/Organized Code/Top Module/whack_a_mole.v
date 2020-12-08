`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2020 04:59:52 PM
// Design Name: 
// Module Name: whack_a_mole
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

module whack_a_mole(
    input CLK100MHZ,
    input upbtn,
    input dnbtn,
    input start,
    input left,
    input right,
    input RST_BTN,
    input [7:0] switches,
    output VGA_HS_O,   
    output VGA_VS_O,   
    output [3:0] VGA_R,
    output [3:0] VGA_G,
    output [3:0] VGA_B,   
    output [7:0] led,
    output [7:0] anode,
    output [6:0] cathode
    );
    
    //Code to make a 50 MHZ clock
    reg counter = 0;
    reg CLK50MHZ = 0;
    always @ (posedge CLK100MHZ)
    begin
        counter = counter + 1;
        if(counter == 1)
        begin  
            CLK50MHZ = ~CLK50MHZ;
        end
    end
    
    //Wires that store the game time, difficulty, and signals for game start and setting values
    wire [5:0] gametime;
    wire [1:0] difficultywire;
    wire lr, gamestart; 
    //Module that controls user Input of difficulty and time
    button_inputs buttons(
        .CLK100MHZ(CLK100MHZ),
        .up(upbtn),
        .down(dnbtn),
        .start(start),
        .left(left),
        .right(right),
        .gametime(gametime),
        .difficulty(difficultywire),
        .lr(lr),
        .gamestart(gamestart)
        );
        
    //Wires that contain which switch was hit
    wire [7:0] poshit;
    //Module that tracks switches that have been hit
    switch_inputs hammer(
        .switches(switches),
        .CLK100MHZ(CLK50MHZ),
        .positionhit(poshit)
        );
    
    //Wires that contain how long is left in game, along with if game has ended
    wire [5:0] timeleft;
    wire gameend;
    //Module that counts time remaining
    countdown timer(
        .CLK100MHZ(CLK100MHZ),
        .gamestart(gamestart),
        .gametime(gametime),
        .timeleft(timeleft),
        .gameend(gameend)
        );
          
    //Signal that lets the new output from the mole picker be sent out
    wire enablewire;
    //Counter that outputs a signal based on difficulty, 2/1.2/0.8 seconds
    enable_trigger count(
        .CLK100MHZ(CLK100MHZ),
        .difficulty(difficultywire),
        .enable(enablewire)
        );
    
    //Wire that contains the position of the mole and where the moles were hit
    wire [7:0] internalmole;
    wire [7:0] molehit; 
    //Module that picks the moles and how long it stays
    mole_picker molepick(
        .CLK100MHZ(CLK100MHZ),
        .difficulty(difficult),
        .molehit(molehit),
        .enable(enablewire),
        .mole(internalmole)
        );
        
    //Wire containing the mole information and score information to send out onto board via LED/VGA
    wire [7:0] mole;
    wire [7:0] score;
    //Module that tracks the moles hit and adjusts score and mole position
    score_tracker scorer(
        .CLK100MHZ(CLK100MHZ),
        .gamestart(gamestart),
        .gameend(gameend),
        .enable(enablewire),
        .input_pos(internalmole),  
        .switch_hit(poshit),
        .molehit(molehit),
        .cmole(mole),
        .score(score)
    );
        
    //Assigns LEDS to Mole
    assign led = mole;    
    
    //Wires that store 10s and 1s place for the time, in 7 seg format
    wire [6:0] time1, time10;
    //Module that turns the game time into readable format for SSD
    time_to_bcd_to_disp timedecoder(
        .in(timeleft),        
        .digit0(time1),
        .digit1(time10)
        );
        
    //Wires that store 100s, 10s, and 1s place for the score, in 7 seg format
    wire [6:0] score1, score10, score100;
    //Module that turns the score into readable format for SSD
    score_to_bcd_to_disp scoredecoder(
        .in(score),        
        .digit0(score1),
        .digit1(score10),
        .digit2(score100)
        );
        
    //Wires that store difficulty, in 7 seg format 
    wire [6:0] difficultycode;   
    //Module that translates game difficulty into SSD
    difficulty_to_disp difficultycoder(
        .in(difficultywire),
        .digit(difficultycode)
        );
        
    //Module that sends outputs to seven segment
    to_seven_segment decoder(     
        .CLK100MHZ(CLK100MHZ),      
        .gamestart(gamestart),
        .gameend(gameend),
        .lr(lr),
        .score100(score100),
        .score10(score10),     
        .score1(score1),      
        .time10(time10),     
        .time1(time1),
        .difficultycode(difficultycode),
        .anode(anode),  
        .cathode(cathode) 
        ); 
        
    //VGA Module that sends moles to the display screen
    top_square VGA(
        .CLK(CLK100MHZ),          
        .RST_BTN(RST_BTN),
        .random_num(mole),
        .mole_hit(molehit),       
        .VGA_HS_O(VGA_HS_O),      
        .VGA_VS_O(VGA_VS_O),      
        .VGA_R(VGA_R),    
        .VGA_G(VGA_G),    
        .VGA_B(VGA_B)     
    );
    
        
endmodule