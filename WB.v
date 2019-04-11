module WB(clk,rst,MEM_RegWrite,MEM_mem_to_reg,MEM_read,MEM_C,MEM_writereg_num,
			WB_RegWrite,WB_mem_to_reg,WB_read,WB_C,WB_writereg_num
			);
	input clk,rst,MEM_RegWrite,MEM_mem_to_reg;
	input [31:0] MEM_C,MEM_read;
	input [4:0] MEM_writereg_num;
	
	output reg WB_RegWrite,WB_mem_to_reg;
	output reg [31:0] WB_C,WB_read;
	output reg [4:0] WB_writereg_num;
	
	always @(posedge clk,posedge rst)
	begin
		if(rst)
		begin
			WB_C=0;
			WB_RegWrite=0;
			WB_mem_to_reg=0;
			WB_read=0;
			WB_writereg_num=0;	
		end
		else begin
			WB_C=MEM_C;
			WB_RegWrite=MEM_RegWrite;
			WB_mem_to_reg=MEM_mem_to_reg;
			WB_read=MEM_read;
			WB_writereg_num=MEM_writereg_num;
		end
	end
endmodule
//WB级流水线更新数据模块，类似闸门的作用
//此模块仅仅起到更新数据的用途，流水线CPU的基本要求就是一个周期仅更新一次基本信号量，以此保证将一条指令分成五个周期进行	