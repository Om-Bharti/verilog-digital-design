`timescale 1ns/1ps

module datapath(
    input clk,
    input reset,

    input [2:0] opcode,

    input [1:0] read_addr1,
    input [1:0] read_addr2,
    input [1:0] write_addr,

    input we,

    output [3:0] alu_result,

    output carry,
    output borrow,
    output overflow,
    output zero,
    output negative
);

    wire [3:0] read_data1;
    wire [3:0] read_data2;
    wire [3:0] result;

    register_file rf(
        .clk(clk),
        .reset(reset),
        .we(we),
        .write_addr(write_addr),
        .write_data(result),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    alu_4bit alu(
        .a(read_data1),
        .b(read_data2),
        .opcode(opcode),
        .result(result),
        .carry(carry),
        .borrow(borrow),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    assign alu_result = result;

endmodule