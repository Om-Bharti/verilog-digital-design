module alu_4bit(
    input [3:0] a,
    input [3:0] b,
    input [2:0] opcode,
    output reg [3:0] result,
    output reg carry
);

reg [4:0] temp;

always @(*) begin

    case(opcode)

        3'b000: begin
            temp = a + b;
            result = temp[3:0];
            carry = temp[4];
        end

        3'b001: begin
            temp = a - b;
            result = temp[3:0];
            carry = temp[4];
        end

        3'b010: begin
            result = a & b;
            carry = 0;
        end

        3'b011: begin
            result = a | b;
            carry = 0;
        end

        3'b100: begin
            result = a ^ b;
            carry = 0;
        end

        default: begin
            result = 4'b0000;
            carry = 0;
        end

    endcase

end

endmodule