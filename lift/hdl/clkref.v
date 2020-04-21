/*
        This module generates the required slow reference signal
        which is used by the whole lift system to move.
        Since we are not using a derived clock due to
        complications in the FPGA implementation, we instead moved the
        state machine usong this slowed down reference signal which is
        used like an enable signal.
*/

module clkref(
    input      clk,      // 50MHz clk
    input      resetb,   // Active low reset
    output reg slowref   // Required slow clock
);

reg [23:0] slowrefc;     // wire-reg
parameter TC = 24'hff_ffff;

always @(posedge clk or negedge resetb)
    if (!resetb) begin
      slowrefc <= 24'b0;
      slowref  <= 0;
    end else begin  //{
        if (slowrefc == TC)  begin //{ 
		  slowref  <= 1'b1;
		  slowrefc <= 24'b0;
		  end //}
        else begin //{
		  slowrefc <= slowrefc + 1'b1;
		  slowref  <= 0;
		  end //}
    end //}
endmodule
