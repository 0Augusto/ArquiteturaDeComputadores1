/* Aluno: Henrique Augusto Rodrigues
* Matricula: 675263
* Arquitetura 1 - Tarde
* Guia_09  Exemplo 0901.
*/

/*
* Clock Generator
*/
module clock (output clk);
reg clk;

initial
  begin
    clk = 1'b0;
  end

always
  begin
    #12 clk = ~clk;
end
endmodule

module main;

wire clk;
clock CLK1 (clk);

initial begin
$dumpfile("Exemplo_0901.vcd");
$dumpvars;

#120 $finish;
end
endmodule
