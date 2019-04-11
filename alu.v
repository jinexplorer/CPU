`include "ctrl_encode_def.v"

module alu(A, B, ALUOp, C);
 //定义端口输入输出          
   input  signed [31:0] A, B;
   input         [3:0]  ALUOp;
   output signed [31:0] C;
   
   reg [31:0] C;
   integer    i;
       
   always @( * ) 
   begin
      case ( ALUOp) 
          `ALU_NOP:  C = A;			                    		 // NOP
          `ALU_ADD:  C = A + B;                    	     		 // ADD
          `ALU_SUB:  C = A - B;         		  	  			  // SUB
          `ALU_AND:  C = A & B;                    				  // AND/ANDI
          `ALU_OR:   C = A | B;                    				  // OR/ORI
          `ALU_SLT:  C = (A < B) ? 32'd1 : 32'd0;  				  // SLT/SLTI
          `ALU_SLTU: C = ({1'b0, A} < {1'b0, B}) ? 32'd1 : 32'd0;	//SLTU
		  `ALU_SLL:  C = B << A[10:6];							 //SLL
		  `ALU_SLLV: C = B << A[4:0];							//SLLV
		  `ALU_SRL:  C = B >> A[10:6];							 //SRL
		  `ALU_SRLV: C = B >> A[4:0];								//SRLV
		  `ALU_NOR:  C = ~(A|B)	;								 //NOR
		  `ALU_LUI:  C = B << 16;
          default:   C = A;                        				  // Undefined
      endcase
   end // end always
   

endmodule
    
