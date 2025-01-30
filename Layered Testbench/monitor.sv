class monitor; 
   
  mailbox mon2sb; 
  virtual cla_if.MONITOR claif; 
  transaction m_trans; 
  event driven; 
  function new(mailbox mon2sb, virtual cla_if.MONITOR claif, event driven); 
    this.mon2sb=mon2sb; 
    this.claif=claif; 
    this.driven=driven; 
  endfunction 
   
  task main(input int count); 
    @(driven); 
    @(claif.mon_cb); repeat(count) begin 
    m_trans=new(); 
    @(posedge claif.clk); 
    m_trans.cout=claif.mon_cb.cout; 
    m_trans.sum=claif.mon_cb.sum; 
    mon2sb.put(m_trans); 
  end 
endtask:main 
endclass: monitor 