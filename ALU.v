module ALU(
input [3:0] ALUcode,
input [31:0] srcA,
input [31:0] srcB,
output reg [31:0] ALUresult,
output reg branch_decision
);

/*wire srcA_abs, srcB_abs; // absolute values

assign srcA_abs = srcA[31] ? -srcA : srcA;
assign srcB_abs = srcB[31] ? -srcB : srcB;*/

always @ *
case(ALUcode)
4'b0000: begin ALUresult = srcA + srcB; branch_decision = 0; end
4'b0001: begin ALUresult = srcA - srcB;  branch_decision = 0; end
4'b0010: begin ALUresult = srcA ^ srcB;  branch_decision = 0; end
4'b0011: begin ALUresult = srcA | srcB;  branch_decision = 0; end
4'b0100: begin ALUresult = srcA & srcB;  branch_decision = 0; end
4'b0101: begin ALUresult = srcA << srcB; branch_decision = 0; end
4'b0110: begin ALUresult = srcA >> srcB; branch_decision = 0; end
4'b0111: begin ALUresult = srcA >>> srcB; branch_decision = 0; end
4'b1000: begin ALUresult = (srcA < srcB) ? {{31{1'b0}}, 1'b1} : {32{1'b0}}; branch_decision = 0; end
4'b1001: begin ALUresult = ($unsigned(srcA) < $unsigned(srcB)) ? {{31{1'b0}}, 1'b1} : {32{1'b0}}; branch_decision = 0; end // unsigned
4'b1010: begin branch_decision = (srcA == srcB) ? 1 : 0; ALUresult = 32'b0; end
4'b1011: begin branch_decision = (srcA != srcB) ? 1 : 0; ALUresult = 32'b0; end
4'b1100: begin branch_decision = (srcA < srcB) ? 1 : 0;  ALUresult = 32'b0; end
4'b1101: begin branch_decision = (srcA >= srcB) ? 1 : 0; ALUresult = 32'b0; end
4'b1110: begin branch_decision = ($unsigned(srcA) < $unsigned(srcB)) ? 1 : 0;  ALUresult = 32'b0; end // unsigned
4'b1111: begin branch_decision = ($unsigned(srcA) >= $unsigned(srcB)) ? 1 : 0; ALUresult = 32'b0; end // unsigned

default: begin ALUresult = 32'b0; branch_decision = 1'b0; end
endcase

endmodule