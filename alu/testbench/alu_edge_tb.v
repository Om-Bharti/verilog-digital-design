`timescale 1ns/1ps

module alu_edge_tb;

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
        $dumpfile("alu_edge_wave.vcd");
        $dumpvars(0, alu_edge_tb);

        $display("TIME  A     B     OP      RESULT   C B O Z N");
        $display("----------------------------------------------");

        // ADD: 15 + 1 -> 0 with carry
        a = 4'b1111; b = 4'b0001; opcode = 3'b000; #10;
        $display("%4t  %b  %b    ADD     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // SUB: 3 - 5 -> 14 with borrow
        a = 4'b0011; b = 4'b0101; opcode = 3'b001; #10;
        $display("%4t  %b  %b    SUB     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // SUB: 5 - 5 -> 0
        a = 4'b0101; b = 4'b0101; opcode = 3'b001; #10;
        $display("%4t  %b  %b    SUB     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // ADD: 0 + 0 -> 0
        a = 4'b0000; b = 4'b0000; opcode = 3'b000; #10;
        $display("%4t  %b  %b    ADD     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // AND: 1111 & 0000 -> 0
        a = 4'b1111; b = 4'b0000; opcode = 3'b010; #10;
        $display("%4t  %b  %b    AND     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // OR: 1010 | 0101 -> 1111
        a = 4'b1010; b = 4'b0101; opcode = 3'b011; #10;
        $display("%4t  %b  %b    OR      %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // XOR: 1010 ^ 0101 -> 1111
        a = 4'b1010; b = 4'b0101; opcode = 3'b100; #10;
        $display("%4t  %b  %b    XOR     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // INC: 7 + 1 -> signed overflow
        a = 4'b0111; b = 4'b0000; opcode = 3'b110; #10;
        $display("%4t  %b  %b    INC     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        // DEC: 0 - 1 -> borrow
        a = 4'b0000; b = 4'b0000; opcode = 3'b111; #10;
        $display("%4t  %b  %b    DEC     %b      %b %b %b %b %b",
                 $time, a, b, result,
                 carry, borrow, overflow, zero, negative);

        #10 $finish;
    end

endmodule