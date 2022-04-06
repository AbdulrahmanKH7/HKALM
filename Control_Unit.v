module Control_Unit(
input [6:0] op,
input [2:0] funct3,
input funct7b5,
input branch_decision,
output [1:0] ResultSrc,
output MemWrite,
output Branch, Jump, ALUSrcA, ALUSrcB,
output RegWrite, //Jump,
output [2:0] ImmSrc,
output [3:0] ALUControl,
output PC_adder_srcA, PC_adder_srcB,
output dmem_read
);
wire [1:0] ALUOp;
//wire Branch, Jump;

Main_Decoder Main_Decoder(op, ResultSrc, MemWrite, Branch, ALUSrcA, 
                          ALUSrcB, RegWrite, Jump, ImmSrc, ALUOp, PC_adder_srcA, PC_adder_srcB, dmem_read);
                          
ALU_Decoder ALU_Decoder(op[5], funct3, funct7b5, ALUOp, ALUControl);

//assign PCSrc = (Branch & branch_decision) | Jump;

endmodule