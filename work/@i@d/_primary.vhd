library verilog;
use verilog.vl_types.all;
entity ID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ID_nostall      : in     vl_logic;
        IF_INS          : in     vl_logic_vector(31 downto 0);
        ID_INS          : out    vl_logic_vector(31 downto 0);
        IF_PC           : in     vl_logic_vector(31 downto 0);
        ID_PC           : out    vl_logic_vector(31 downto 0)
    );
end ID;
