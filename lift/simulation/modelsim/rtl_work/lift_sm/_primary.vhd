library verilog;
use verilog.vl_types.all;
entity lift_sm is
    generic(
        ct_tc           : integer := 15;
        LVL0            : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        LVL1U           : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        LVL1D           : vl_logic_vector(1 downto 0) := (Hi1, Hi0);
        LVL2            : vl_logic_vector(1 downto 0) := (Hi1, Hi1);
        GND             : vl_logic_vector(1 downto 0) := (Hi0, Hi0);
        ONE             : vl_logic_vector(1 downto 0) := (Hi0, Hi1);
        TWO             : vl_logic_vector(1 downto 0) := (Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        slowref         : in     vl_logic;
        upreq0          : in     vl_logic;
        upreq1          : in     vl_logic;
        dnreq1          : in     vl_logic;
        dnreq2          : in     vl_logic;
        flreq0          : in     vl_logic;
        flreq1          : in     vl_logic;
        flreq2          : in     vl_logic;
        clr_flreq0      : out    vl_logic;
        clr_flreq1      : out    vl_logic;
        clr_flreq2      : out    vl_logic;
        floorno         : out    vl_logic_vector(1 downto 0);
        clrup0          : out    vl_logic;
        clrup1          : out    vl_logic;
        clrdn1          : out    vl_logic;
        clrdn2          : out    vl_logic;
        upsig           : out    vl_logic;
        dnsig           : out    vl_logic;
        moving          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of ct_tc : constant is 1;
    attribute mti_svvh_generic_type of LVL0 : constant is 2;
    attribute mti_svvh_generic_type of LVL1U : constant is 2;
    attribute mti_svvh_generic_type of LVL1D : constant is 2;
    attribute mti_svvh_generic_type of LVL2 : constant is 2;
    attribute mti_svvh_generic_type of GND : constant is 2;
    attribute mti_svvh_generic_type of ONE : constant is 2;
    attribute mti_svvh_generic_type of TWO : constant is 2;
end lift_sm;
