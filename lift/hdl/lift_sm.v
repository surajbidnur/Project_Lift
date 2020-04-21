module lift_sm(
    input            clk, resetb, slowref,
    input            upreq0,
    input            upreq1, dnreq1,
    input            dnreq2,
    input            flreq0, flreq1, flreq2,	
    output reg       clr_flreq0,clr_flreq1,clr_flreq2,
    output reg [1:0] floorno,              
    output reg       clrup0, clrup1, clrdn1, clrdn2,
    output reg       upsig, dnsig, moving
);

reg [1:0] sm;                                    // State Machine
reg [1:0] nxtsm;

reg [6:0] ctr;                                   // Floor to Floor Delay Counter
reg [6:0] nxtctr;

// Terminal Count enumerartion
parameter ct_tc = 10;
          
// State enumeration
parameter [1:0] LVL0  = 2'b00,
                LVL1U = 2'b01,                   // prioritize moving up
                LVL1D = 2'b10,                   // prioritize moving down
                LVL2  = 2'b11;

// Floor number enumeration
parameter [1:0] GND = 2'b00,
                ONE = 2'b01,
                TWO = 2'b10;
				
always @(posedge clk or negedge resetb)
    if (!resetb) begin //{
        sm  <= LVL0;
        ctr <= 6'b0;
    end //}
    else if (slowref) begin //{
        sm  <= nxtsm;
        ctr <= nxtctr;
     end //}
     
