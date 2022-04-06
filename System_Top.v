module top(
input clk, reset,
//output [31:0] WriteData, DataAdr, // RETURN THIS WHEN SIMULATING 
//output MemWrite, // RETURN THIS WHEN SIMULATING 
inout [7:0] gpio_pin, // REMOVE THIS WHEN SIMULATING
input uart_rx,
output uart_tx 
);

// for book sim, remove "& wr_select" in dmem and make the dmem address 0 at the iodecoder and PC at reset = 0

wire rst_n = reset; //~reset; // invert for cmod s7

wire [31:0] WriteData, DataAdr; // REMOVE THIS WHEN SIMULATING 
wire MemWrite; // REMOVE THIS WHEN SIMULATING 
//wire [7:0] gpio_pin; // RETURN THIS WHEN SIMULATING 

wire [31:0] PC, Instr, ReadData;

wire [31:0] dmem_sel;

wire dmem_read_E;

// instantiate processor and memories
HKALM_Top HKALM_Top(clk, rst_n, PC, Instr, MemWrite, DataAdr, WriteData, ReadData, dmem_read_E);
imem imem(PC, Instr);
dmem dmem(clk, rst_n, MemWrite, DataAdr, WriteData, wr_select[1], dmem_sel);

wire [1:0] mux_select;
wire [31:0] gpio_sel;
wire [31:0] uart_sel;


MUX io_bus_mux(mux_select, gpio_sel, dmem_sel, uart_sel, 32'h00000000, ReadData);

wire [7:0] wr_select;

io_bus_decoder io_bus_decoder(clk, DataAdr, wr_select, mux_select, dmem_read_E);  

GPIO GPIO (clk, rst_n, wr_select[0], DataAdr, WriteData, gpio_sel, gpio_pin);

UART UART (clk, rst_n, wr_select[2], DataAdr, WriteData, uart_sel, uart_rx, uart_tx);

endmodule