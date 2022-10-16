module traffic_lights(input clk, rst, output reg red, yellow, green);

// Define 4 states
localparam red_state = 0;
localparam red_yellow_state = 1;
localparam green_state = 2;
localparam yellow_state = 3;

// Define clock cycles duration
localparam red_time = 1;
localparam red_yellow_time = 2;
localparam green_time = 3;
localparam yellow_time = 4;

// Define state and counter variables
integer present_state, next_state;
integer present_counter, next_counter;

//Implementation of asynchronous and synchronous processes
always @ (posedge clk or posedge rst)
	begin
	
	// asynchronous process
	if (rst) begin
		present_state <= red_state;
		present_counter <= 0;
	end
	
	// synchronous process
	else begin
		present_state <= next_state;
		present_counter <= next_counter;
	end
end

// Cobinatorical logic to set the next state and next counter values
always
	begin
	
	// Default
	next_state = present_state;
	next_counter = present_counter + 1;
	
	case (present_state)
		
		red_state: begin
			
			if (next_counter >= red_time) begin
				next_state = red_yellow_state;
				next_counter = 0;
			end
		end
		
		red_yellow_state: begin
		 if (next_counter >= red_yellow_time) begin
				next_state = green_state;
				next_counter = 0;
			end
		end
		
		green_state: begin
		 if (next_counter >= green_time) begin
				next_state = yellow_state;
				next_counter = 0;
			end
		end
		
		yellow_state: begin
		 if (next_counter >= yellow_time) begin
				next_state = red_state;
				next_counter = 0;
			end
		end
	endcase 
end

// Cobinatorical logic to set output lights
always 
   begin 
   
   // Default values
   red = 1'b0;
   yellow = 1'b0;
   green = 1'b0;
   
   case(present_state)
	
      red_state: begin
         red = 1'b1;
      end
		 
      red_yellow_state: begin
         red = 1'b1;
         yellow = 1'b1;
      end
		 
      green_state: begin
         green = 1'b1;
      end
		 
      yellow_state: begin
         yellow = 1'b1;
      end
	endcase
end

endmodule
		

