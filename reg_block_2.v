module reg_block_2(
input clk,
input reset_n,
input flush, // clear

input [31:0] PCPlus4_D, 
output reg [31:0] PCPlus4,

input [1:0] ResultSrc_in,
input MemWrite_in,
input Branch_in, Jump_in, ALUSrcA_in, ALUSrcB_in,
input RegWrite_in,
input [3:0] ALUControl_in,
input PC_adder_srcA_in, PC_adder_srcB_in,
input [31:0] rs1_in, rs2_in,
output reg [1:0] ResultSrc_out,
output reg MemWrite_out,
output reg Branch, Jump, ALUSrcA_out, ALUSrcB_out,
output reg RegWrite_out,
output reg [3:0] ALUControl_out,
output reg PC_adder_srcA_out, PC_adder_srcB_out,
output reg [31:0] rs1_out, rs2_out,

input [4:0] rd_addr_in,
output reg [4:0] rd_addr,

input [31:0] ImmExt_in,
output reg [31:0] ImmExt,

input [31:0] PC_D,
output reg [31:0] PC_delayed,

input [31:0] Instr_D,
output reg [31:0] Instr_E,

input dmem_read,
output reg dmem_read_E
);

// asynchronous reset
always @ (posedge clk, negedge reset_n)
if (!reset_n) begin
ResultSrc_out <= 2'b0;
MemWrite_out <= 1'b0;
Branch <= 1'b0;
Jump <= 1'b0;
ALUSrcA_out <= 1'b0;
ALUSrcB_out <= 1'b0;
RegWrite_out <= 1'b0;
ALUControl_out <= 4'b0;
PC_adder_srcA_out <= 1'b0;
PC_adder_srcB_out <= 1'b0;
rs1_out <= 32'b0;
rs2_out <= 32'b0;
PCPlus4 <= 32'b0;
ImmExt <= 32'b0;
rd_addr <= 5'b0;
PC_delayed <= 32'b0;
Instr_E <= 32'b0;
dmem_read_E <= 1'b0;
end 
else if (flush) // | dmem_read_E)
begin
ResultSrc_out <= 2'b0;
MemWrite_out <= 1'b0;
Branch <= 1'b0;
Jump <= 1'b0;
ALUSrcA_out <= 1'b0;
ALUSrcB_out <= 1'b0;
RegWrite_out <= 1'b0;
ALUControl_out <= 4'b0;
PC_adder_srcA_out <= 1'b0;
PC_adder_srcB_out <= 1'b0;
rs1_out <= 32'b0;
rs2_out <= 32'b0;
PCPlus4 <= 32'b0;
ImmExt <= 32'b0;
rd_addr <= 5'b0;
PC_delayed <= 32'b0;
Instr_E <= 32'b0;
dmem_read_E <= 1'b0;
end
else
begin
MemWrite_out <= MemWrite_in;
Branch <= Branch_in;
Jump <= Jump_in;
ALUSrcA_out <= ALUSrcA_in;
ALUSrcB_out <= ALUSrcB_in;
ALUControl_out <= ALUControl_in;
PC_adder_srcA_out <= PC_adder_srcA_in;
PC_adder_srcB_out <= PC_adder_srcB_in;
rs1_out <= rs1_in;
rs2_out <= rs2_in;
PCPlus4 <= PCPlus4_D;
ImmExt <= ImmExt_in;
PC_delayed <= PC_D;
Instr_E <= Instr_D;
dmem_read_E <= dmem_read;
if(!dmem_read_E)
    begin
rd_addr <= rd_addr_in;
ResultSrc_out <= ResultSrc_in;
RegWrite_out <= RegWrite_in;
    end
end

endmodule