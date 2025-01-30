//design code for Hierarchical 16-bit Carry Lookahead Adder

module cla16 ( 
    input clk, 
    input [15:0] A,     
    input [15:0] B,    
    input Cin,   
    output reg [15:0] Sum,   
    output reg Cout   
); 
     
  reg [3:0] P_block, G_block;  // 4-bit Block propagate and generate 
  reg [3:0] C_block;           // 4-bit Block carry 
  reg [15:0] P, G;             // Bit propagate and generate 
 
  always@(posedge clk) begin 
      // Bit Propagate (P) and Generate (G) (1st floor) 
     P = A ^ B;  
     G = A & B;  
 
      // 4-bit CLA Generators for each block (2nd Floor) 
     cla_4bit_generator(P[3:0],G[3:0],P_block[0],G_block[0]); 
     cla_4bit_generator(P[7:4],G[7:4],P_block[1],G_block[1]); 
     cla_4bit_generator(P[11:8],G[11:8],P_block[2],G_block[2]); 
     cla_4bit_generator(P[15:12],G[15:12],P_block[3],G_block[3]); 
       
      // Block and final Carry Logic (3rd floor) 
     carry_block_generator(P_block,G_block,Cin,C_block,Cout); 
        
      // Compute carry signals (2nd floor) and sum (1st floor) 
     bit_sum(P[3:0],G[3:0],C_block[0],Sum[3:0]); 
     bit_sum(P[7:4],G[7:4],C_block[1],Sum[7:4]); 
     bit_sum(P[11:8],G[11:8],C_block[2],Sum[11:8]); 
     bit_sum(P[15:12],G[15:12],C_block[3],Sum[15:12]); 
  end 
 
  task cla_4bit_generator ( 
      input [3:0] P,        
      input [3:0] G,       
      output reg P_block, 
      output reg G_block 
  ); 
    begin 
     P_block = (P[3] & P[2] & P[1] & P[0]); 
     G_block = (G[3] | (P[3] & G[2]) | (P[3] & P[2] & G[1]) | (P[3] & P[2] & P[1] & G[0])); 
    end 
  endtask 
 
  task carry_block_generator ( 
      input [3:0] P,        
      input [3:0] G,        
      input Cin,     
      output reg [3:0] C,       
      output reg Cout  
  ); 
    begin 
      // Compute block carries 
     C[0] = Cin; 
     C[1] = (G[0] | (P[0] & C[0])); 
        C[2] = (G[1] | (P[1] & C[1])); 
        C[3] = (G[2] | (P[2] & C[2])); 
 
      // Compute final carry-out 
     Cout = (G[3] | (P[3] & C[3])); 
    end 
  endtask 
 
  task bit_sum ( 
      input [3:0] P,G, 
      input Cin, 
      output reg [3:0] Sum 
  ); 
    begin 
        Sum[0]=(P[0]^Cin); 
        Sum[1]=(P[1]^(G[0]|(P[0]&Cin))); 
        Sum[2]=(P[2]^(G[1]|(G[0]&P[1])|(P[0]&P[1]&Cin))); 
        Sum[3]=(P[3]^(G[2]|(G[1]&P[2])|(G[0]&P[2]&P[1])|(P[0]&P[1]&P[2]&Cin))); 
    end 
  endtask 
endmodule