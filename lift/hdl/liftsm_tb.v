module liftsm_tb();
    reg         clk;
    reg         resetb;
    reg         pbsig0, pbsig1, pbsig2;
    reg         swsig0, swsig1, swsig2;
    wire        upreq0, upreq1, dnreq1, dnreq2;

always #5 clk = !clk;

lift lift0(
    .clk(clk),
    .resetb(resetb),                             // 50 MHz clock and active low reset
    .pbsig0(pbsig0),
    .pbsig1(pbsig1),
    .pbsig2(pbsig2),                             // Push Button Raw Input
    .swsig0(swsig0),
    .swsig1(swsig1),
    .swsig2(swsig2),                             // Raw input from toggle switch
    //.slowref(slowref),                           // Slowed down clock reference signal
    .upreq1(upreq1),                             // LED display for floor-1
    .dnreq1(dnreq1),                             // LED display for floor-1
    .upreq0(upreq0),
    .dnreq2(dnreq2),                             // LED display fro floor-0 and floor-2
    .d1(d1),
    .d2(d2),                                     // UP/DN display on seven segment display
    .flreq0(flreq0),
    .flreq1(flreq1),
    .flreq2(flreq2),                             // Inside lift floor request panel LED
    .numdisp(numdisp)                            // Floor number display on seven segment display 
);

initial begin
    clk = 0; resetb = 0;
    pbsig0 = 1; pbsig1 = 1; pbsig2 = 1;
    swsig0 = 0; swsig1 = 0; swsig2 = 0;
	
    repeat(16) @(negedge clk) resetb = 0;
    @(negedge clk) resetb = 1;
	
/*	// Pulse-1
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
      @(negedge clk) pbsig1 = 1;
      @(negedge clk) pbsig1 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig1 = 0;
      @(negedge clk) pbsig1 = 1;
    end
	
	// Pulse-3
    repeat(128) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig2 = 1;
      @(negedge clk) pbsig2 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig2 = 0;
      @(negedge clk) pbsig2 = 1;
    end
	
    // Pulse-4
	repeat(128) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig1 = 1;
      @(negedge clk) pbsig1 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig1 = 0;
      @(negedge clk) pbsig1 = 1;
    end

    // Pulse-5
	repeat(128) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 1;
      @(negedge clk) pbsig0 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig0 = 0;
      @(negedge clk) pbsig0 = 1;
    end
	
    // Pulse-6
    repeat(256) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig1 = 0;
        @(negedge clk) swsig1 = 1;
    end
    repeat(128) @(negedge clk);

    // Pulse-7
    repeat(256) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig2 = 0;
        @(negedge clk) swsig2 = 1;
    end
    repeat(128) @(negedge clk);*/
	
    // Pulse-1
    repeat(64) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig0 = 0;
        @(negedge clk) swsig0 = 1;
    end
    repeat(128) @(negedge clk);

    // Pulse-2
    repeat(64) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig2 = 0;
        @(negedge clk) swsig2 = 1;
    end
    repeat(128) @(negedge clk);
	
    // Pulse-3
    repeat(64) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig1 = 0;
        @(negedge clk) swsig1 = 1;
    end
    repeat(256) @(negedge clk);

    // Pulse-4
    repeat(64) @(negedge clk);
    repeat (4) begin
        @(negedge clk) begin 
            swsig2 = 1;
	    swsig0 = 1;
        end
	@(negedge clk) begin 
            swsig2 = 0;
            swsig0 = 0;
        end
    end
    repeat(128) @(negedge clk);
	
    // Pulse-5
    repeat(64) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig0 = 1;
        @(negedge clk) swsig0 = 0;
    end
    repeat(128) @(negedge clk);

    // Pulse-6
    repeat(64) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig1 = 1;
        @(negedge clk) swsig1 = 0;
    end
    repeat(128) @(negedge clk);
	
    //Pulse-7
    repeat(128) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig2 = 1;
      @(negedge clk) pbsig2 = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig2 = 0;
      @(negedge clk) pbsig2 = 1;
    end
    
    // Pulse-8
    repeat(256) @(negedge clk);
    repeat (4) begin
        @(negedge clk) swsig0 = 0;
        @(negedge clk) swsig0 = 1;
    end
    repeat(128) @(negedge clk);


    $stop;
end
endmodule
