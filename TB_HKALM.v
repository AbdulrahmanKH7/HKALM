//`timescale 1ns/1ps
module testbench();
reg clk;
reg reset;
wire [31:0] WriteData, DataAdr;
wire MemWrite;
//wire gpio_pin;
// instantiate device to be tested
top dut(clk, reset, WriteData, DataAdr, MemWrite); //, gpio_pin);
// initialize test
initial
begin
reset <= 0; # 22; reset <= 1;
end
// generate clock to sequence tests
always
begin
clk <= 1; # 5; clk <= 0; # 5;
end

// check results
always @(negedge clk)
begin
if(MemWrite) begin
if(DataAdr == 100 & WriteData == 25) begin
$display("Simulation succeeded");
$stop;
end else if (DataAdr != 96) begin
$display("Simulation failed");
$stop;
end
end
end

endmodule