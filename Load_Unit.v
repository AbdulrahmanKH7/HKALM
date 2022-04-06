module Load_Unit(
input [6:0] op,
input [2:0] func3,
input [31:0] data_in_ld, // ld = port rd, st = port rs2
output reg [31:0] data_out_ld
);

wire [1:0] mode; // 0 = others, 1 = load, 2 = store

assign mode = (op == 7'b0100011) ? 2'b10 : 
              (op == 7'b0000011) ? 2'b01 : 2'b00;
always @ *
if(mode == 2'b00) begin
data_out_ld = data_in_ld;
end
else if (mode == 2'b01) // load
begin
case(func3)
3'b000: begin data_out_ld = {{24{data_in_ld[7]}}, data_in_ld[7:0]};  end
3'b001: begin data_out_ld = {{16{data_in_ld[15]}}, data_in_ld[15:0]};  end
3'b010: begin data_out_ld = data_in_ld;  end
3'b100: begin data_out_ld = {24'b0, $unsigned(data_in_ld[7:0])};  end
3'b101: begin data_out_ld = {16'b0, $unsigned(data_in_ld[15:0])};  end
default: begin data_out_ld = data_in_ld; end
endcase
end 


else if(mode == 2'b10) begin // store
data_out_ld = data_in_ld;
end 

else begin
data_out_ld = data_in_ld;
end      


endmodule