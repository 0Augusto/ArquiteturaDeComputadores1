/*
Arquitetura de Computadores I - Pucminas
Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 13
Exemplo 1306
*/

//D Flip Flop
module D (output q, output qnot,
           input d,
           input clk, input clear, input preset);

reg q, qnot;

always @ ( posedge clk or clear or preset )
begin
    if (clear) begin q<=0; qnot<=1; end
    else
      if (preset) begin q<=1; qnot<=0; end
      else
        begin q<=d; qnot<=~d; end
end
endmodule

//JK Flip Flop
module JK (output q, output qnot,
           input j, input k,
           input clk, input clear, input preset);

reg q, qnot;

always @ (posedge clk or clear or preset)
begin
    if (clear) begin q<=0; qnot<=1; end
    else
      if (preset) begin q<=1; qnot<=0; end
      else
      if (j&~k) begin q<=1; qnot<=0; end
      else
        if (~j&k) begin q<=0; qnot<=1; end
        else
        if (j&k) begin q<=~q; qnot<=~qnot; end
end
endmodule

module Ring (output a, b, c, d, e,
                input clk, clear, preset);
wire gnd;

JK ffa(a, gnd, e, ~e, clk, preset, clear);
JK ffb(b, gnd, a, ~a, clk, clear, preset);
JK ffc(c, gnd, b, ~b, clk, clear, preset);
JK ffd(d, gnd, c, ~c, clk, clear, preset);
JK ffe(e, gnd, d, ~d, clk, clear, preset);

endmodule

module main;

//definicoes
reg clk, clear, preset;
reg in;
wire[4:0] out;

Ring Exemplo6 (out[4], out[3], out[2], out[1], out[0], clk, clear, preset);

initial
begin
$display(" a b c d e");
    //initial values
    clk    = 1;
    clear  = 1;
    preset = 0;

    //input signal changing
    #4 clear = 0;

    #20 $finish;
end//initial begin

always
#2 clk=~clk;

always @ (negedge clk)
begin
    $display(" %b %b %b %b %b", out[4], out[3], out[2], out[1], out[0]);
end
endmodule
