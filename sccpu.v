
//流水线CPU核心模块
module sccpu( clk, rst, instr, readdata,PC, MemWrite, aluout, writedata, reg_sel, reg_data);
   input      clk;    
   input      rst;          // reset
   
   input  [31:0]  instr;     // instruction
   input [31:0]  readdata;  // data from data memory
   
   output [31:0] PC;        // PC address
   output        MemWrite;  // memory write
   output [31:0] aluout;    // ALU output
   output [31:0] writedata; // data to data memory
   
   input  [4:0] reg_sel;    // register selection (for debug use)
   output [31:0] reg_data;  // selected register data (for debug use)

   
   
   wire [15:0] ID_IMM16;
   wire [31:0] ID_IMM32,EXE_IMM32;
   wire [31:0] NPC;
   wire [31:0] jpc,npc,bpc;
   wire [31:0] ID_INS;
   wire [31:0] ID_PC;
   wire [31:0] ID_A,ID_B;
   wire [31:0] ID_reada,ID_readb;
   wire [4:0] ID_writereg_num;
   
   wire [31:0] WB_writereg;//写向寄存器的数据
   wire [5:0] ID_Op, ID_Funct;
   wire [4:0] ID_rs,ID_rt,ID_rd,EXE_writereg_num,MEM_writereg_num;
   wire ID_Zero,EXE_RegWrite,MEM_RegWrite,EXE_mem_to_reg,MEM_mem_to_reg;
	
   wire ID_RegWrite,ID_mem_to_reg,ID_memwrite,ID_jal,ID_extOp,ID_alua,ID_alub,ID_nostall;
   wire [1:0] ID_npcOp,ID_forwarda,ID_forwardb,ID_writereg_to_rt;
   wire [3:0] ID_aluOp;
   
   
    wire 		EXE_memwrite,EXE_jal,EXE_alua,EXE_alub;
	wire [3:0] 	EXE_aluOp;
	wire [31:0]	EXE_PC,EXE_A,EXE_B,EXE_C;


	wire WB_RegWrite,WB_mem_to_reg;
	wire [31:0] WB_C,WB_read;
	wire [4:0] WB_writereg_num;
	
	wire [31:0] ALU_A,ALU_B,ALU_C;
	//用于更新PC，IF级作用
	PC U_PC(.rst(rst), .IF_PC(PC),.clk(clk),.NPC(NPC),.ID_nostall(ID_nostall));
   //此时将jal，和j指令集合到了一起。但是j是跳转指令低26，而jal仅仅16位，但是此次试验PC地址不会太大，故此处可暂时将
   assign jpc={ID_PC[31:18],ID_INS[15:0],2'b00};
   //用于寄存器跳转，主要有jalr，jr
   assign npc=ID_A;
   //用于bne，beq跳转
   assign bpc=ID_PC+{14'b0,ID_IMM16,2'b00};
   
//切分指令段
   assign ID_Op=ID_INS[31:26];
   assign ID_Funct=ID_INS[5:0];
   assign ID_rs=ID_INS[25:21];
   assign ID_rt=ID_INS[20:16];
   assign ID_rd=ID_INS[15:11];
   assign ID_IMM16=ID_INS[15:0];
  //用于bne,beq的ID级判断
   assign ID_Zero=(ID_A ==ID_B)?1'b1:1'b0;
   //ID级更新作用
   ID U_ID(.clk(clk),.rst(rst),.IF_INS(instr),.IF_PC(PC),.ID_INS(ID_INS),.ID_PC(ID_PC),.ID_nostall(ID_nostall));
   
   //控制器，核心部件
   ctrl U_CTRL(.ID_Op(ID_Op), .ID_Funct(ID_Funct),.ID_rs(ID_rs),.ID_rt(ID_rt),.ID_Zero(ID_Zero),
			.EXE_RegWrite(EXE_RegWrite),.MEM_RegWrite(MEM_RegWrite),.EXE_mem_to_reg(EXE_mem_to_reg),.MEM_mem_to_reg(MEM_mem_to_reg),.EXE_writereg_num(EXE_writereg_num),.MEM_writereg_num(MEM_writereg_num),
            .ID_RegWrite(ID_RegWrite),.ID_mem_to_reg(ID_mem_to_reg),.ID_writereg_to_rt(ID_writereg_to_rt),.ID_memwrite(ID_memwrite),
            .ID_extOp(ID_extOp), .ID_aluOp(ID_aluOp), .ID_npcOp(ID_npcOp),.ID_jal(ID_jal),.ID_alua(ID_alua),.ID_alub(ID_alub),.ID_nostall(ID_nostall),.ID_forwarda(ID_forwarda),.ID_forwardb(ID_forwardb)
			);
	//决定下一个pc信号，取决于控制器器的输出	
	mux4 #(32) U_MUX4_NPC (.d0(PC+4),.d1(bpc),.d2(npc),.d3(jpc),.s(ID_npcOp),.y(NPC));
	//决定是否进行立即数的有符号数的拓展
   EXT U_EXT(.Imm16(ID_IMM16),.EXTOp(ID_extOp),.Imm32(ID_IMM32));
    //决定是否进行旁路，进行旁路进行什么旁路
   mux4 #(32) U_MUX4_FOEWARDA  (.d0(ID_reada),.d1(EXE_C),.d2(aluout),.d3(readdata),.s(ID_forwarda),.y(ID_A));
   //决定是否进行旁路，进行旁路进行什么旁路
   mux4  #(32)  U_MUX4_FOEWARDB (.d0(ID_readb),.d1(EXE_C),.d2(aluout),.d3(readdata),.s(ID_forwardb),.y(ID_B));
   
   //决定写入寄存器的内容的来源，是EXE级计算出的，还是MEM级读出来的
   mux2 #(32) U_MUX2_WRITEREG  (.d0(WB_C),.d1(WB_read), .s(WB_mem_to_reg), .y(WB_writereg));
   
  //寄存器模块
   RF U_RF(.clk(clk),.rst(rst),.RFWr(WB_RegWrite),.A1(ID_rs),.A2(ID_rt),.A3(WB_writereg_num),.WD(WB_writereg),.RD1(ID_reada),.RD2(ID_readb),.reg_sel(reg_sel),.reg_data(reg_data));
//决定写入的寄存器号的来源，31号还是rd段或者rt段   
   mux4 #(5) U_MUX4_RT_RD (.d0(ID_rd),.d1(ID_rt),.d2(5'b11111),.d3(5'b0),.s(ID_writereg_to_rt),.y(ID_writereg_num));

   
   
//EXE级更新作用
   EXE U_EXE(.clk(clk),.rst(rst),.ID_RegWrite(ID_RegWrite),.ID_mem_to_reg(ID_mem_to_reg),.ID_memwrite(ID_memwrite),.ID_aluOp(ID_aluOp),. ID_jal( ID_jal),.ID_alua(ID_alua),.ID_alub(ID_alub),.ID_PC(ID_PC),.ID_A(ID_A),.ID_B(ID_B),.ID_IMM32(ID_IMM32),.ID_writereg_num(ID_writereg_num),
			.EXE_RegWrite(EXE_RegWrite),.EXE_mem_to_reg(EXE_mem_to_reg),.EXE_memwrite(EXE_memwrite),.EXE_aluOp(EXE_aluOp),.EXE_jal(EXE_jal),.EXE_alua(EXE_alua),.EXE_alub(EXE_alub),.EXE_PC(EXE_PC),.EXE_A(EXE_A),.EXE_B(EXE_B),.EXE_IMM32(EXE_IMM32),.EXE_writereg_num(EXE_writereg_num)
			);
//MEM级更新作用			
	MEM U_MEM(.clk(clk),.rst(rst),.EXE_C(EXE_C),.EXE_RegWrite(EXE_RegWrite),.EXE_mem_to_reg(EXE_mem_to_reg),.EXE_memwrite(EXE_memwrite),.EXE_B(EXE_B),.EXE_writereg_num(EXE_writereg_num),
				.MEM_C(aluout),.MEM_RegWrite(MEM_RegWrite),.MEM_mem_to_reg(MEM_mem_to_reg),.MEM_memwrite(MemWrite),.MEM_B(writedata),.MEM_writereg_num(MEM_writereg_num)
				);
//WB级更新作用
	WB U_WB(.clk(clk),.rst(rst),.MEM_RegWrite(MEM_RegWrite),.MEM_mem_to_reg(MEM_mem_to_reg),.MEM_read(readdata),.MEM_C(aluout),.MEM_writereg_num(MEM_writereg_num),
			.WB_RegWrite(WB_RegWrite),.WB_mem_to_reg(WB_mem_to_reg),.WB_read(WB_read),.WB_C(WB_C),.WB_writereg_num(WB_writereg_num)
			);
//决定ALUC是来自PC还是来自ALU计算的结果	
	mux2 #(32) U_MUX2_ALUC  (.d0(ALU_C),.d1(EXE_PC),.s(EXE_jal),.y(EXE_C));
//决定ALUa是来自ID级的旁路选择器的结果还是来自立即数
	mux2 #(32) U_MUX2_ALUA  (.d0(EXE_A),.d1(EXE_IMM32),.s(EXE_alua),.y(ALU_A));
//决定ALUb是来自ID级的旁路选择器的结果还是来自立即数
	mux2  #(32) U_MUX2_ALUB  (.d0(EXE_B),.d1(EXE_IMM32),.s(EXE_alub),.y(ALU_B));
//进行ALU运算
	alu U_ALU(.A(ALU_A),.B(ALU_B),.ALUOp(EXE_aluOp),.C(ALU_C));

endmodule