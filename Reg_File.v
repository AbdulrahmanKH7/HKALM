// three ported register file
// read two ports combinationally (A1/RS1, A2/RS2)
// write third port on rising edge of clock (A3/rd/WE)
// register 0 hardwired to 0
module Reg_File(
input clk,
input rst_n,
input WE, // write enable for destination reg
input [4:0] a1, a2, a3, // addresses, a3 is rd address
input [31:0] rd,
output [31:0] rs1, rs2
);
reg signed [31:0] rf[31:0]; // a set of 32x32 registers
integer i;

always @(posedge clk or negedge rst_n)
if(!rst_n)
for (i = 0; i < 32; i = i + 1)
rf[i] <= 0;
else if (WE && (a3 != 0)) rf[a3] <= rd;

 // this logic create the zero reg and handle data hazard
assign rs1 = (a1 == 0) ? 0 : ((a1 == a3) && WE) ? rd : rf[a1]; 
assign rs2 = (a2 == 0) ? 0 : ((a2 == a3) && WE) ? rd : rf[a2];
endmodule