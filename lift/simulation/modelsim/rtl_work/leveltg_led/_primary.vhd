library verilog;
use verilog.vl_types.all;
entity leveltg_led is
    generic(
        INIT            : vl_logic := Hi0;
        pTG             : vl_logic := Hi1
    );
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        pbpulse         : in     vl_logic;
        clr             : in     vl_logic;
        tg              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INIT : constant is 1;
    attribute mti_svvh_generic_type of pTG : constant is 1;
end leveltg_led;
