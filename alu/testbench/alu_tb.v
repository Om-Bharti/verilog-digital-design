`timescale 1ns/1ps

module alu_tb;

    reg [3:0] a;
    reg [3:0] b;
    reg [2:0] opcode;

    wire [3:0] result;
    wire carry;
    wire borrow;
    wire overflow;
    wire zero;
    wire negative;

    alu_4bit uut(
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .carry(carry),
        .borrow(borrow),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    initial begin
        $dumpfile("alu_wave.vcd");
        $dumpvars(0, alu_tb);

        $display(" A     B     OP      RESULT   C B O Z N");
        $display("-----------------------------------------");

        // ADD
        a = 4'b0101; b = 4'b0011; opcode = 3'b000; #10;
        $display("%b   %b    ADD      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1111; b = 4'b0001; opcode = 3'b000; #10;
        $display("%b   %b    ADD      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b0111; b = 4'b0001; opcode = 3'b000; #10;
        $display("%b   %b    ADD      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1100; b = 4'b1011; opcode = 3'b000; #10;
        $display("%b   %b    ADD      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        // SUB
        a = 4'b0101; b = 4'b0011; opcode = 3'b001; #10;
        $display("%b   %b    SUB      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b0011; b = 4'b0101; opcode = 3'b001; #10;
        $display("%b   %b    SUB      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b0101; b = 4'b0101; opcode = 3'b001; #10;
        $display("%b   %b    SUB      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b0111; b = 4'b1111; opcode = 3'b001; #10;
        $display("%b   %b    SUB      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1000; b = 4'b0001; opcode = 3'b001; #10;
        $display("%b   %b    SUB      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        // Logical operations
        a = 4'b1010; b = 4'b1100; opcode = 3'b010; #10;
        $display("%b   %b    AND      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1010; b = 4'b0101; opcode = 3'b011; #10;
        $display("%b   %b    OR       %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1010; b = 4'b0101; opcode = 3'b100; #10;
        $display("%b   %b    XOR      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1010; b = 4'b0000; opcode = 3'b101; #10;
        $display("%b   %b    NOT      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        // INC
        a = 4'b0111; b = 4'b0000; opcode = 3'b110; #10;
        $display("%b   %b    INC      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b1111; b = 4'b0000; opcode = 3'b110; #10;
        $display("%b   %b    INC      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        // DEC
        a = 4'b0101; b = 4'b0000; opcode = 3'b111; #10;
        $display("%b   %b    DEC      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        a = 4'b0000; b = 4'b0000; opcode = 3'b111; #10;
        $display("%b   %b    DEC      %b      %b %b %b %b %b",
                 a, b, result, carry, borrow, overflow, zero, negative);

        #10 $finish;
    end

endmodule