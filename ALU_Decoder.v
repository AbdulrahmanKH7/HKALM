module ALU_Decoder(
input  opb5,
input  [2:0] funct3,
input  funct7b5,
input  [1:0] ALUOp,
output reg [3:0] ALUControl
);
wire RtypeSub;
assign RtypeSub = funct7b5 & opb5; // TRUE for R-type subtract
always @ *
case(ALUOp)
2'b00: ALUControl = 4'b0000; // addition for load/store
2'b01: ALUControl = 4'b0001; // subtraction for load/store
2'b10: case(funct3) // R-type or I-type ALU
	3'b000: if (RtypeSub)
	ALUControl = 4'b0001; // sub
	else
	ALUControl = 4'b0000; // add, addi

	3'b100: ALUControl = 4'b0010; // xor, xori
	3'b110: ALUControl = 4'b0011; // or, ori
	3'b111: ALUControl = 4'b0100; // and, andi
	3'b001: ALUControl = 4'b0101; // sll, slli
	3'b101: if(funct7b5) ALUControl = 4'b0111; // sra, srai
			else ALUControl = 4'b0110; // srl, srli
	3'b010: ALUControl = 4'b1000; // slt, slti
	3'b011: ALUControl = 4'b1001; // sltU, sltiU

	default: ALUControl = 4'b0000; // ???
	endcase
2'b11: case(funct3) //what type of branch?
    3'b000: ALUControl = 4'b1010; // beq
    3'b001: ALUControl = 4'b1011; // bne
    3'b100: ALUControl = 4'b1100; // blt
    3'b101: ALUControl = 4'b1101; // bge
    3'b110: ALUControl = 4'b1110; // blt(U)
    3'b111: ALUControl = 4'b1111; // bge (U)
    default: ALUControl = 4'b0000; // ???
    endcase
default: ALUControl = 4'b0000; // ???
endcase
endmodule