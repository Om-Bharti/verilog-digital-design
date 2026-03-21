module register_file(
    input clk,
    input we,
    input [1:0] write_addr,
    input [1:0] read_addr1,
    input [1:0] read_addr2,
    input [3:0] write_data,
    output [3:0] read_data1,
    output [3:0] read_data2
);

reg [3:0] regfile [3:0]; // 4 registers of 4 bits

// Write operation
always @(posedge clk) begin
    if (we)
        regfile[write_addr] <= write_data;
end

// Read operation
assign read_data1 = regfile[read_addr1];
assign read_data2 = regfile[read_addr2];

endmodule