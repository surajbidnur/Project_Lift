library verilog;
use verilog.vl_types.all;
entity number_disp is
    generic(
        gDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi0, Hi0);
        oDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi0, Hi0, Hi1);
        tDISP           : vl_logic_vector(0 to 7) := (Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi0);
        nINIT           : vl_logic_vector(0 to 7) := (Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        floorno         : in     vl_logic_vector(1 downto 0);
        numdisp         : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of gDISP : constant is 1;
    attribute mti_svvh_generic_type of oDISP : constant is 1;
    attribute mti_svvh_generic_type of tDISP : constant is 1;
    attribute mti_svvh_generic_type of nINIT : constant is 1;
end number_disp;
