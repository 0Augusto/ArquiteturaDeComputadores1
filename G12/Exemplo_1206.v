/*
Nome: Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 12
Exemplo_1206.v
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

module memoria4( output [16:0] s, input add, input clk, input rw, input clear, input [16:0] i ); 
    
    wire q, qnot;
    
    memoria M0(s[0], add, clk, rw, reset, i[0]);
    memoria M1(s[1], add, clk, rw, reset, i[1]);
    memoria M2(s[2], add, clk, rw, reset, i[2]);
    memoria M3(s[3], add, clk, rw, reset, i[3]);
    memoria M4(s[4], add, clk, rw, reset, i[4]);
    memoria M5(s[5], add, clk, rw, reset, i[5]);
    memoria M6(s[6], add, clk, rw, reset, i[6]);
    memoria M7(s[7], add, clk, rw, reset, i[7]);
    memoria M8(s[8], add, clk, rw, reset, i[8]);
    memoria M9(s[9], add, clk, rw, reset, i[9]);
    memoria M10(s[10], add, clk, rw, reset, i[10]);
    memoria M11(s[11], add, clk, rw, reset, i[11]);
    memoria M12(s[12], add, clk, rw, reset, i[12]);
    memoria M13(s[13], add, clk, rw, reset, i[13]);
    memoria M14(s[14], add, clk, rw, reset, i[14]);
    memoria M15(s[15], add, clk, rw, reset, i[15]);
    
endmodule // jkff 

module exemplo1101;  
   reg   clk, reset, add, rw;
   reg[15:0] x;  
   wire[15:0]  s;
   
   memoria4 M4(s, add, clk, rw, reset, x);
 
   initial   
      begin    
      $display ( "Memoria 1X4 FFJK" ); 
      $display ( "Exemplo_1206" );
      $display ("Henrique Augusto Rodrigues - 675263");
      $display ( "time         in              out            rw    addr" );
 
   // initial values        
      clk   = 1;        
      reset = 1;       
      x     = 0; 
   // input signal changing   
       reset = 0;   
      #10 x     = 16'b0101111111111111;  add = 2'b01;  rw =1; 
      #10 x     = 16'b0111000000000000;  add = 2'b01;  rw =1;
      #10 x     = 16'b0110000000000001;  add = 2'b01;  rw =0;
      #10 x     = 16'b0110110011001100;  add = 2'b01;  rw =0;
      #10 x     = 16'b0110111100001111;  add = 2'b00;  rw =1;
      #10 x     = 16'b0110111111111111;  add = 2'b01;  rw =0;
      #10 x     = 16'b0110101010101010;  add = 2'b00;  rw =0;
      #10 $finish;  
      end // initial 
 
   always   
      #5 clk = ~clk; 
 
   always @( negedge clk )   
      begin    
         $display ( "%4d  %4b  %4b  %4b %4b", $time, x, s, rw, add );   
      end // always at positive edge clocking changing 
 
endmodule // Exemplo_1201 