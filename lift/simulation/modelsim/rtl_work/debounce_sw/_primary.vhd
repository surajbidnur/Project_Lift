library verilog;
use verilog.vl_types.all;
entity debounce_sw is
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        swsig           : in     vl_logic;
        cleansw         : out    vl_logic
    );
end debounce_sw;
