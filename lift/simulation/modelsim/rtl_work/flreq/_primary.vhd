library verilog;
use verilog.vl_types.all;
entity flreq is
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        sw_pulse        : in     vl_logic;
        clr_flreq       : in     vl_logic;
        flreq_led       : out    vl_logic
    );
end flreq;