always @(*) begin //{
    clr_flreq0 = 0; 
    clr_flreq1 = 0; 
    clr_flreq2 = 0;
    clrup0     = 0; 
    clrup1     = 0; 
    clrdn1     = 0; 
    clrdn2     = 0;
    upsig      = 0; 
    dnsig      = 0; 
    moving     = 0;
    floorno    = GND;
    nxtsm      = sm;
    nxtctr     = ctr;
    case (sm) //{
      LVL0 : begin //{                           *Start of LVL0
        floorno = GND;
        if (flreq0) begin //{
            clr_flreq0 = 1;
        end //}
        else if (flreq1) begin //{               *Start of flreq1  
            // We move up to 1st floor
            moving = 1;
            upsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
            else begin //{
                nxtctr     = 6'b0;
                nxtsm      = LVL1U;
                clr_flreq1 = 1;
            end //}
        end //}                                  *End of flreq1
        else if (flreq2) begin //{               *Start of flreq2
            // We move up to 2nd floor
            moving = 1;
            upsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
            else begin //{
                nxtctr     = 6'b0;
                nxtsm      = LVL2;
                clr_flreq2 = 1;
            end //}
        end //}                                  *End of flreq2
        else if (upreq0) begin //{
            clrup0 = 1;
        end //}
        else if (upreq1) begin //{               *Start of upreq1
            // We move up to 1st floor
            moving = 1;
            upsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
            else begin //{
                nxtctr = 4'b0;
                nxtsm  = LVL1U;
                clrup1 = 1;
            end //}
        end //}                                  *End of upreq1
        else if (dnreq1) begin //{               *Start of dnreq1
            // We move up to 1st floor
            moving = 1;
            upsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
            else begin //{
                nxtctr = 6'b0;
                nxtsm  = LVL1U;
                clrdn1 = 1;
            end //}
        end //}                                  *End of dnreq1
        else if (dnreq2) begin //{               *Start of dnreq2
            // We move up to 2nd floor
            moving = 1;
            upsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
            else begin //{
                nxtctr = 6'b0;
                nxtsm  = LVL2;
                clrdn2 = 1;
            end //}
        end //}                                  *End of dnreq2
    end //}                                      *End of LVL0
    
    LVL1U : begin //{                            *Start of LVL1
        floorno = ONE;
        if (flreq1) begin //{
            // We stay in the current floor
            clr_flreq1 = 1;
        end //}
        else if (flreq2) begin //{               *Start of flreq2
            // We move to 2nd floor
            moving = 1;
            upsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
            else begin //{
                nxtctr     = 6'b0;
                nxtsm      = LVL2;
                clr_flreq2 = 1;
            end //}                              *End of flreq2
    	end //}
	//end //}
	else if (upreq1) begin //{
	    clrup1 = 1;
	end //}
	else if (dnreq1) begin //{
	    clrdn1 = 1;
	end //}
	else if (dnreq2) begin //{
	    moving = 1;
	    upsig  = 1;
	    if (ctr != ct_tc) begin //{
	        nxtctr = ctr + 1'b1;
	    end //}
	    else begin //{
                nxtctr = 6'b0;
                nxtsm = LVL2;
                clrdn2 = 1;
	    end //}
	end //}
    end //}                                      *End of LVL1
    
    LVL1D : begin //{
        floorno = ONE;
	if (flreq0) begin //{
	    moving = 1;
	    dnsig  = 1;
	    if (ctr != ct_tc) begin //{
	        nxtctr = ctr + 1'b1;
	    end //}
	    else begin //{
                nxtctr = 6'b0;
                nxtsm = LVL0;
                clr_flreq0 = 1;
	    end //}
	end //}
	else if (flreq1) begin //{
	    clr_flreq1 = 1;
	end //}
	else if (upreq0) begin //{
	    moving = 1;
	    dnsig  = 1;
	    if (ctr != ct_tc) begin //{
	        nxtctr = ctr + 1'b1;
	    end //}
	    else begin //{
                nxtctr = 6'b0;
                nxtsm  = LVL0;
                clrup0 = 1;
	    end //}
	end //}
	else if (upreq1) begin //{
	    clrup1 = 1;
	end //}
	else if (dnreq1) begin //{
	    clrdn1 = 1;
	end //}
    end //}

    LVL2 : begin //{                             *Start of LVL2
        floorno = TWO;
        if (flreq0) begin //{
            // We move down to 0th floor
	    moving = 1;
	    dnsig  = 1;
	    if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
	    end //}
	    else begin //{
                nxtctr     = 6'b0;
                nxtsm      = LVL0;
                clr_flreq0 = 1;
	    end //}
        end //}
        else if (flreq1) begin //{               *Start of flreq1  
            // We move down to 1st floor
            moving = 1;
            dnsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
	        else begin //{
                nxtctr     = 6'b0;
                nxtsm      = LVL1D;
                clr_flreq1 = 1;
            end //}
        end //}                                  *End of flreq1
        else if (flreq2) begin //{               *Start of flreq2
            clr_flreq2 = 1;
        end //}                                  *End of flreq2
        else if (upreq0) begin //{
            // We move down to 1st floor
            moving = 1;
            dnsig  = 1;
	        if (ctr != ct_tc) begin //{
	            nxtctr = ctr + 1'b1;
	        end //}
	        else begin //{
	            nxtctr = 6'b0;
                    nxtsm  = LVL0;
                    clrup0 = 1;
	        end //}
        end //}
        else if (upreq1) begin //{               *Start of upreq1
            // We move down to 1st floor
            moving = 1;
            dnsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
	        else begin //{
                nxtctr = 6'b0;
                nxtsm  = LVL1D;
                clrup1 = 1;
            end //}
        end //}                                  *End of upreq1
        else if (dnreq1) begin //{               *Start of dnreq1
            // We move down to 1st floor
            moving = 1;
            dnsig  = 1;
            if (ctr != ct_tc) begin //{
                nxtctr = ctr + 1'b1;
            end //}
	        else begin //{
                nxtctr = 6'b0;
                nxtsm  = LVL1D;
                clrdn1 = 1;
            end //}
        end //}                                  *End of dnreq1
        else if (dnreq2) begin //{               *Start of dnreq2
            clrdn2 = 1;
        end //}                                  *End of dnreq2
    end //}                                      *End of LVL0
    default: ;
    endcase //}                                  *End of case statement   
end //}                                          *End of always @ * begin

endmodule
