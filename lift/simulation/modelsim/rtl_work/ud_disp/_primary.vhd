library verilog;
use verilog.vl_types.all;
entity ud_disp is
    generic(
        uDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi1);
        pDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0);
        dDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1);
        nDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi0, Hi1, Hi0, Hi1, Hi1);
        dINIT           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        upsig           : in     vl_logic;
        dnsig           : in     vl_logic;
        moving          : in     vl_logic;
        d1              : out    vl_logic_vector(7 downto 0);
        d2              : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of uDISP : constant is 1;
    attribute mti_svvh_generic_type of pDISP : constant is 1;
    attribute mti_svvh_generic_type of dDISP : constant is 1;
    attribute mti_svvh_generic_type of nDISP : constant is 1;
    attribute mti_svvh_generic_type of dINIT : constant is 1;
end ud_disp;
