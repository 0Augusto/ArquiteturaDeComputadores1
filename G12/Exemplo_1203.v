/*
Nome: Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 12
Exemplo_1203.v
*/

module jkff ( output q, output qnot, input j, input k, input clk, input preset, input clear, input rw, input add ); 
  reg    q, qnot; 

   always @( posedge clk & rw or preset or clear ) 
   begin   
      if ( clear )      
      begin 
         q <= 0; 
         qnot <= 1; 
      end   
      else     
         if ( preset )  
         begin 
            q <= 1; qnot <= 0;
         end     
         else       
            if ( j & ~k ) 
            begin 
               q <= 1; 
               qnot <= 0; 
            end       
            else        
               if ( ~j & k )
               begin 
                  q <= 0; 
                  qnot <= 1; 
               end        
               else         
                  if ( j & k )                 
                  begin 
                     q <= ~q; 
                     qnot <= ~qnot; 
                   end 
end 
 
endmodule // jkff 

module MUX(output s0, input x,y, seletor);
    wire sa, so, notseletor, sa1, sa2;
    
    
    not NOT1 (notseletor, seletor);
    and AND1(sa1, y, seletor);
    and AND2(sa2, x, notseletor);
    or OR1 (s0, sa1, sa2);
    
endmodule    
module DEMUX(output s0, s1, input x, seletor);
    wire notseletor;
    not NOT1(notseletor, seletor);
    and AND1(s0, notseletor, x);
    and AND2(s1, seletor, x);
    
endmodule

module memoria ( output s, input add, input clk, input rw, input clear, input i ); 
    wire q, qnot;
    
    jkff JK1(q, qnot, i, ~i, clk, 1'b0, clear, rw,add);
    and AND1 ( s, add, q );
endmodule // jkff 

module memoria4( output [7:0] s, input add, input clk, input rw, input clear, input [7:0] i ); 
    
    wire q, qnot;
    
    memoria M0(s[0], add, clk, rw, reset, i[0]);
    memoria M1(s[1], add, clk, rw, reset, i[1]);
    memoria M2(s[2], add, clk, rw, reset, i[2]);
    memoria M3(s[3], add, clk, rw, reset, i[3]);
    memoria M4(s[4], add, clk, rw, reset, i[4]);
    memoria M5(s[5], add, clk, rw, reset, i[5]);
    memoria M6(s[6], add, clk, rw, reset, i[6]);
    memoria M7(s[7], add, clk, rw, reset, i[7]);
    
endmodule // jkff 

module endereco( output[7:0] s, input add, input clk, input rw, input clear, input[7:0] i ); 
    wire q, qnot, add1, add2;
    wire[7:0] s1, s2, s;
    DEMUX dmx1(add1, add2, 1'b1, add);
    
    memoria4 M41(s1, add1, clk, rw, reset, i);
    memoria4 M42(s2, add2, clk, rw, reset, i);
    
    MUX MUX0( s[0], s1[0], s2[0], add);
    MUX MUX1( s[1], s1[1], s2[1], add);
    MUX MUX2( s[2], s1[2], s2[2], add);
    MUX MUX3( s[3], s1[3], s2[3], add);
    MUX MUX4( s[4], s1[4], s2[4], add);
    MUX MUX5( s[5], s1[5], s2[5], add);
    MUX MUX6( s[6], s1[6], s2[6], add);
    MUX MUX7( s[7], s1[7], s2[7], add);


    
endmodule // jkff 

module exemplo1101;  
   reg   clk, reset, add, rw;
   reg[7:0] x;  
   wire[7:0]  s;
   
   endereco E2(s, add, clk, rw, reset, x);
 
   initial   
      begin    
      $display ( "Memoria 1X4 FFJK" ); 
      $display ( "Exemplo_1203" );
      $display ("Henrique Augusto Rodigues - 675263");
      $display ( "time   in         out       rw    addr" );
   
   // initial values        
      clk   = 1;        
      reset = 1;       
      x     = 0; 
   // input signal changing   
       reset = 0;   
      #10 x     = 7'b0100101;  add = 1;  rw =1; 
      #10 x     = 7'b0000111;  add = 0;  rw =1;
      #10 x     = 7'b1110110;  add = 0;  rw =0;
      #10 x     = 7'b0110110;  add = 1;  rw =0;
      #10 x     = 7'b0111010;  add = 0;  rw =0;
      #10 x     = 7'b1100110;  add = 0;  rw =1;
      #10 x     = 7'b0110110;  add = 1;  rw =0;
      #10 x     = 7'b0110110;  add = 0;  rw =0;
      #10 x     = 7'b0110110;  add = 0;  rw =0;
      #10 $finish;  
      end // initial 
 
   always   
      #5 clk = ~clk; 
 
   always @( negedge clk )   
      begin    
         $display ( "%4d  %4b  %4b  %4b %4b", $time, x, s, rw, add );   
      end // always at positive edge clocking changing 
 
endmodule // Exemplo_1201 