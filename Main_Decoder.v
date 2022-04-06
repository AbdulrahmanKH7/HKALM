module Main_Decoder(
input [6:0] op,
output [1:0] ResultSrc,
output MemWrite,
output Branch, ALUSrcA, ALUSrcB,
output RegWrite, Jump,
output [2:0] ImmSrc,
output [1:0] ALUOp,
output PC_adder_srcA, 
output PC_adder_srcB,
output dmem_read
);
reg [15:0] controls;
assign {RegWrite, ImmSrc, ALUSrcA, ALUSrcB, MemWrite, ResultSrc, Branch, ALUOp, Jump, PC_adder_srcA, PC_adder_srcB, dmem_read} = controls;
always @ *
case(op)
// RegWrite_ImmSrc_ALUSrcA_ALUSrcB_MemWrite_ResultSrc_Branch_ALUOp_Jump_PCaddersrcA_PCaddersrcB_dmemRead
7'b0000011: controls = 16'b1_000_0_1_0_01_0_00_0_0_0_1; // load
7'b0100011: controls = 16'b0_001_0_1_1_00_0_00_0_0_0_0; // store
7'b0110011: controls = 16'b1_000_0_0_0_00_0_10_0_0_0_0; // R-type
7'b1100011: controls = 16'b0_010_0_0_0_00_1_11_0_0_0_0; // B-type (ALUOP MODIFIED)
7'b0010011: controls = 16'b1_000_0_1_0_00_0_10_0_0_0_0; // I-type ALU
7'b1101111: controls = 16'b1_011_0_0_0_10_0_00_1_0_0_0; // jal
7'b1100111: controls = 16'b1_000_0_0_0_10_0_00_1_0_1_0; // jalr
7'b0110111: controls = 16'b1_100_1_1_0_00_0_00_0_0_0_0; // lui: load upper immediate
7'b0010111: controls = 16'b1_100_0_0_0_11_0_00_0_0_0_0; // auipc
default: controls = 16'b0; // ???
endcase
endmodule