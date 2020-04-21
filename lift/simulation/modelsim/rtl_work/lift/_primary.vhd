library verilog;
use verilog.vl_types.all;
entity lift is
    port(
        clk             : in     vl_logic;
        resetb          : in     vl_logic;
        pbsig0          : in     vl_logic;
        pbsig1          : in     vl_logic;
        pbsig2          : in     vl_logic;
        swsig0          : in     vl_logic;
        swsig1          : in     vl_logic;
        swsig2          : in     vl_logic;
        upreq1          : out    vl_logic;
        dnreq1          : out    vl_logic;
        upreq0          : out    vl_logic;
        dnreq2          : out    vl_logic;
        d1              : out    vl_logic_vector(7 downto 0);
        d2              : out    vl_logic_vector(7 downto 0);
        flreq0          : out    vl_logic;
        flreq1          : out    vl_logic;
        flreq2          : out    vl_logic;
        numdisp         : out    vl_logic_vector(7 downto 0)
    );
end lift;
