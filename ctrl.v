// `include "ctrl_encode_def.v"

module ctrl(ID_Op, ID_Funct,ID_rs,ID_rt,ID_Zero,
			EXE_RegWrite,MEM_RegWrite,EXE_mem_to_reg,MEM_mem_to_reg,EXE_writereg_num,MEM_writereg_num,
            ID_RegWrite,ID_mem_to_reg,ID_writereg_to_rt,ID_memwrite,
            ID_extOp, ID_aluOp, ID_npcOp,ID_jal,ID_alua,ID_alub,ID_nostall,ID_forwarda,ID_forwardb,
            );
            
   
	input [5:0] ID_Op, ID_Funct;
	input [4:0] ID_rs,ID_rt,EXE_writereg_num,MEM_writereg_num;
	input ID_Zero,EXE_RegWrite,MEM_RegWrite,EXE_mem_to_reg,MEM_mem_to_reg;
	
	output ID_RegWrite,ID_mem_to_reg,ID_memwrite,ID_jal,ID_extOp,ID_alua,ID_alub,ID_nostall;
	output [1:0] ID_npcOp,ID_forwarda,ID_forwardb,ID_writereg_to_rt;
	output [3:0] ID_aluOp;
	
	reg [1:0] ID_forwarda,ID_forwardb;
	
	// r format
	wire rtype  = ~|ID_Op;
	wire i_add  = 	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&~ID_Funct[2]&~ID_Funct[1]&~ID_Funct[0]; // add
	wire i_sub  = 	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&~ID_Funct[2]& ID_Funct[1]&~ID_Funct[0]; // sub
	wire i_and  = 	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]& ID_Funct[2]&~ID_Funct[1]&~ID_Funct[0]; // and
	wire i_or   = 	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]& ID_Funct[2]&~ID_Funct[1]& ID_Funct[0]; // or
	wire i_slt  = 	rtype& ID_Funct[5]&~ID_Funct[4]& ID_Funct[3]&~ID_Funct[2]& ID_Funct[1]&~ID_Funct[0]; // slt
	wire i_sltu = 	rtype& ID_Funct[5]&~ID_Funct[4]& ID_Funct[3]&~ID_Funct[2]& ID_Funct[1]& ID_Funct[0]; // sltu
	wire i_addu = 	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&~ID_Funct[2]&~ID_Funct[1]& ID_Funct[0]; // addu
	wire i_subu = 	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&~ID_Funct[2]& ID_Funct[1]& ID_Funct[0]; // subu
   
	//刘大进补充
	wire i_sll 	= 	rtype& ~ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&~ID_Funct[2]& ~ID_Funct[1]& ~ID_Funct[0];
	wire i_srl 	= 	rtype& ~ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&~ID_Funct[2]& ID_Funct[1]& ~ID_Funct[0];
	wire i_jalr = 	rtype& ~ID_Funct[5]&~ID_Funct[4]&ID_Funct[3]&~ID_Funct[2]& ~ID_Funct[1]& ID_Funct[0];
	wire i_jr	= 	rtype& ~ID_Funct[5]&~ID_Funct[4]&ID_Funct[3]&~ID_Funct[2]& ~ID_Funct[1]& ~ID_Funct[0];
	wire i_nor 	=	rtype& ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&ID_Funct[2]& ID_Funct[1]& ID_Funct[0];
	wire i_sllv =	rtype& ~ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&ID_Funct[2]& ~ID_Funct[1]& ~ID_Funct[0];
	wire i_srlv = 	rtype& ~ID_Funct[5]&~ID_Funct[4]&~ID_Funct[3]&ID_Funct[2]& ID_Funct[1]& ~ID_Funct[0];
	// i format
	wire i_addi = 	~ID_Op[5]&~ID_Op[4]& ID_Op[3]&~ID_Op[2]&~ID_Op[1]&~ID_Op[0]; // addi
	wire i_ori  = 	~ID_Op[5]&~ID_Op[4]& ID_Op[3]& ID_Op[2]&~ID_Op[1]& ID_Op[0]; // ori
	wire i_lw   =  	ID_Op[5]&~ID_Op[4]&~ID_Op[3]&~ID_Op[2]& ID_Op[1]& ID_Op[0]; // lw
	wire i_sw   = 	 ID_Op[5]&~ID_Op[4]& ID_Op[3]&~ID_Op[2]& ID_Op[1]& ID_Op[0]; // sw
	wire i_beq  = 	~ID_Op[5]&~ID_Op[4]&~ID_Op[3]& ID_Op[2]&~ID_Op[1]&~ID_Op[0]; // beq
	wire i_lui  = 	~ID_Op[5]&~ID_Op[4]&ID_Op[3]& ID_Op[2]&ID_Op[1]&ID_Op[0];//lui
	wire i_slti = 	~ID_Op[5]&~ID_Op[4]&ID_Op[3]& ~ID_Op[2]&ID_Op[1]&~ID_Op[0];//slti
	wire i_bne  = 	~ID_Op[5]&~ID_Op[4]&~ID_Op[3]& ID_Op[2]&~ID_Op[1]&ID_Op[0];//bne
	wire i_andi =	~ID_Op[5]&~ID_Op[4]&ID_Op[3]& ID_Op[2]&~ID_Op[1]&~ID_Op[0];//andi
	// j format
	wire i_j    =	~ID_Op[5]&~ID_Op[4]&~ID_Op[3]&~ID_Op[2]& ID_Op[1]&~ID_Op[0];  // j
	wire i_jal  = 	~ID_Op[5]&~ID_Op[4]&~ID_Op[3]&~ID_Op[2]& ID_Op[1]& ID_Op[0];  // jal
	
	
	//用于检测lw冒险的时候lw的下一条指令是否使用rs，rt寄存器。
	wire i_rs = i_add | i_sub | i_and |i_or | i_slt | i_sltu | i_addu | i_subu | i_jalr | i_jr | i_nor | i_sllv | i_srlv | i_addi | i_ori | i_lw | i_sw | i_beq | i_slti | i_bne | i_andi;
	wire i_rt = i_add | i_sub | i_and |i_or | i_slt | i_sltu | i_addu | i_subu | i_sll | i_srl | i_nor | i_sllv | i_srlv | i_beq | i_bne | i_sw;
	//允许写寄存器
	assign ID_RegWrite	=	(i_add |i_sub| i_and|i_or|i_slt|i_sltu|i_addu|i_subu| i_lw | i_addi | i_ori | i_jal | i_lui | i_slti | i_sll | i_srl | i_jalr| i_andi | i_nor | i_sllv | i_srlv) & ID_nostall; // register write 
	
	//允许写ROM
	assign ID_memwrite   = i_sw & ID_nostall;                           // memory write
	
	//写入寄存器的来源是内存中读出来的,否则就是从alu中读出来的
	assign ID_mem_to_reg = i_lw;
	
	//lw/sw型数据冒险，停止后序指令一个周期
	assign ID_nostall = ~(EXE_RegWrite & EXE_mem_to_reg & (EXE_writereg_num !=0) & ( i_rs & (EXE_writereg_num == ID_rs) | i_rt & (EXE_writereg_num == ID_rt)));
						
	//默认情况下指令的写是写到rd寄存器，但是在一些立即数包括lw的运算上是写到rt上的
	//更奇怪的是jal是写到31号寄存器的,但是却没有31号寄存器的标识！！
	assign ID_writereg_to_rt [0] = i_lw  | i_addi | i_ori | i_lui | i_slti | i_andi;
	assign ID_writereg_to_rt [1] = i_jal;
	//默认情况下往寄存器中写的是数，但在jal和jalr的情况下，往31号寄存中写的是PC地址
	assign ID_jal = i_jal | i_jalr;

	//正常进行高位填充0进行符号拓展，但是在有符号数的情况下就是填充最高位进行拓展
	assign ID_extOp = i_addi | i_lw | i_sw | i_bne | i_beq;

	//正常情况下alua是来自forwarda信号控制的多路选择器的，也就是寄存器的，但在sll，srl却是来自shamt字段的，此时就要传递符号拓展后的立即数然后切片的
	assign ID_alua = i_sll | i_srl;
	
	//正常情况下alub是来自forwardb信号控制的多路选择器的，也就是寄存器的，但是在addi等的情况下却来自拓展后的立即数
	assign ID_alub = i_addi | i_andi | i_ori | i_lw | i_sw | i_lui | i_slti;
	
	//默认情况下是进行pc+4，只有出现跳转指令时
	//我们定义01 bpc就是立即数+地址跳转
	//10 npc寄存器跳转 典型的有jr jalr
	//11 jpc就是指令跳转，典型的有j，jal；
	assign ID_npcOp[1] = i_jr | i_jalr | i_j | i_jal;
	assign ID_npcOp[0] = i_beq & ID_Zero | i_bne & ~ID_Zero | i_j | i_jal;
	
	//旁路
	always @ (ID_rs,ID_rt,EXE_RegWrite,EXE_mem_to_reg,EXE_writereg_num,MEM_RegWrite,MEM_mem_to_reg,MEM_writereg_num)
		begin
		
		ID_forwarda = 2'b00;//默认没有冒险
		if(EXE_RegWrite & (EXE_writereg_num!=0) &(EXE_writereg_num ==ID_rs) & ~EXE_mem_to_reg)
			begin
				ID_forwarda = 2'b01;//发生EXE-ID级R型冒险
			end
		else if(MEM_RegWrite & (MEM_writereg_num!=0) &(MEM_writereg_num ==ID_rs) &~MEM_mem_to_reg)
			begin
				ID_forwarda = 2'b10;//发生MEM-ID级冒险
			end
		else if(MEM_RegWrite & (MEM_writereg_num!=0) & (MEM_writereg_num==ID_rs) & MEM_mem_to_reg)
			begin
				ID_forwarda = 2'b11;//发生lw型的冒险
			end
			
		ID_forwardb = 2'b00;//默认没有冒险
		if(EXE_RegWrite & (EXE_writereg_num!=0) &(EXE_writereg_num ==ID_rt) & ~EXE_mem_to_reg)
			begin
				ID_forwardb = 2'b01;//发生EXE-ID级R型冒险
			end
		else if(MEM_RegWrite & (MEM_writereg_num!=0) &(MEM_writereg_num ==ID_rt) &~MEM_mem_to_reg)
			begin
				ID_forwardb = 2'b10;//发生MEM-ID级冒险
			end
		else if(MEM_RegWrite & (MEM_writereg_num!=0) & (MEM_writereg_num==ID_rt) & MEM_mem_to_reg)
			begin
				ID_forwardb = 2'b11;//发生lw型的冒险
			end	
		end
		
	//执行ALU指令
	assign ID_aluOp[0] = i_add | i_lw | i_sw | i_addi | i_and | i_slt | i_addu | i_sll | i_andi | i_nor |i_srlv;
	assign ID_aluOp[1] = i_sub | i_beq | i_and | i_sltu | i_subu | i_sll | i_slti | i_bne | i_andi | i_sllv|i_srlv;
	assign ID_aluOp[2] = i_or | i_ori | i_slt | i_sltu | i_sll | i_slti | i_lui ; 
	assign ID_aluOp[3] = i_srl | i_nor |i_sllv|i_srlv | i_lui;
		
endmodule
