library verilog;
use verilog.vl_types.all;
entity EXE is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        ID_RegWrite     : in     vl_logic;
        ID_mem_to_reg   : in     vl_logic;
        ID_memwrite     : in     vl_logic;
        ID_aluOp        : in     vl_logic_vector(3 downto 0);
        ID_jal          : in     vl_logic;
        ID_alua         : in     vl_logic;
        ID_alub         : in     vl_logic;
        ID_PC           : in     vl_logic_vector(31 downto 0);
        ID_A            : in     vl_logic_vector(31 downto 0);
        ID_B            : in     vl_logic_vector(31 downto 0);
        ID_IMM32        : in     vl_logic_vector(31 downto 0);
        ID_writereg_num : in     vl_logic_vector(4 downto 0);
        EXE_RegWrite    : out    vl_logic;
        EXE_mem_to_reg  : out    vl_logic;
        EXE_memwrite    : out    vl_logic;
        EXE_aluOp       : out    vl_logic_vector(3 downto 0);
        EXE_jal         : out    vl_logic;
        EXE_alua        : out    vl_logic;
        EXE_alub        : out    vl_logic;
        EXE_PC          : out    vl_logic_vector(31 downto 0);
        EXE_A           : out    vl_logic_vector(31 downto 0);
        EXE_B           : out    vl_logic_vector(31 downto 0);
        EXE_IMM32       : out    vl_logic_vector(31 downto 0);
        EXE_writereg_num: out    vl_logic_vector(4 downto 0)
    );
end EXE;
