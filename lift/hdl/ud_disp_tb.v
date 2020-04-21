module ud_disp_tb();
     reg        clk; 
	 reg        resetb;
     reg        pbsig0,pbsig1,pbsig2;
     reg        clrup0,clrup1,clrup2;
	 reg        clrdn0,clrdn1,clrdn2;          // From lift                
     reg        upsig, dnsig;                  
	 reg        moving;
	 reg        swsig0,swsig1,swsig2;
     reg        clr_flreq0,clr_flreq1,clr_flreq2;
	 reg  [1:0] floorno;
	 wire       slowref;
	 wire       clean0,clean1,clean2;
     wire       pbpulse0,pbpulse1,pbpulse2;
     wire [1:0] ud;                            // MSB-> UP, LSB-> DOWN
	 wire [7:0] d1, d2;
	 wire       sw_pulse0,sw_pulse1,sw_pulse2;
	 wire       tg0,tg2;
     wire       flreq_led0,flreq_led1,flreq_led2;
	 wire [7:0] numdisp;

always #5 clk = !clk;

lift l1(
    .clk(clk),
    .resetb(resetb),
    .pbsig0(pbsig0),
    .pbsig1(pbsig1),
    .pbsig2(pbsig2),
    .clrup0(clrup0),.clrup1(clrup1),.clrup2(clrup2),
    .clrdn0(clrdn0),.clrdn1(clrdn1),.clrdn2(clrdn2),
	.upsig(upsig),
	.dnsig(dnsig),
	.moving(moving),
	.swsig0(swsig0),.swsig1(swsig1),.swsig2(swsig2),
    .clr_flreq0(clr_flreq0),.clr_flreq1(clr_flreq1),.clr_flreq2(clr_flreq2),
	.floorno(floorno),
	.slowref(slowref),
    .clean0(clean0),.clean1(clean1),.clean2(clean2),
    .pbpulse0(pbpulse0),.pbpulse1(pbpulse1),.pbpulse2(pbpulse2),
    .ud(ud),
    .d1(d1), .d2(d2),
    .sw_pulse0(sw_pulse0),.sw_pulse1(sw_pulse1),.sw_pulse2(sw_pulse2),
    .cleansw0(cleansw0),.cleansw1(cleansw1),.cleansw2(cleansw2),
	.tg0(tg0),.tg2(tg2) ,
    .flreq_led0(flreq_led0),.flreq_led1(flreq_led1),.flreq_led2(flreq_led2),
	.numdisp(numdisp)
);

initial begin
    if (l1.slowref) $display ("1");
    $display("l1.slowref %b",l1.slowref);
    
    clk = 0; resetb = 0;
	pbsig0 = 1; pbsig1 = 1;  pbsig2 = 1;
	clrup0 = 0; clrup1 = 0; clrup2 = 0;
	clrdn0 = 0; clrdn1 = 0; clrdn2 = 0;
	upsig = 0; dnsig = 0; moving = 0;
	swsig0 = 0; swsig1 = 0; swsig2 = 0;
    clr_flreq0 = 0; clr_flreq1 = 0; clr_flreq2 = 0;
	floorno = 2'b0;
	
    repeat(16) @(negedge clk) resetb = 0;
	@(negedge clk) resetb = 1;
	
	// Pulse-1
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 1;
      @(negedge clk) pbsig0 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 0;
      @(negedge clk) pbsig0 = 1;
    end
    
	// Pulse-2
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 1;
      @(negedge clk) pbsig0 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 0;
      @(negedge clk) pbsig0 = 1;
    end
    
	// Pulse-3
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig1 = 1;
      @(negedge clk) pbsig1 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig1 = 0;
      @(negedge clk) pbsig1 = 1;
    end
	
	repeat(16) @(negedge clk);
	floorno = 2'b01;
	repeat(16) @(negedge clk);
    
    repeat(32) @(negedge clk);
    TkL(1,0,0,0); // udc, cu, cd
    repeat(16) @(negedge clk);
    TkL(0,0,0,0);
    repeat(16) @(negedge clk);
    
	 // Pulse-4
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig2 = 1;
      @(negedge clk) pbsig2 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig2 = 0;
      @(negedge clk) pbsig2 = 1;
    end
	
	floorno = 2'b10;
    
    repeat(32) @(negedge clk);
	TkL(1,0,0,0); // udc, cu, cd
    repeat(16) @(negedge clk);
    TkL(0,0,0,0);
    repeat(32) @(negedge clk);
    TkL(0,1,0,0);
    repeat(16) @(negedge clk);
    TkL(0,0,0,0);
	
	repeat(16) @(negedge clk);
	
	TkD1(1,0);
	repeat(16) @(negedge clk);
	
	repeat(32) @(negedge clk);
	
	TkD1(0,0);
	repeat(16) @(negedge clk);
	
	repeat(32) @(negedge clk);
	
	TkD1(0,1);
	repeat(16) @(negedge clk);
	
	repeat(32) @(negedge clk);
	
	TkD1(0,0);
	repeat(16) @(negedge clk);
	
	// Pulse-5
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) swsig0 = 0;
      @(negedge clk) swsig0 = 1;
    end
    repeat(128) @(negedge clk);
    /*repeat (4) begin
      @(negedge clk) swsig = 1;
      @(negedge clk) swsig = 0;
    end*/
	 
	 // Pulse-6
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 1;
      @(negedge clk) pbsig0 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 0;
      @(negedge clk) pbsig0 = 1;
    end
    
    clr_flreq0 = 1;
    repeat(16) @(negedge clk);
    clr_flreq0 = 0;
   
    // Sw-pulse2
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) swsig1 = 0;
      @(negedge clk) swsig1 = 1;
    end
    repeat(128) @(negedge clk); 
        
    $stop;
end

task TkL;
  input       cu0, cu1, cd1, cd2;
  begin
    clrup0 = cu0; clrup1 = cu1;
	clrdn1 = cd1; clrdn2 = cd2;
    repeat (16) @(negedge clk);
  end
endtask

task TkD1;
    input     up;
	input     dn;
	begin
	    upsig = up; dnsig = dn;
		if (up) moving = 1'b1;
		else if (dn) moving = 1'b1;
		else moving = 1'b0;
		repeat (8) @(negedge clk);
	end
endtask
	 
endmodule