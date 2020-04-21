library verilog;
use verilog.vl_types.all;
entity pb_pulse is
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        clean           : in     vl_logic;
        pbpulse         : out    vl_logic
    );
end pb_pulse;
