/*
        This module is used to debounce the push button signal.
        This generates a cleaned signal without any unusual spikes.
*/

module debounce(
    input      clk,
    input      resetb,
    input      slowref, // 8 to 32 Hz reference strobe
    input      pbsig,   // Push Button Raw Input
    output reg clean    // Debounced output
);

reg a,b;

always@(posedge clk or negedge resetb)
	if(!resetb) begin //{
	    a <= 1;         // 1 because pbsig default too is 1 at reset
	    b <= 1;
	end //}	
	else if (slowref) begin //{
	    a <= pbsig;
	    b <= a;
	end //}

    wire set = a && b;
    wire clr = !a && !b;

always@(posedge clk or negedge resetb)
    if(!resetb) clean <= 1;
    else begin //{
      if (set)      clean  <= 1;
      else if (clr) clean  <= 0;
    end //}

endmodule
