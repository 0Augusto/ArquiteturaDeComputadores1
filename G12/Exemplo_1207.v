/*
Nome: Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 12
Exemplo_1203.v
*/

module jkff ( output q, output qnot, input j, input k, input clk, input preset, input clear, input rw, input add ); 
  reg    q, qnot; 

   always @( posedge clk & rw & add or preset or clear ) 
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

module MUX8(output[15:0] s0, input[15:0] s1,s2,input add);
    wire sa, so, notseletor, sa1, sa2;
    wire[15:0] s0;
    
    
    MUX MUX0( s0[0], s1[0], s2[0], add);
    MUX MUX1( s0[1], s1[1], s2[1], add);
    MUX MUX2( s0[2], s1[2], s2[2], add);
    MUX MUX3( s0[3], s1[3], s2[3], add);
    MUX MUX4( s0[4], s1[4], s2[4], add);
    MUX MUX5( s0[5], s1[5], s2[5], add);
    MUX MUX6( s0[6], s1[6], s2[6], add);
    MUX MUX7( s0[7], s1[7], s2[7], add);
    MUX MUX8( s0[8], s1[8], s2[8], add);
    MUX MUX9( s0[9], s1[9], s2[9], add);
    MUX MUX10( s0[10], s1[10], s2[10], add);
    MUX MUX11( s0[11], s1[11], s2[11], add);
    MUX MUX12( s0[12], s1[12], s2[12], add);
    MUX MUX13( s0[13], s1[13], s2[13], add);
    MUX MUX14( s0[14], s1[14], s2[14], add);
    MUX MUX15( s0[15], s1[15], s2[15], add);
    
endmodule
endmodule
module DEMUX( output a, output b, output c, output d, input [1:0] chave );
	reg a, b, c, d;
	always
	begin
		#1
		case ( chave )
			2'b00 : begin a = 1'b1; b = 1'b0; c = 1'b0; d = 1'b0; end
			2'b01 : begin a = 1'b0; b = 1'b1; c = 1'b0; d = 1'b0; end
			2'b10 : begin a = 1'b0; b = 1'b0; c = 1'b1; d = 1'b0; end
			2'b11 : begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b1; end
			default : begin a = 1'b0; b = 1'b0; c = 1'b0; d = 1'b0; end
		endcase
	end
endmodule //demux



module memoria ( output s, input add, input clk, input rw, input clear, input i ); 
    wire q, qnot;
    
    jkff JK1(q, qnot, i, ~i, clk, 1'b0, clear, rw,add);
    and AND1 ( s, add, q );
endmodule // jkff 

module memoria4( output [15:0] s, input add, input clk, input rw, input clear, input [15:0] i ); 
    
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

module endereco( output[15:0] s, input[1:0] add, input clk, input rw, input clear, input[15:0] i ); 
    wire q, qnot, add1, add2, add3, add4;
    wire[15:0] s1, s2, s3, s4, sa, sb,s;
    DEMUX dmx1(add1, add2, add3, add4, 1'b1, add);
    
    memoria4 M41(s1, add1, clk, rw, reset, i);
    memoria4 M42(s2, add2, clk, rw, reset, i);
    memoria4 M43(s3, add3, clk, rw, reset, i);
    memoria4 M44(s4, add4, clk, rw, reset, i);
    
    MUX8 MUX0( sa, s1, s2, add[0]);
    MUX8 MUX1( sb, s3, s4, add[0]);
    MUX8 MUX2( s, sa, sb, add[1]);

    
endmodule // jkff 

module exemplo1101;  
    reg   clk, reset, rw;
    reg[1:0] add;
   reg[15:0] x;  
   wire[15:0]  s;
   
   endereco E1(s, add, clk, rw, reset, x);
 
   initial   
      begin    
      $display ( "Memoria 1X4 FFJK" ); 
      $display ( "Exemplo_1207"     );
      $display ("Henrique Augusto Rodrigues - 675263");
      $display ( "time         in              out            rw    addr" );
 
   // initial values        
      clk   = 1;        
      reset = 1;       
      x     = 0; 
   // input signal changing   
       reset = 0;   
      #10 x     = 16'b0101111111111111;  add = 1;  rw =1; 
      #10 x     = 16'b0111000000000000;  add = 1;  rw =1;
      #10 x     = 16'b0110000000000001;  add = 1;  rw =0;
      #10 x     = 16'b0110110011001100;  add = 1;  rw =0;
      #10 x     = 16'b0110111100001111;  add = 0;  rw =1;
      #10 x     = 16'b0110111111111111;  add = 1;  rw =0;
      #10 x     = 16'b0110101010101010;  add = 0;  rw =0;
      #10 $finish;  
      end // initial 
 
   always   
      #5 clk = ~clk; 
 
   always @( negedge clk )   
      begin    
         $display ( "%4d  %4b  %4b  %4b %4b", $time, x, s, rw, add );   
      end // always at positive edge clocking changing 
 
 
 
endmodule // Exemplo_1201 