library verilog;
use verilog.vl_types.all;
entity ctrl is
    port(
        ID_Op           : in     vl_logic_vector(5 downto 0);
        ID_Funct        : in     vl_logic_vector(5 downto 0);
        ID_rs           : in     vl_logic_vector(4 downto 0);
        ID_rt           : in     vl_logic_vector(4 downto 0);
        ID_Zero         : in     vl_logic;
        EXE_RegWrite    : in     vl_logic;
        MEM_RegWrite    : in     vl_logic;
        EXE_mem_to_reg  : in     vl_logic;
        MEM_mem_to_reg  : in     vl_logic;
        EXE_writereg_num: in     vl_logic_vector(4 downto 0);
        MEM_writereg_num: in     vl_logic_vector(4 downto 0);
        ID_RegWrite     : out    vl_logic;
        ID_mem_to_reg   : out    vl_logic;
        ID_writereg_to_rt: out    vl_logic_vector(1 downto 0);
        ID_memwrite     : out    vl_logic;
        ID_extOp        : out    vl_logic;
        ID_aluOp        : out    vl_logic_vector(3 downto 0);
        ID_npcOp        : out    vl_logic_vector(1 downto 0);
        ID_jal          : out    vl_logic;
        ID_alua         : out    vl_logic;
        ID_alub         : out    vl_logic;
        ID_nostall      : out    vl_logic;
        ID_forwarda     : out    vl_logic_vector(1 downto 0);
        ID_forwardb     : out    vl_logic_vector(1 downto 0)
    );
end ctrl;
