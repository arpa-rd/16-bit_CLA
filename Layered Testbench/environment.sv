`include "generator.sv" 
`include "driver.sv" 
`include "monitor.sv" 
`include "scoreboard.sv" 
class environment; 
   
  mailbox gen2driv; 
  mailbox driv2sb; 
  mailbox mon2sb; 
   
  generator gen;  
  driver drv;  
  monitor mon;  
  scoreboard scb; 
   
  event driven; 
  virtual cla_if claif; 
  function new (virtual cla_if claif); 
    this.claif=claif; 
    gen2driv=new(); 
    driv2sb=new(); 
    mon2sb=new(); 
    gen=new(gen2driv); 
    drv=new(gen2driv, driv2sb, claif.DRIVER, driven); 
    mon=new (mon2sb, claif.MONITOR, driven); 
 scb=new(driv2sb,mon2sb); 
  endfunction 
   
  task main(input int count); 
    fork gen.main(count);  
        drv.main(count); 
         mon.main(count); 
         scb.main(count); 
    join 
    $finish; 
  endtask:main 
   
endclass: environment