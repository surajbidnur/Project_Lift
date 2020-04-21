module lift_sm(
    input            clk, resetb, slowref,
    input            pbpulse0, pbpulse1, pbpulse2,
    input            sw_pulse0, sw_pulse1, sw_pulse2,
    input            tg0, tg2,
    input      [1:0] ud,
    input            flreq_led0, flreq_led1, flreq_led2,	
    output reg       clr_flreq0,clr_flreq1,clr_flreq2,
    output reg [1:0] floorno,              
    output reg       clrup0, clrup1, clrup2,
	             clrdn0, clrdn1, clrdn2,
	             upsig, dnsig, moving
);

reg [1:0] sm;
reg [1:0] nxtsm;

reg [3:0] counter1;
reg [3:0] counter2;
reg [3:0] nxtcounter1;
reg [3:0] nxtcounter2;

// Counter enumerartion
parameter ct2_tc = 12,
          ct1_tc = 13;

// State enumeration
parameter [1:0] LVL0 = 2'b00,
                LVL1 = 2'b01,
	        LVL2 = 2'b10;

// Floor number enumeration
parameter [1:0] GND = 2'b00,
                ONE = 2'b01,
		TWO = 2'b10;
				
// Level-1 push button enumeration
parameter [1:0] NULL = 2'b00,
                UP   = 2'b10,
		DN   = 2'b01,
		BOTH = 2'b11;

always @(posedge clk or negedge resetb)
    if (!resetb) begin //{
        sm       <= LVL0;
        counter1 <= 3'b0;
        counter2 <= 3'b0;
    end //}
    else begin //{
        sm       <= nxtsm;
        counter1 <= nxtcounter1;
        counter2 <= nxtcounter2;
    end //}

always @(*) begin //{
    if (slowref) begin //{
        case (sm) //{                                       *Case of state machine
            LVL0 : begin //{                                *Ground floor
                case ({pbpulse2,pbpulse1,pbpulse0}) //{     *Push button case statement
                    3'b001 : begin //{
                        clrup0      = 0;
                        nxtcounter1 = 3'b0;
                        floorno     = GND;
                        nxtsm       = sm;
                    end //}
		    3'b010 : begin //{
	                if (counter1 == ct1_tc) begin //{
			    nxtsm       = LVL1;
			    clrup0      = 1;
			    nxtcounter1 = 3'b0;
			    floorno     = ONE;
			    upsig       = 0;
			    moving      = 0;
			end //}
			else begin //{
			    upsig    = 1;
			    moving   = 1;
			    counter1 = nxtcounter1 + 1'b1;
			end //}
	            end //}
		    3'b100 : begin //{
	                if (tg2 == 1) begin //{
				if (counter1 == ct1_tc) begin //{
				    nxtsm       = LVL2;
				    clrup0      = 1;
				    nxtcounter1 = 3'b0;
				    floorno     = TWO;
				    upsig       = 0;
				    moving      = 0;
				end //}
				else begin //{
				    upsig    = 1;
				    moving   = 1;
				    counter1 = nxtcounter1 + 1'b1;
				end //}
			end //}
	            end //}
		    default : begin //{
	                nxtsm    = sm;
		        floorno  = GND;
                        upsig    = 0;
			dnsig    = 0;
			moving   = 0;
			clrup0   = 0;
                        clrdn0   = 0;
			counter1 = nxtcounter1;
			counter2 = nxtcounter2;
	            end //}
                endcase //}                                 *End of pbpulse case

            	case ({sw_pulse2,sw_pulse1,sw_pulse0}) //{  *Case statement for switc pulse
	            3'b001 : begin //{
                        clr_flreq0 = 0;
		        counter1   = 3'b0;
		        floorno    = GND;
		        nxtsm      = sm;
                    end //}
		    3'b010 : begin //{
		        if (flrew_led1 == 1) begin //{
			    if (counter1 == ct1_tc) begin //{
		                clr_flreq1  = 1;
				nxtcounter1 = 3'b0;
				floorno     = ONE;
				nxtsm       = LVL1;
				upsig       = 0;
				moving      = 0;
			    end //}
			    else begin //{
			        upsig      = 1;
				moving     = 1;
				nxtcounter = counter1 + 1'b1;
			    end //}
			end //}
	            end //}
		    3'b100 ; begin //{
		        if (flreq_led2 ==1) begin //{
			    if (counter1 == ct1_tc) begin //{
			        clr_flreq2  = 1;
				nxtcounter1 = 3'b0;
				floorno     = TWO;
				nxtsm       = LVL2;
				upsig       = 0;
				moving      = 0;
			    end //}
			    else begin //{
			        upsig       = 1;
				moving      = 1;
				nctcounter1 = counter1 + 1'b1;
			    end //}
			end //}
	            end //}
		    default : begin //{
	                nxtsm    = sm;
			floorno  = GND;
			upsig    = 0;
			dnsig    = 0;
			clrup0   = 0;
			clrdn0   = 0;
			counter1 = nxtcounter1;
			counter2 = nxtcounter2;
	            end //}
	        endcase //}                                 *End of switch pulse case
	end //}                                             *End of LVL0 state	
        endcase //}                                         *End of state machine case
    end //}                                                 *End of if slowref     
    else begin //{
    end //}
end //}
