module EXT( Imm16, EXTOp, Imm32 );
    
   input  [15:0] Imm16;
   input         EXTOp;
   output [31:0] Imm32;
   
   assign Imm32 = (EXTOp) ? {{16{Imm16[15]}}, Imm16} : {16'd0, Imm16}; 
       
endmodule
//默认情况下是进行高位补0 的立即数拓展
//在有符号数的情况下进行最高位的拓展