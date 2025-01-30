class scoreboard; 
   
  mailbox driv2sb; 
  mailbox mon2sb; 
   
  transaction d_trans; 
  transaction m_trans; 
  event driven; 
   
  function new(mailbox driv2sb, mon2sb); 
    this.driv2sb=driv2sb; 
    this.mon2sb=mon2sb; 
  endfunction 
   
  task main(input int count); 
    $display("--Scoreboard Test Starts- -"); 
    repeat(count) begin
    m_trans=new(); 
    mon2sb.get(m_trans); 
    report(); 
    if((m_trans.sum != d_trans.sum)||(m_trans.cout != d_trans.cout)) 
     $display("Failed : a=%d b=%d cin=%d  Expected sum=%d  Resulted sum=%d Expected 
cout=%d  Resulted cout=%d",d_trans.a,d_trans.b, d_trans.cin,d_trans.sum, m_trans.sum,d_trans.cout, 
m_trans.cout); 
    else 
        $display("Passed : a=%d b=%d cin=%d  Expected sum=%d  Resulted sum=%d Expected 
cout=%d  Resulted cout=%d",d_trans.a,d_trans.b, d_trans.cin,d_trans.sum, m_trans.sum,d_trans.cout, 
m_trans.cout); 
    end 
    $display("--Scoreboard Test Ends---"); 
  endtask:main 
              
  task report(); 
    d_trans=new(); 
    driv2sb.get(d_trans); 
    {d_trans.cout,d_trans.sum}=d_trans.a+d_trans.b+d_trans.cin; 
  endtask: report 
   
endclass:scoreboard 