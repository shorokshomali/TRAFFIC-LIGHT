`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2022 10:42:36 AM
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(clk,rst,red, yellow,green);
input clk, rst;
output 		red, yellow,green;

localparam S_RED = 0;
localparam S_YELLOW = 1;
localparam S_GREEN = 2;

reg 	[2:0]	state;
reg		[2:0]	next_state;
reg		[5:0]	time_count;

assign red 		= (state == S_RED)		? 1 : 0;
assign yellow 	= (state == S_YELLOW)	? 1 : 0;
assign green 	= (state == S_GREEN)	? 1 : 0;


always @(posedge clk or negedge rst)
	if (!rst)		
		time_count <= 0;
	else	
		if (state == next_state) 	
			time_count <= time_count + 1;
		else 
			time_count <= 0;

always @(posedge clk or negedge rst)
	if (!rst)		
		state <= S_RED;
	else	 	
		state <= next_state;
				  
// need to add a flag that resets prepare_cnt in case of launch
always @(*)
	begin
	next_state 	= state; // improtant to prevent latch
	case (state)
		S_RED: 
			if (time_count >= 60)
				next_state =  S_GREEN;
			
		S_YELLOW:
			if (time_count >= 3)
	  		  	next_state =  S_RED;
	  
		S_GREEN:
			if (time_count >= 60)
	  		  	next_state =  S_YELLOW;
	  		  	
		default	: next_state =	state;
	 endcase
	end

 endmodule

