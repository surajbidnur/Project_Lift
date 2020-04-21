/*
        This module takes in the vector floorno which is
        then used to display the floor number on a seven
        segment display.
*/

module number_disp(
    input            clk, resetb, slowref,
	input      [1:0] floorno,                 // Input from lift which tells us the current floor number 
	output reg [7:0] numdisp                  // Seven segment display to show floor number 
);

reg [7:0] nxtnum;                             // Wire-reg

parameter  gDISP = 8'b1100_0000,
           oDISP = 8'b1111_1001,
		   tDISP = 8'b1010_0100,
		   nINIT = 8'b1111_1111;

always @(posedge clk or negedge resetb)
    if (!resetb) numdisp <= 8'b0;
	else         numdisp <= nxtnum;
	
always @(*)
    if (slowref) begin
	    case (floorno)
		    2'b00   : nxtnum = gDISP;
		    2'b01   : nxtnum = oDISP;
		    2'b10   : nxtnum = tDISP;
		    default : nxtnum = nINIT;
		endcase
	end
	else nxtnum = numdisp;
    
endmodule