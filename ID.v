module ID(clk,rst,ID_nostall,IF_INS,ID_INS,IF_PC,ID_PC);

input clk,rst,ID_nostall;
input [31:0] IF_INS,IF_PC;
output reg [31:0] ID_INS,ID_PC;

always@(posedge clk,posedge rst)
	begin
		if(rst)
			ID_INS =32'b0;
		else if(ID_nostall)
		begin
			ID_INS = IF_INS;
			ID_PC=IF_PC+4;
		end
	end	
endmodule
//ID级流水线更新数据模块，类似闸门的作用
//此模块仅仅起到更新数据的用途，流水线CPU的基本要求就是一个周期仅更新一次基本信号量，以此保证将一条指令分成五个周期进行