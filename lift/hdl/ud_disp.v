/* 
        Module which receives up-signal and down-signal from
        the lift state machine and then displays UP or dn on
        two seven segment displays.                          
*/ 

module ud_disp(
     input            clk, resetb, slowref,
	 input            upsig,dnsig,           // Up and Down signal sent by lift indicating direction of motion
	 input            moving,                // Signal sent from lift when moving 
	 output reg [7:0] d1, d2                 // Display output to seven-seg 
);

reg [7:0] nxtd1,nxtd2;                       // Wire-reg for display

parameter   uDISP = 8'b1100_0001,            // U-display
            pDISP = 8'b1000_1100,            // P-display
		    dDISP = 8'b1010_0001,            // D-display
		    nDISP = 8'b1010_1011,            // N-display
		    dINIT = 8'b1111_1111;            // Initial state

always @(posedge clk or negedge resetb)
    if (!resetb) begin
	    d1 <= dINIT; d2 <= dINIT; 
	end
	else begin
	    d1 <= nxtd1; d2 <= nxtd2;
	end 
	
always @(*)
	if (slowref) begin
		if (upsig && moving)      begin nxtd1 = uDISP; nxtd2 = pDISP; end
		else if (dnsig && moving) begin nxtd1 = dDISP; nxtd2 = nDISP; end
		else                      begin nxtd1 = d1;    nxtd2 = d2;    end
	end
	else begin
	    nxtd1 = d1; nxtd2 = d2;
	end
endmodule