module PC_Block(
input clk, rst_n,
input PC_adder_srcA, PC_adder_srcB,
input [31:0] ImmExt, ALUResult, rs1,
input PCSrc,

output reg [31:0] PC,
output [31:0] PCPlus4, PCTarget,
input [31:0] PC_delayed,
input PCstall
);

wire [31:0] PCNext;
wire [31:0] PC_op1, PC_op2;

// THIS IS HOW TO DELAY AND STRETCH A PULSE SIGNAL
//always @ (posedge clk) begin
//stallPC_delayed <= stallPC; // delay
//stallPC_extend <= stallPC_delayed;
//stallPC_stretched <= stallPC_delayed | stallPC_extend; // stretch
//end


// next PC logic

always @(posedge clk, negedge rst_n)
if (!rst_n) PC <= 32'h00000014; 
//else PC <= PCNext; // we need to stall when we load from dmem becuase that cause 1 cycle latency
else if(!PCstall) PC <= PCNext; // we need to stall when we load from dmem becuase that cause 1 cycle latency 

assign PCPlus4 = PC + 32'd4;

assign PC_op1 = (PC_adder_srcA == 1'b0) ? ImmExt : ALUResult;
assign PC_op2 = (PC_adder_srcB == 1'b0) ? PC_delayed : rs1;

assign PCTarget = PC_op1 + PC_op2; // for branching

assign PCNext = (PCSrc == 1'b0) ? PCPlus4 : PCTarget;

endmodule