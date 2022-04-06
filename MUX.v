module MUX(
input [1:0] select,
input [31:0] in1, in2, in3, in4,
output reg [31:0] mux_output
    );
    
    
 always @ *
 
 case (select)   
    
  2'b00: mux_output = in1;   
  2'b01: mux_output = in2;  
  2'b10: mux_output = in3;  
  2'b11: mux_output = in4;  
  
  endcase  
    
    
endmodule
