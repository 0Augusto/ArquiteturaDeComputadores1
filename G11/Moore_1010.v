/*
Nome: Henrique Augusto Rodrigues
Matricula: 675263
Turno: Tarde
Guia 11
Moore_1010.v
*/

// Moore FSM

//constant definitions
`define found 1
`define notfound 0

//FSM
module moore_1010 (y, x, clk, reset);
output y;
input x;
input clk;
input reset;

reg y;

parameter    //state identifiers
start = 3'b000,
id1   = 3'b001,
id10  = 3'b010,
id101 = 3'b011,
id1010= 3'b110; //signal found

reg[2:0] E1;//current state variables
reg[2:0] E2;//next state logic output

//next state logic
always @(x or E1)
begin
  case (E1)
  start:
    if (x)
      E2 = id1;
      else
      E2 = start;
  id1:
    if (x)
      E2 = id1;
    else
      E2 = id10;
  id10:
    if(x)
      E2 = id101;
    else
      E2 = start;
  id101:
    if (x)
      E2 = id1;
    else
      E2 = id1010;
  id1010:
    if (x)
      E2 = id101;
    else
      E2 = id1;
  default: //undefined state
    E2 = 3'bxxx;
  endcase
end //always at signal or state changing

//state variables
always @ ( posedge clk or negedge reset )
  begin
  if (reset)
    E1=E2; //updates current state
  else
    E1=0; //reset
  end //always at signal changing

//output logic
always @ (E1)
  begin
  y=E1[2]; //first bit of state value (MOORE indicator)
end //always at state changing
endmodule //Moore_1101
