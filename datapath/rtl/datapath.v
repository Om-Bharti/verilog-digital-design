module datapath(
    input clk,
    input we,
    input [1:0] read_addr1,
    input [1:0] read_addr2,
    input [1:0] write_addr,
    input [2:0] opcode,
    output [3:0] alu_result
);

// Internal wires
wire [3:0] read_data1;
wire [3:0] read_data2;
wire [3:0] result;
wire carry;

// Register File
register_file RF (
    .clk(clk),
    .we(we),
    .write_addr(write_addr),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_data(result),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// ALU
alu_4bit ALU (
    .a(read_data1),
    .b(read_data2),
    .opcode(opcode),
    .result(result),
    .carry(carry)
);

// Output
assign alu_result = result;

endmodule