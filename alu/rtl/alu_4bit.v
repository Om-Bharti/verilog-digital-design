`timescale 1ns/1ps

module alu_4bit(
    input [3:0] a,
    input [3:0] b,
    input [2:0] opcode,

    output reg [3:0] result,
    output reg carry,
    output reg borrow,
    output reg overflow,
    output reg zero,
    output reg negative
);

    reg [4:0] temp;

    always @(*) begin
        result = 4'b0000;
        temp = 5'b00000;

        carry = 1'b0;
        borrow = 1'b0;
        overflow = 1'b0;

        case (opcode)
            3'b000: begin
                temp = {1'b0, a} + {1'b0, b};
                result = temp[3:0];
                carry = temp[4];

                overflow =
                    (~(a[3] ^ b[3])) &
                    (result[3] ^ a[3]);
            end

            3'b001: begin
                result = a - b;
                borrow = (a < b);

                overflow =
                    (a[3] ^ b[3]) &
                    (result[3] ^ a[3]);
            end

            3'b010: begin
                result = a & b;
            end

            3'b011: begin
                result = a | b;
            end

            3'b100: begin
                result = a ^ b;
            end

            3'b101: begin
                result = ~a;
            end

            3'b110: begin
                temp = {1'b0, a} + 5'b00001;
                result = temp[3:0];
                carry = temp[4];

                overflow =
                    (~a[3]) &
                    result[3];
            end

            3'b111: begin
                result = a - 4'b0001;
                borrow = (a == 4'b0000);

                overflow =
                    a[3] &
                    (~result[3]);
            end
        endcase

        zero = (result == 4'b0000);
        negative = result[3];
    end

endmodule