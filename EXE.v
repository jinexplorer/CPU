module EXE (clk,rst,ID_RegWrite,ID_mem_to_reg,ID_memwrite,ID_aluOp, ID_jal,ID_alua,ID_alub,ID_PC,ID_A,ID_B,ID_IMM32,ID_writereg_num,
			EXE_RegWrite,EXE_mem_to_reg,EXE_memwrite,EXE_aluOp, EXE_jal,EXE_alua,EXE_alub,EXE_PC,EXE_A,EXE_B,EXE_IMM32,EXE_writereg_num
			);
	input 			clk,rst,ID_RegWrite,ID_mem_to_reg,ID_memwrite,ID_jal,ID_alua,ID_alub;
	input [4:0]		ID_writereg_num;
	input [3:0] 	ID_aluOp;
	input [31:0]	ID_PC,ID_A,ID_B,ID_IMM32;
	
	output reg 			EXE_RegWrite,EXE_mem_to_reg,EXE_memwrite,EXE_jal,EXE_alua,EXE_alub;
	output reg [4:0]	EXE_writereg_num;
	output reg [3:0] 	EXE_aluOp;
	output reg [31:0]	EXE_PC,EXE_A,EXE_B,EXE_IMM32;
	
	always @(posedge clk,posedge rst)
	begin
		if(rst) begin
			EXE_A=0;
			EXE_B=0;
			EXE_IMM32=0;
			EXE_PC=0;
			EXE_RegWrite=0;
			EXE_aluOp=0;
			EXE_alua=0;
			EXE_alub=0;
			EXE_jal=0;
			EXE_mem_to_reg=0;
			EXE_memwrite=0;
			EXE_writereg_num=0;
		end
		else begin
			EXE_A=ID_A;
			EXE_B=ID_B;
			EXE_IMM32=ID_IMM32;
			EXE_PC=ID_PC+4;
			EXE_RegWrite=ID_RegWrite;
			EXE_aluOp=ID_aluOp;
			EXE_alua=ID_alua;
			EXE_alub=ID_alub;
			EXE_jal=ID_jal;
			EXE_mem_to_reg=ID_mem_to_reg;
			EXE_memwrite=ID_memwrite;
			EXE_writereg_num=ID_writereg_num;
		end
	end
endmodule
//EXE级流水线更新数据模块，类似闸门的作用
//此模块仅仅起到更新数据的用途，流水线CPU的基本要求就是一个周期仅更新一次基本信号量，以此保证将一条指令分成五个周期进行		
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			