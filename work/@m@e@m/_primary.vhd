library verilog;
use verilog.vl_types.all;
entity MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        EXE_C           : in     vl_logic_vector(31 downto 0);
        EXE_RegWrite    : in     vl_logic;
        EXE_mem_to_reg  : in     vl_logic;
        EXE_memwrite    : in     vl_logic;
        EXE_B           : in     vl_logic_vector(31 downto 0);
        EXE_writereg_num: in     vl_logic_vector(4 downto 0);
        MEM_C           : out    vl_logic_vector(31 downto 0);
        MEM_RegWrite    : out    vl_logic;
        MEM_mem_to_reg  : out    vl_logic;
        MEM_memwrite    : out    vl_logic;
        MEM_B           : out    vl_logic_vector(31 downto 0);
        MEM_writereg_num: out    vl_logic_vector(4 downto 0)
    );
end MEM;
