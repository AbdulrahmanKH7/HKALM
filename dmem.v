module dmem(
input clk, reset, we,
input [31:0] a, wd,
input wr_select,
output reg [31:0] rd
);
integer i;
reg [31:0] RAM[1023:0]; // 32 Byte
wire [19:0] local_addr;
assign local_addr = a[19:0];
//assign rd = RAM[local_addr]; //[31:2]]; // word aligned
always @(posedge clk)// or negedge reset)
//if(!reset) for (i = 0; i < 1024; i = i + 1)
//RAM[i] <= 0;
//else 
if (we & wr_select) RAM[local_addr] <= wd; // & wr_select
else rd <= RAM[local_addr];
endmodule