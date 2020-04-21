library verilog;
use verilog.vl_types.all;
entity debounce is
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        pbsig           : in     vl_logic;
        clean           : out    vl_logic
    );
end debounce;
