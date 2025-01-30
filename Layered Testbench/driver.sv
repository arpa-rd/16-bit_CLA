class driver; 
  mailbox gen2driv, driv2sb; 
  virtual cla_if.DRIVER claif; 
  transaction d_trans; 
  event driven; 
   
  function new (mailbox gen2driv, driv2sb, virtual cla_if.DRIVER claif, event driven); 
    this.gen2driv=gen2driv; 
    this.claif=claif; 
    this.driven=driven; 
    this.driv2sb=driv2sb; 
  endfunction 
   
  task main(input int count); 
  repeat(count) begin 
    d_trans=new(); 
    gen2driv.get(d_trans); 
    @(claif.driver_cb); 
    claif.driver_cb.a <= d_trans.a; 
    claif.driver_cb.b <= d_trans.b; 
    claif.driver_cb.cin <= d_trans.cin; 
    driv2sb.put(d_trans); 
    -> driven; 
  end 
  endtask:main 
endclass:driver 