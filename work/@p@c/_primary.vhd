library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        NPC             : in     vl_logic_vector(31 downto 0);
        IF_PC           : out    vl_logic_vector(31 downto 0);
        ID_nostall      : in     vl_logic
    );
end PC;
