module imem(
input [31:0] a,
output [31:0] rd
);
reg [31:0] ROM[1610:0];
initial
$readmemh("myprogram.hex",ROM);
assign rd = ROM[a[31:2]]; // word aligned
endmodule