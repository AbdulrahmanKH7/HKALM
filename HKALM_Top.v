module HKALM_Top(
input clk, reset,
output [31:0] PC,
input [31:0] Instr,
output MemWrite,
output [31:0] ALUResult, WriteData, 
input [31:0] ReadData,
output dmem_read_E
);

wire ALUSrcA, ALUSrcB, RegWrite, branch_decision, PC_adder_srcA, PC_adder_srcB, Branch, Jump, MemWrite_in;
wire [1:0] ResultSrc;
wire [2:0] ImmSrc;
wire [3:0] ALUControl;
wire [31:0] Instr_delayed;
wire dmem_read;

Control_Unit Control_Unit(Instr_delayed[6:0], Instr_delayed[14:12], Instr_delayed[30], branch_decision, ResultSrc, MemWrite_in, Branch, Jump,
                          ALUSrcA, ALUSrcB, RegWrite, ImmSrc, ALUControl, PC_adder_srcA, PC_adder_srcB, dmem_read);
                          
Datapath Datapath(clk, reset, ResultSrc, Branch, Jump, ALUSrcA, ALUSrcB, RegWrite, ImmSrc, ALUControl, PC_adder_srcA, PC_adder_srcB,
                  branch_decision, PC, Instr, ALUResult, WriteData, ReadData, MemWrite_in, MemWrite, Instr_delayed, dmem_read, dmem_read_E);
endmodule