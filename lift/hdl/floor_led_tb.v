module floor_led_tb();
    reg        clk, resetb, slowref;
    reg        pbsig;
    reg        clrup,clrdn;          // From lift                // MSB-> UP, LSB-> DOWN
    reg        upsig, dnsig;
	reg        moving;
	wire [1:0] led;
	wire [7:0] u,p,d,n;

always #5 clk = !clk;

lift l1(
    clk, resetb, slowref,
    pbsig,
    clrup,
    clrdn,
	upsig,
	dnsig,
	moving,
    clean,
    pbpulse,
    led,
    u, p, d, n	
);

initial begin
    if (l1.slowref) $display ("1");
    $display("l1.slowref %b",l1.slowref);
    
    clk = 0; resetb = 0; pbsig = 1; clrup = 0; clrdn = 0;
    @(negedge clk) resetb = 1;
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 1;
      @(negedge clk) pbsig = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 0;
      @(negedge clk) pbsig = 1;
    end
    
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 1;
      @(negedge clk) pbsig = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 0;
      @(negedge clk) pbsig = 1;
    end
    
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 1;
      @(negedge clk) pbsig = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 0;
      @(negedge clk) pbsig = 1;
    end
    
    repeat(8) @(negedge clk);
    TkL(1,0); // udc, cu, cd
    repeat(16) @(negedge clk);
    TkL(0,0);
    repeat(16) @(negedge clk);
    
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 1;
      @(negedge clk) pbsig = 0;
    end
    repeat(64) @(negedge clk);
    repeat (4) begin
      @(negedge clk) pbsig = 0;
      @(negedge clk) pbsig = 1;
    end
    
    TkL(1,0); // udc, cu, cd
    repeat(16) @(negedge clk);
    TkL(0,0);
    repeat(16) @(negedge clk);
    TkL(0,1);
    repeat(16) @(negedge clk);
    TkL(0,0);
	
	TkD(1,0,1);
	repeat (16) @(negedge clk);
	repeat (32) @(negedge clk);
	
	TkD(0,1,1);
	repeat (16) @(negedge clk);
	repeat (32) @(negedge clk);
        
    $stop;
end

task TkL;
  input       cu, cd;
  begin
    clrup = cu; clrdn = cd;
    repeat (8) @(negedge clk);
  end
endtask

task TkD;
    input     up,dn,mov;
	begin
	    upsig = up; dnsig = dn; mov = moving;
		repeat (8) @(negedge clk);
	end
endtask


endmodule