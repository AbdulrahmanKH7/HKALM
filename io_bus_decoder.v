module io_bus_decoder ( 
  input clk,   
  input [31:0] address,  
  output reg [7:0] wr_select,
  output reg [1:0] mux_select,
  input stall_busDecoder 
 );
 
 reg stall_busDecoder_delayed;
 
 always@(posedge clk)
 stall_busDecoder_delayed <= stall_busDecoder;
 
  always @*
  if(!stall_busDecoder_delayed)  
    case (address[31:20]) 
       12'h800 : begin wr_select = 8'b00000010; mux_select = 2'b01; end  // DMEM
       12'hFFF : case (address[19:8])
           12'hFFE : begin wr_select = 8'b00000001; mux_select = 2'b00; end  // GPIO
           12'hFFD : begin wr_select = 8'b00000100; mux_select = 2'b10; end  // UART
 
           default : begin wr_select = 8'b10000000;  mux_select = 2'b11; end 
                endcase 
      default : begin wr_select = 8'b10000000;  mux_select = 2'b11; end  // 11
    endcase  
    
endmodule