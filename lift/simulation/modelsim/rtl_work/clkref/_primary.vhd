library verilog;
use verilog.vl_types.all;
entity clkref is
    generic(
        TC              : vl_logic_vector(0 to 22) := (Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1, Hi0, Hi1)
    );
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of TC : constant is 1;
end clkref;
