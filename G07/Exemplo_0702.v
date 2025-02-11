/*
* Aluno: Henrique Augusto Rodrigues
* Matricula: 675263
* Arquitetura 1 - Tarde
* Guia_07  Exemplo 0702.
*/
module mux (output out_s, input in_and, in_or, select);

//wires
wire not_select;
wire out_and, out_or;

//portas
not NOT1 (not_select, select);
and AND1 (out_and, in_and, select);
and AND2 (out_or, in_or, not_select);
or OR1 (out_s, out_and, out_or);

endmodule

module Exemplo0702;

//definicoes

reg a, b, select;
wire and_out, or_out, mux_s;

and AND1 (and_out, a, b);
or OR1 (or_out, a, b);

mux MUX1(mux_s, and_out, or_out, select);

initial
begin: main
$display("Exemplo_0702");
$display("675263 - Henrique Augusto Rodrigues");
$display(" a  b  select mux_s");

a=1'b0; b=1'b0; select=1'b0;

//monitor
#1 $monitor(" %b  %b     %b     %b", a, b, select, mux_s);

#1 a=1'b0; b=1'b1; select=1'b0;
#1 a=1'b1; b=1'b0; select=1'b0;
#1 a=1'b1; b=1'b1; select=1'b0;
#1 a=1'b0; b=1'b0; select=1'b1;
#1 a=1'b0; b=1'b1; select=1'b1;
#1 a=1'b1; b=1'b0; select=1'b1;
#1 a=1'b1; b=1'b1; select=1'b1;

end
endmodule
