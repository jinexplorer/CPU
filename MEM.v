module MEM(clk,rst,EXE_C,EXE_RegWrite,EXE_mem_to_reg,EXE_memwrite,EXE_B,EXE_writereg_num,
				MEM_C,MEM_RegWrite,MEM_mem_to_reg,MEM_memwrite,MEM_B,MEM_writereg_num,
			);
	input clk,rst,EXE_RegWrite,EXE_mem_to_reg,EXE_memwrite;
	input [31:0] EXE_B,EXE_C;
	input [4:0] EXE_writereg_num;
	
	output reg MEM_RegWrite,MEM_mem_to_reg,MEM_memwrite;
	output reg [31:0] MEM_B,MEM_C;
	output reg [4:0] MEM_writereg_num;
	
	always @(posedge clk,posedge rst)
	begin
		if(rst)
		begin 
			MEM_B=0;
			MEM_C=0;
			MEM_RegWrite=0;
			MEM_mem_to_reg=0;
			MEM_memwrite=0;
			MEM_writereg_num=0;
		end
		else begin
			MEM_B=EXE_B;
			MEM_C=EXE_C;
			MEM_RegWrite=EXE_RegWrite;
			MEM_mem_to_reg=EXE_mem_to_reg;
			MEM_memwrite=EXE_memwrite;
			MEM_writereg_num=EXE_writereg_num;
		end
	end
endmodule
//MEM级流水线更新数据模块，类似闸门的作用
//此模块仅仅起到更新数据的用途，流水线CPU的基本要求就是一个周期仅更新一次基本信号量，以此保证将一条指令分成五个周期进行		