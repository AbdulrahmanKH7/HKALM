module GPIO(
  input wire clk,
  input wire rst_n,
  input wr_en, // write -to GPIO- enable
  input wire [31:0] addr,
  input wire [31:0] wr_data,
  //input wire [7:0] gpio_in,
 
  output wire [31:0] rd_data,
  inout wire [7:0] gpio_pin
  
  
  );
  
  
  localparam [7:0] gpio_data_addr = 8'h00;
  localparam [7:0] gpio_dir_addr = 8'h04;
  
  reg [7:0] gpio_dataout = 0;
  reg [7:0] gpio_datain = 0;
  reg gpio_dir = 0; // 1 -> output
  
  wire [7:0] local_addr = addr[7:0];
  
    // Update in/out direction/mode
  always @(posedge clk, negedge rst_n)
  begin
    if(!rst_n)
      gpio_dir <= 0;
    
    else if ((local_addr == gpio_dir_addr) & wr_en)
      gpio_dir <= wr_data[0];
  end

//assign gpio_dir = ((local_addr == gpio_dir_addr) & wr_en) ? wr_data[0] : gpio_dir;
  
    // Update output value
  always @(posedge clk, negedge rst_n)
  begin
    if(!rst_n)
    begin
      gpio_dataout <= 8'h00;
    end
    else if ((local_addr == gpio_data_addr) & wr_en)// & (gpio_dir == 1'b1)
      gpio_dataout <= wr_data[7:0];
  end
  
   //Update input value
  always @(posedge clk, negedge rst_n)
  begin
    if(!rst_n)
    begin
      gpio_datain <= 8'h00;
    end
    else if (gpio_dir == 0)
      gpio_datain <= gpio_pin;
//    else if (gpio_dir == 1)
//      gpio_datain <= gpio_out;
  end
    
 // assign gpio_datain = gpio_pin; //(gpio_dir == 1'b0) ? gpio_pin : 'bz;     
  assign rd_data[7:0] = (gpio_dir == 1'b0) ? gpio_pin : 0; //gpio_datain;  
  assign gpio_pin = (gpio_dir == 1'b1) ? gpio_dataout : 'bz; //gpio_pin;
  
  endmodule