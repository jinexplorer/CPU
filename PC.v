module PC( clk, rst, NPC, IF_PC ,ID_nostall);

  input              clk;
  input              rst,ID_nostall;
  input       [31:0] NPC;
  output reg  [31:0] IF_PC;

  always @(posedge clk, posedge rst)
    if (rst) 
      IF_PC <= 32'h0000_0000;
    else if(ID_nostall)
      IF_PC <= NPC;
      
endmodule
//ID_nostall :根据ID级的控制器决定是否锁定PC，暂停一个周期
//IF级流水线更新数据模块，类似闸门的作用
//此模块仅仅起到更新数据的用途，流水线CPU的基本要求就是一个周期仅更新一次基本信号量，以此保证将一条指令分成五个周期进行	
