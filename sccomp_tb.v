
// testbench for simulation
module sccomp_tb();
    
   reg  clk, rstn;
   reg  [4:0] reg_sel;
   wire [31:0] reg_data;
    
// instantiation of sccomp    
   sccomp U_SCCOMP(
      .clk(clk), .rstn(rstn), .reg_sel(reg_sel), .reg_data(reg_data)
   );

  	integer foutput;
  	integer counter = 0;
   
   initial begin
      $readmemh( "456.dat" , U_SCCOMP.U_IM.ROM); // load instructions into instruction memory
      clk = 1;
      rstn = 1;
      #5 ;
      rstn = 0;
      #20 ;
      rstn = 1;
      #1000 ;
      reg_sel = 7;
   end
   
    always begin
    #(50) clk = ~clk;
	   
/*    if (clk == 1'b1) begin
      if ((counter == 1000) || (U_SCCOMP.U_SCPU.PC === 32'hxxxxxxxx)) begin
        $stop;
      end
      else begin
        if (U_SCCOMP.PC == 32'h00000100) begin
          counter = counter + 1;
          $stop;
        end
        else begin
          counter = counter + 1;
        end
      end
    end
 */ end //end always
   
endmodule
