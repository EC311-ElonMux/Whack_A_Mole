`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/27/2020 07:01:03 PM
// Design Name: 
// Module Name: button_inputs
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


module button_inputs(
    input CLK100MHZ,
    input up,
    input down,
    input start,
    input left,
    input right,
    output reg [5:0] gametime,
    output reg [1:0] difficulty,
    output reg lr,
    output reg gamestart
    );
    
    wire dec_state, dec_dn, dec_up;
    debounce dec_btn (
        .clk(CLK100MHZ),
        .i_btn(down),
        .o_state(dec_state),
        .o_ondn(dec_dn),
        .o_onup(dec_up)
    );
    
    wire inc_state, inc_dn, inc_up;
    debounce inc_btn (
        .clk(CLK100MHZ),
        .i_btn(up),
        .o_state(inc_state),
        .o_ondn(inc_dn),
        .o_onup(inc_up)
    );
    
    wire s_state, s_dn, s_up;
    debounce s_btn (
        .clk(CLK100MHZ),
        .i_btn(start),
        .o_state(s_state),
        .o_ondn(s_dn),
        .o_onup(s_up)
    );
    
    wire l_state, l_dn, l_up;
    debounce l_btn (
        .clk(CLK100MHZ),
        .i_btn(left),
        .o_state(l_state),
        .o_ondn(l_dn),
        .o_onup(l_up)
    );    
    
    wire r_state, r_dn, r_up;
    debounce r_btn (
        .clk(CLK100MHZ),
        .i_btn(right),
        .o_state(r_state),
        .o_ondn(r_dn),
        .o_onup(r_up)
    );
    initial
    begin
        gametime = 0;
        difficulty = 0;
        lr = 0;
        gamestart = 0;
    end
    
    always @ (posedge CLK100MHZ)
    begin
    
        if (s_dn)
        begin
            gamestart = gamestart+1;
        end
        if (l_dn)
        begin
            lr = lr - 1;
        end
        if (r_dn)
        begin
            lr = lr + 1;
        end
        
        //If the start button has not been pressed / reset
        if(gamestart == 0)
        begin
            //If setting the Time
            if(lr == 0)
            begin
                if (inc_dn)
                begin
                    if(gametime < 60)
                    begin
                        gametime = gametime+5;
                    end
                end
                if (dec_dn)
                begin
                    if(gametime > 0)
                    begin
                        gametime = gametime-5;
                    end
                end
            end
            
            //If setting the difficulty
            if(lr == 1)
            begin
                if (inc_dn)
                begin
                    if ( difficulty == 2'b10 )
                    begin
                        difficulty = 2'b00;
                    end
                    else
                    begin
                        difficulty = difficulty + 1;
                    end
                end
                if (dec_dn)
                begin
                    if( difficulty == 2'b00 )
                    begin
                        difficulty = 2'b10;
                    end
                    else
                    begin
                        difficulty = difficulty - 1;
                    end
                end
            end
        end
    end
endmodule
