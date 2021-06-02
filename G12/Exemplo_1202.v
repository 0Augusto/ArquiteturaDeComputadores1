/*
Nome: Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 12
Exemplo_1202.v
*/

module jkff ( output q, output qnot, input j, input k, input clk, input preset, input clear, input rw, input add ); 
  reg    q, qnot; 

   always @( posedge clk & add & rw or preset or clear ) 
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


module memoria ( output s, input add, input clk, input rw, input clear, input i ); 

    wire q, qnot;
    
    jkff JK1(q, qnot, i, ~i, clk, 1'b0, clear, rw,add);
    and AND1 ( s, add, q );
endmodule // jkff 

module memoria2( output [1:0] s, input add, input clk, input rw, input clear, input [1:0] i ); 

    memoria M0(s[0], add, clk, rw, reset, i[0]);
    memoria M1(s[1], add, clk, rw, reset, i[1]);
endmodule // jkff 

module memoria4( output [3:0] s, input add, input clk, input rw, input clear, input [3:0] i ); 
    
    wire q, qnot;
    
    memoria2 M0(s[1:0], add, clk, rw, reset, i[1:0]);
    memoria2 M1(s[3:2], add, clk, rw, reset, i[3:2]);

endmodule // jkff 

module exemplo1101;  
   reg   clk, reset, add, rw;
   reg[3:0] x;  
   wire[3:0]  s;
   
   memoria4 M4(s, add, clk, rw, reset, x);
 
   initial   
      begin    
      $display ( "Memoria 1X4 FFJK" ); 
      $display ( "Exemplo_1202" );
      $display ( "time   in    out    rw    addr" );
 
   // initial values        
      clk   = 1;        
      reset = 1;       
      x     = 0; 
   // input signal changing   
       reset = 0;   
      #10 x     = 4'b0101;  add = 1;  rw =1; 
      #10 x     = 4'b0111;  add = 1;  rw =1;
      #10 x     = 4'b0110;  add = 1;  rw =0;
      #10 x     = 4'b0110;  add = 1;  rw =0;
      #10 x     = 4'b0110;  add = 0;  rw =1;
      #10 x     = 4'b0110;  add = 1;  rw =0;
      #10 x     = 4'b1110;  add = 1;  rw =1;
      #10 x     = 4'b0110;  add = 1;  rw =0;
      #10 $finish;  
      end // initial 
 
   always   
      #5 clk = ~clk; 
 
   always @( negedge clk )   
      begin    
         $display ( "%4d  %4b  %4b  %4b %4b", $time, x, s, rw, add );   
      end // always at positive edge clocking changing 
 
endmodule // Exemplo_1202 