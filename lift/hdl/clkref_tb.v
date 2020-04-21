module clkref_tb();
reg clk,resetb;
wire slowref;

always #5 clk = !clk;

initial begin
clk = 0; resetb = 0;
@(negedge clk) resetb = 1;
repeat(1000) @(negedge clk);
$stop;
end

clkref dut(
clk,
resetb,
slowref
);

endmodule

