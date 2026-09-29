`timescale 1ns/1ps

module control_unit(
    input [7:0] instruction,

    output [2:0] opcode,
    output [1:0] read_addr1,
    output [1:0] read_addr2,
    output reg we
);

    assign opcode     = instruction[7:5];
    assign read_addr1 = instruction[4:3];
    assign read_addr2 = instruction[2:1];

    always @(*) begin
        case (opcode)
            3'b000: we = 1'b1;    // ADD
            3'b001: we = 1'b1;    // SUB
            3'b010: we = 1'b1;    // AND
            3'b011: we = 1'b1;    // OR
            3'b100: we = 1'b1;    // XOR
            3'b101: we = 1'b1;    // NOT
            3'b110: we = 1'b1;    // INC
            3'b111: we = 1'b1;    // DEC
            default: we = 1'b0;
        endcase
    end

endmodule