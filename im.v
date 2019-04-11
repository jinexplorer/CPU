
// 指令寄存器，用于根据PC读取指令
module im(input  [8:2]  addr,
            output [31:0] dout );

  reg  [31:0] ROM[127:0];

  assign dout = ROM[addr]; 
endmodule  
