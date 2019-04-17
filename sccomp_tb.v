`timescale 1ns/1ns
// 测试文件
module sccomp_tb();
 //定义输入输出端口   
   reg  clk, rstn;
   reg  [4:0] reg_sel;
   wire [31:0] reg_data;
    

//实例化顶层文件
   sccomp U_SCCOMP(
      .clk(clk), .rstn(rstn), .reg_sel(reg_sel), .reg_data(reg_data)
   );

 //初始化信号量并加载指令存储器，将指令添加到存储器中  
   initial 
   begin
      $readmemh( "mipstest_pipelinedloop.dat" , U_SCCOMP.U_IM.ROM); // load instructions into instruction memory
      clk = 1;
      rstn = 1;
      #5 ;
      rstn = 0;
      #20 ;
      rstn = 1;
      #1000 ;
      reg_sel = 7;
   end
 //50ns一次时钟翻转 
    always 
	begin
		#(50) clk = ~clk;
	end
endmodule
