/*
        This module takes the the raw switch signal as input and then
        a cleaned/debounced signal is generated.
*/

module debounce_sw(
    input      clk,
    input      resetb,
    input      slowref,   // Slow reference signal 
    input      swsig,     // Push Button Raw Input
    output reg cleansw    // Debounced output from switch
);

reg a,b;

always@(posedge clk or negedge resetb)
	if(!resetb) begin //{
	    a <= 0;
	    b <= 0;
	end //}	
	else if (slowref) begin //{
	    a <= swsig;
	    b <= a;
	end //}

    wire set = a && b;
    wire clr = !a && !b;

always@(posedge clk or negedge resetb)
    if(!resetb) cleansw <= 0;
    else begin //{
      if (set)      cleansw  <= 1;
      else if (clr) cleansw  <= 0;
    end //}

endmodule
