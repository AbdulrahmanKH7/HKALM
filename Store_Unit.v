module Store_Unit(
input [6:0] op,
input [2:0] func3,
input [31:0] data_in_st, // ld = port rd, st = port rs2
output reg [31:0] data_out_st
);

wire [1:0] mode; // 0 = others, 1 = load, 2 = store

assign mode = (op == 7'b0100011) ? 2'b10 : 
              (op == 7'b0000011) ? 2'b01 : 2'b00;
always @ *
if(mode == 2'b00) begin
data_out_st = data_in_st;
end
else if (mode == 2'b01) // load
begin
data_out_st = data_in_st;
end 


else if(mode == 2'b10) begin // store
case(func3)
3'b000: begin data_out_st = {{24{data_in_st[7]}}, data_in_st[7:0]};  end
3'b001: begin data_out_st = {{16{data_in_st[15]}}, data_in_st[15:0]};  end
3'b010: begin data_out_st = data_in_st;  end
default: begin data_out_st = data_in_st; end
endcase
end 

else begin
data_out_st = data_in_st;
end      


endmodule