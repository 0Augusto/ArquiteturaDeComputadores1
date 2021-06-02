/* Aluno: Henrique Augusto Rodrigues
* Matricula: 675263
* Arquitetura 1 - Tarde
* Guia_09  Exemplo 0904.
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
#24 signal = 1'b0;
#24 signal = 1'b1;

end
endmodule

module main;

clock clk(clock);
wire p;

pulse pls (p, clock);


initial begin
$dumpfile("Exemplo_0904.vcd");
$dumpvars(1, clock, p);

#480 $finish;

end
endmodule
