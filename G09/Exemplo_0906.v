/* Aluno: Henrique Augusto Rodrigues
* Matricula: 675263
* Arquitetura 1 - Tarde
* Guia_09  Exemplo 0906.
*/

//inclusoes
`include "clock.v"

/*
*modulos
*/

module pulse (signal, clock);
input clock;
output signal;
reg signal;

always @ ( posedge clock)
begin
  signal = 1'b1;
#2 signal = 1'b0;
/*
#2 signal = 1'b1;
#2 signal = 1'b0;
#2 signal = 1'b1;
#2 signal = 1'b0;
#2 signal = 1'b1;
#2 signal = 1'b0;
#2 signal = 1'b1;
#2 signal = 1'b0;
#2 signal = 1'b1;
#2 signal = 1'b0;
*/
end
endmodule

module main;

clock clk(clock);
wire p;

pulse pls (p, clock);


initial begin
$dumpfile("Exemplo_0906.vcd");
$dumpvars(1, clock, p);

#480 $finish;

end
endmodule
