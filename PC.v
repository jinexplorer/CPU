module PC( clk, rst, NPC, IF_PC ,ID_nostall);

  input              clk;
  input              rst,ID_nostall;
  input       [31:0] NPC;
  output reg  [31:0] IF_PC;

  always @(posedge clk, posedge rst)
    if (rst) 
      IF_PC <= 32'h0000_0000;
//      PC <= 32'h0000_3000;
    else if(ID_nostall)
      IF_PC <= NPC;
      
endmodule

