interface cla_if (input clk); 
  logic [15:0] a,b; 
  logic cin; 
  logic [15:0] sum; 
  logic cout; 
   
  clocking driver_cb @(negedge clk); default input #1 output #1; 
 output a, b,cin; 
  endclocking 
   
  clocking mon_cb @(negedge clk); default input #1 output #1; 
    input a,b,cin; 
    input sum,cout; 
  endclocking 
   
  modport DRIVER (clocking driver_cb, input clk);  
  modport MONITOR (clocking mon_cb, input clk); 
endinterface