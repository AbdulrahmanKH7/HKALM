module reg_block_1(
input clk,
input reset_n,
input flush, // clear
input [31:0] instr_in,
output reg [31:0] instr_out,
input [31:0] PCPlus4_F,
output reg [31:0] PCPlus4_D,

input [31:0] PC,
output reg [31:0] PC_D,

input regStall
);
// asynchronous reset
always @ (posedge clk, negedge reset_n)
if (!reset_n) begin
instr_out <= 32'b0;
PCPlus4_D <= 32'b0;
PC_D <= 32'b0;
end
else if (flush) 
begin
instr_out <= 32'b0;
PCPlus4_D <= 32'b0;
PC_D <= 32'b0;
end
else if(!regStall) // we need to stall when we load from dmem becuase that cause 1 cycle latency 
begin
instr_out <= instr_in;
PCPlus4_D <= PCPlus4_F;
PC_D <= PC;
end

endmodule