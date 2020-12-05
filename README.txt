This is the EC311 Final Project of Whack-A-Mole

By Team Elon Mux which consists of:
	Devin Goodwin: BU ID - 
	Linglong Le: BU ID - U58157743
	Julian Leguizamon: BU ID - 
	Chenliang Wang: BU ID - U01275249

Project Demo Link: 

Project Overview:

The goal of this project is to create a fun and interactive Whack-A-Mole game for the FPGA. This Whack-A-Mole Game
generates a random mole at time intervals based on the difficulty the user sets, and is played using the Switches and buttons.
The user sets the difficulty, and amount of time for the game at the start, and then starts hitting the moles that pop up, 
which are represented by the LEDs on the board, and if a VGA is connected, the lit up squares on the monitor. 
When the game is over, the user can see how many moles they hit, and can choose to play again.

How to Run the Project:

To run this project, the Github repository should be downloaded, and the files inside of the All Code folder inside of 
Verilog Code, along with the constraint file, should be loaded onto Vivado. After this is done, the User then needs to 
set the top module to the module called whack_a_mole. Then the user should setthe board type, and generate the bitstream 
using Vivado.

Alternatively the user can simply download the bitstream file within the bitstream folder of this repository, 
and then use that bitstream with their FPGA. However, that Bitstream is configured for the Nexys A7 FPGA 100T.

Once the user has successfully uploaded the bitstream to the board, the Board will display 2 zeros on the 
left segment display, and one on the right segment display. The value on the left represents how long the 
game will run, and the value on the right will represent the difficulty

The user can use the left and right buttons in the set of 5 on the board to select which value they are adjusting. 
The top and bottom buttons will increase the value, and the center button will start the game. Once the user 
starts the game, the values on the left segment display will begin to count down, as it represents the amount 
of time left in the game. The value on the right segment will now display 3 zeros. These represent the score 
that the User has in the game. Whenever they successfully hit a mole that value will increment by 1.

Now LEDs on the board, and if a VGA is connected, squares on the display, will begin to light up. These lit up 
objects represent that a Mole at that switch/square and needs to be hit. To t the Mole simply adjust the position 
of the Switch. For example if a mole was present at a switch that was high, to hit it the player would
just flip the switch down. This continues until the game runs out time, at which point the timer and the 
score will begin to flash. To play the game again, the user would just need to press the center button, 
it will bring them back to the difficulty and time settings that they initially had.

Code Structure:
The code can be split up into 3 general categories. User Input Decoding, Game Control, and Output Decoding.
These code segments have also been split up inside of this Github Repository underneath the folder called 
Organized Code in the Verilog Code Folder.

The code that controls the User Input consist of the modules button_inputs.v and switch_inputs.v

	button_inputs.v takes in the 5 buttons, and uses the inputs to these buttons to output the variables 
	that contain how long the game should be, what the difficulty is, and when to start the game.
	
	switch_inputs.v takes in all 8 switches that the user can use to hit the moles, and outputs an 8 bit number, 
	which represents each switch. If the switch has been changed, then the corresponding bit within the 8 bit 
	output is set to 1. For example hitting the 3rd switch would result in 00000100 as this modules output.

The code that makes up Game Control consist of countdown.v, enable_trigger.v, mole_picker.v and score_tracker.v

	timer.v takes in the input of the initial game time, and begins to count down once the game has started. 
	This countdown is output, so that the time left can be displayed to the Seven Segment Display
	And once the countdown has reached zero, timer outputs a signal that indicates the game is over.

	enable_trigger.v takes in the input of the user set difficulty, and uses that to determine what the time
	intervals for new moles should be. Then it sends out a signal at time intervals based on the difficulty 
	that indicate a new mole should be appearing.
	
	mole_picker.v takes in the enable signal from enable_trigger, along with the user set difficulty. Then 
	what this module does is it uses a set of LFSRs to randomly generate a mole in one of the 8 positions, 
	and then assigns the duration the mole stays up using the difficulty along with another LFSR. Within 
	this module is a mole_control.v which takes in these times and mole positions, and regulates them so 
	that once the duration has been reached, the mole pops back down. And this module outputs an 8 bit
	number, which essentially details whether or not a mole is present in each of the 8 possible positions.
		
	score_tracker.v takes in the input that is coming from mole_picker, along with the input that is coming 
	from the switch inputs. This module outputs the values of moles that will be displayed to the FPGA/VGA
	Along with the score that the user has so far. First this module creates a 3rd 8 bit number, which is 
	initially equal to the output from the mole_picker, and updates every time a new mole is added in, or 
	whenever a mole drops down. This module then compares the value of each of the 8 bits within the outputs 
	from mole_picker and switch_inputs. If both bits in a specific positon in the 2 signals are one, then the 
	module increments score by 1, and updates the output to reflect that a mole was just hit down. Along with
	a signal indicating that there was a mole that was hit.
		
The code that makes up Output Decoding is made up of an assign statement a top_square.v module and a series of decoding modules 
which are: time_to_bcd_to_disp.v, score_to_bcd_to_disp.v, difficulty_to_disp and to_seven_segment.v
	
	Inside of the assign statement, the code simply assigns the 8 bit number that score_tracker.v is outputting 
	to the LEDS, as those represent the current mole position, including the corrections for when a mole was hit down.
	
	score_to_bcd_to_disp, difficulty_to_disp and time_to_bcd_to_disp just take in the binary values of the 
	difficulty, time and score, and converting them into a format that is readable by the seven segment display.

	to_seven_segment.v takes the values that are coming from the to_disp.v modules and sends them to the seven segment 
	display on the board. There are some control statements within this module that control which statement is actually 
	being displayed, and whether or not any of these values should be blinking.
		
	top_square.v is the module that controls the VGA display. It takes in the current position of the mole, if a mole 
	has been hit, and uses that information to update the monitor to reflect the current state of the moles in the game. 
		
