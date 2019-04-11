
// data memory
module dm(clk, DMWr, addr, din, dout);
   input          clk;
   input          DMWr;
   input  [8:2]   addr;
   input  [31:0]  din;
   output [31:0]  dout;
     
   reg [31:0] dmem[127:0];
   
   always @(posedge clk)
      if (DMWr) begin
         dmem[addr[8:2]] <= din;
        $display("dmem[0x%8X] = 0x%8X,", addr << 2, din); 
      end
   assign dout = dmem[addr[8:2]];
    
endmodule    
//始终读取ROM存储器中的数据，仅当有写信号且有时钟之时才将数据写入ROM