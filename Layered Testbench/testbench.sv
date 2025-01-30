`include "testcase01.sv" 
//`include "test.sv" 
`include "interface.sv" 
 
module testbench; 
  bit clk; 
   
   
  initial begin 
    forever #5 clk =~clk; 
  end 
   
  int count=15; 
  cla_if claif(clk); 
   
  test test01(count,claif); 
   
  initial begin 
    $dumpfile("dump.vcd"); 
    $dumpvars; 
  end 
   
  cla16 DUT ( 
    .A(claif.a), 
    .B(claif.b), 
    .Cin(claif.cin), 
    .Sum(claif.sum), 
    .Cout(claif.cout), 
    .clk(clk) 
  ); 
   
Endmodule 