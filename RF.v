
  module RF(   input         clk, 
               input         rst,
               input         RFWr, 
               input  [4:0]  A1, A2, A3, 
               input  [31:0] WD, 
               output [31:0] RD1, RD2,
               input  [4:0]  reg_sel,
               output [31:0] reg_data);

  reg [31:0] rf[31:0];

  integer i;
//目前暂定为时钟的下降沿写入数据，上升沿复位
  always @(negedge clk, posedge rst)
    if (rst) begin    //  reset
      for (i=1; i<32; i=i+1)
        rf[i] <= 0; //  i;
    end
      
    else
      if (RFWr) begin
        rf[A3] <= WD;
      end
    

  assign RD1 = (A1 != 0) ? rf[A1] : 0;
  assign RD2 = (A2 != 0) ? rf[A2] : 0;
  assign reg_data = (reg_sel != 0) ? rf[reg_sel] : 0; 

endmodule 
//指令寄存器，一直读，时钟下降沿和写使能信号写入数据