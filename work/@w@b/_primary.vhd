library verilog;
use verilog.vl_types.all;
entity WB is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MEM_RegWrite    : in     vl_logic;
        MEM_mem_to_reg  : in     vl_logic;
        MEM_read        : in     vl_logic_vector(31 downto 0);
        MEM_C           : in     vl_logic_vector(31 downto 0);
        MEM_writereg_num: in     vl_logic_vector(4 downto 0);
        WB_RegWrite     : out    vl_logic;
        WB_mem_to_reg   : out    vl_logic;
        WB_read         : out    vl_logic_vector(31 downto 0);
        WB_C            : out    vl_logic_vector(31 downto 0);
        WB_writereg_num : out    vl_logic_vector(4 downto 0)
    );
end WB;
