/*
Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 14
Exemplo_1405
*/

//D Flip Flop
module D (output q, output qnot,
           input d,
           input clk, input clear);

reg q, qnot;

always @ ( posedge clk or clear )
begin
    if (clear)
    begin q<=0; qnot<=1; end
    else
    begin q<=d; qnot<=~d; end
end
endmodule

module ParaleloSerie (output a, b, c, d, e,
                    input a_in, b_in, c_in, d_in, e_in,
                    input clk, clear);
wire a_out, b_out, c_out, d_out, gnd;
wire da_in, db_in, dc_in, dd_in, de_in;

assign da_in = a_in|0;
assign db_in = b_in|a_out;
assign dc_in = c_in|b_out;
assign dd_in = d_in|c_out;
assign de_in = e_in|d_out;

D da(a_out, gnd, da_in, clk, clear);
D db(b_out, gnd, db_in, clk, clear);
D dc(c_out, gnd, dc_in, clk, clear);
D dd(d_out, gnd, dd_in, clk, clear);
D de(e, gnd, de_in, clk, clear);

assign a = a_out;
assign b = b_out;
assign c = c_out;
assign d = d_out;

endmodule

module main;

//definicoes
reg clk, clear;
reg ain, bin, cin, din, ein;
wire a, b, c, d, e;

ParaleloSerie Exemplo5 (a, b, c, d, e,
                      ain, bin, cin, din, ein,
                      clk, clear);

initial
begin
$display(" a b c d e");
    //initial values
    clk    = 1;
    ain   = 0;
    bin   = 0;
    cin   = 0;
    din   = 0;
    ein   = 0;
    clear  = 1;

    //input signal changing
    #4 clear = 0; ain = 1; cin = 1;
    #8 ain = 0; cin = 0;

    #20 $finish;
end//initial begin

always
#2 clk=~clk;

always @ (negedge clk)
begin
    $display(" %b %b %b %b %b", a, b, c, d, e);
end
endmodule
