`timescale 1ns/1ps

module cpu(
    input clk,
    input reset,

    output [3:0] pc,
    output [7:0] instruction,

    output [2:0] opcode,
    output [1:0] read_addr1,
    output [1:0] read_addr2,

    output we,

    output [3:0] alu_result,

    output carry,
    output borrow,
    output overflow,
    output zero,
    output negative
);

    program_counter pc_inst(
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    instruction_memory imem_inst(
        .address(pc),
        .instruction(instruction)
    );

    control_unit cu_inst(
        .instruction(instruction),
        .opcode(opcode),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .we(we)
    );

    datapath dp_inst(
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(read_addr1),
        .we(we),
        .alu_result(alu_result),
        .carry(carry),
        .borrow(borrow),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

endmodule