module debounce_tb();
    reg      clk;
    reg      resetb;
    reg      pbsig;
    wire     clean;

always #5 clk = !clk;

initial begin
    clk = 0; resetb = 0; pbsig = 0;
    @(negedge clk) resetb = 1;
    repeat(32) @(negedge clk);
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
    $stop;
end

lift l0(
    clk,
    resetb,
    pbsig,
    clean
);

endmodule