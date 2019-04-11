library verilog;
use verilog.vl_types.all;
entity \IF\ is
    port(
        clk             : in     vl_logic;
        NPC             : in     vl_logic_vector(31 downto 0);
        IF_PC           : out    vl_logic_vector(31 downto 0);
        ID_nostall      : in     vl_logic
    );
end \IF\;
