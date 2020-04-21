library verilog;
use verilog.vl_types.all;
entity switch_pulse is
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        cleansw         : in     vl_logic;
        sw_pulse        : out    vl_logic
    );
end switch_pulse;
