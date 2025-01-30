`include "environment.sv" 
 
program test(input int count, cla_if claif); 
  environment env; 
   
  class testcase01 extends transaction; 
    //constraint c_s { 
      //s inside {[0:1], [14:15]}; 
      //s inside {[0:15]}; 
    //} 
  endclass:testcase01 
   
  initial begin 
    testcase01 testcase01handle; 
    testcase01handle=new(); 
     
    env=new(claif); 
    env.gen.custom_trans=testcase01handle; 
    env.main(count); 
  end 
   
endprogram:test 