module Datapath(
input clk, rst_n,
input [1:0] ResultSrc_in,
input Branch_in, Jump_in, ALUSrcA_in, ALUSrcB_in,
input RegWrite_in,
input [2:0] ImmSrc_in,
input [3:0] ALUControl_in,
input PC_adder_srcA_in, PC_adder_srcB_in,
output branch_decision,
output [31:0] PC, 
input [31:0] Instr_in,
output [31:0] ALUResult, data_out_st, //WriteData
input [31:0] ReadData,
input MemWrite_in, 
output MemWrite,
output [31:0] Instr,
input dmem_read,
output dmem_read_E
);
wire [31:0] PCPlus4, PCPlus4_F, PCTarget_F, PCPlus4_D;
wire [31:0] ImmExt;
wire [31:0] SrcA, SrcB;
reg  [31:0] Result;
wire [31:0] rs1, rs2, rd;
wire [31:0] PC_op1, PC_op2;
wire [31:0] data_out_ld;

wire [31:0] ImmExt_in;
wire [31:0] Instr_E;
wire [4:0] rd_addr;

wire PC_adder_srcA, PC_adder_srcB;
wire PCSrc;
wire RegWrite;
wire ALUSrcB;
wire ALUSrcA;
//wire dmem_read_E;
wire [31:0] rs1_in;
wire [31:0] rs2_in;
wire [31:0] PC_E;
wire [31:0] PC_D; // at decode stage
wire [3:0] ALUControl;
wire [1:0] ResultSrc;

assign SrcA = (ALUSrcA == 1'b0)? rs1 : 0;
assign SrcB = (ALUSrcB == 1'b0)? rs2 : ImmExt;

always @ * 
case(ResultSrc)
2'b00: Result = ALUResult;
2'b01: Result = ReadData;
2'b10: Result = PCPlus4;
2'b11: Result = PCTarget_F; // should be _E
endcase

assign PCSrc = (Branch & branch_decision) | Jump;
assign stallPC = PCSrc;

PC_Block PC_Block(clk, rst_n, PC_adder_srcA, PC_adder_srcB, ImmExt, ALUResult, rs1, PCSrc, PC, PCPlus4_F, PCTarget_F, PC_E, dmem_read_E);

// register file logic
Reg_File Reg_File(clk, rst_n, RegWrite, Instr[19:15], Instr[24:20],
                 rd_addr, data_out_ld, rs1_in, rs2_in);
                 
Extend_Unit Extend_Unit(Instr[31:7], ImmSrc_in, ImmExt_in);

// ALU logic
ALU ALU(ALUControl, SrcA, SrcB, ALUResult, branch_decision);

Load_Unit Load_Unit(Instr_in[6:0], Instr_in[14:12], Result, data_out_ld); //at stage 2 (decode)

Store_Unit Store_Unit(Instr_E[6:0], Instr_E[14:12], rs2, data_out_st); // at stage 3 (execute)

reg_block_1 reg_block_1(clk, rst_n, PCSrc, Instr_in, Instr, PCPlus4_F, PCPlus4_D, PC, PC_D, dmem_read_E); 

reg_block_2 reg_block_2(clk, rst_n, PCSrc, PCPlus4_D, PCPlus4, ResultSrc_in, MemWrite_in, Branch_in, Jump_in, ALUSrcA_in, ALUSrcB_in, RegWrite_in, ALUControl_in,
PC_adder_srcA_in, PC_adder_srcB_in, rs1_in, rs2_in, ResultSrc, MemWrite, Branch, Jump, ALUSrcA, ALUSrcB, RegWrite, ALUControl,
PC_adder_srcA, PC_adder_srcB, rs1, rs2, Instr[11:7], rd_addr, ImmExt_in, ImmExt, PC_D, PC_E, Instr, Instr_E, dmem_read, dmem_read_E); 

endmodule