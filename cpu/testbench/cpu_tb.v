`timescale 1ns/1ps

module cpu_tb;

    reg clk;
    reg reset;

    wire [3:0] pc;
    wire [7:0] instruction;
    wire [2:0] opcode;
    wire [1:0] read_addr1;
    wire [1:0] read_addr2;
    wire we;

    wire [3:0] alu_result;
    wire carry;
    wire borrow;
    wire overflow;
    wire zero;
    wire negative;

    wire [3:0] R0;
    wire [3:0] R1;
    wire [3:0] R2;
    wire [3:0] R3;

    cpu uut(
        .clk(clk),
        .reset(reset),
        .pc(pc),
        .instruction(instruction),
        .opcode(opcode),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .we(we),
        .alu_result(alu_result),
        .carry(carry),
        .borrow(borrow),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    assign R0 = uut.dp_inst.rf.regfile[0];
    assign R1 = uut.dp_inst.rf.regfile[1];
    assign R2 = uut.dp_inst.rf.regfile[2];
    assign R3 = uut.dp_inst.rf.regfile[3];

    always #5 clk = ~clk;

    initial begin
        $dumpfile("cpu_wave.vcd");
        $dumpvars(0, cpu_tb);

        clk = 1'b0;
        reset = 1'b1;

        $display("");
        $display("SIMPLE CPU TEST");
        $display("---------------");

        $display("ISA:");
        $display("000 = ADD");
        $display("001 = SUB");
        $display("010 = AND");
        $display("011 = OR");
        $display("100 = XOR");
        $display("101 = NOT");
        $display("110 = INC");
        $display("111 = DEC");

        @(negedge clk);
        reset = 1'b0;

        $display("");
        $display("PC | INST | OP  | SRC1 | SRC2 | WE | ALU | C | B | O | Z | N");
        $display("--------------------------------------------------------------");

        // ADD R0,R1
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // SUB R1,R0
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // AND R1,R2
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // OR R2,R1
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // XOR R0,R3
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // NOT R2
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // INC R1
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;
        @(negedge clk);

        // DEC R3
        $display(
            "%0d  |  %02h  | %03b |  R%0d   |  R%0d   | %b  |  %01h  | %b | %b | %b | %b | %b",
            pc,
            instruction,
            opcode,
            read_addr1,
            read_addr2,
            we,
            alu_result,
            carry,
            borrow,
            overflow,
            zero,
            negative
        );

        @(posedge clk);
        #1;

        $display("");
        $display("FINAL REGISTER STATE");
        $display("--------------------");

        $display("R0 = %04b (%0d)", R0, R0);
        $display("R1 = %04b (%0d)", R1, R1);
        $display("R2 = %04b (%0d)", R2, R2);
        $display("R3 = %04b (%0d)", R3, R3);

        $display("");
        $display("FINAL CHECKS");

        if (R0 == 4'b1001)
            $display("PASS: R0 = 9");
        else
            $display("FAIL: R0 expected 9, got %0d", R0);

        if (R1 == 4'b0011)
            $display("PASS: R1 = 3");
        else
            $display("FAIL: R1 expected 3, got %0d", R1);

        if (R2 == 4'b1101)
            $display("PASS: R2 = 13");
        else
            $display("FAIL: R2 expected 13, got %0d", R2);

        if (R3 == 4'b0000)
            $display("PASS: R3 = 0");
        else
            $display("FAIL: R3 expected 0, got %0d", R3);

        if (pc == 4'd8)
            $display("PASS: PC advanced to address 8");
        else
            $display("FAIL: PC expected 8, got %0d", pc);

        $display("");
        $display("CPU TEST COMPLETE");

        $finish;
    end

endmodule