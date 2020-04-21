library verilog;
use verilog.vl_types.all;
entity level2_led is
    generic(
        INIT            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        UP              : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        DN              : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        UDN             : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        pbpulse         : in     vl_logic;
        clrup           : in     vl_logic;
        clrdn           : in     vl_logic;
        upreq           : out    vl_logic;
        dnreq           : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of INIT : constant is 1;
    attribute mti_svvh_generic_type of UP : constant is 1;
    attribute mti_svvh_generic_type of DN : constant is 1;
    attribute mti_svvh_generic_type of UDN : constant is 1;
end level2_led;
