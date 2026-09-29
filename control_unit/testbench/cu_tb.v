`timescale 1ns/1ps

module cu_tb;

    reg [7:0] instruction;

    wire [2:0] opcode;
    wire [1:0] read_addr1;
    wire [1:0] read_addr2;
    wire we;

    control_unit uut(
        .instruction(instruction),
        .opcode(opcode),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .we(we)
    );

    initial begin
        $dumpfile("cu_wave.vcd");
        $dumpvars(0, cu_tb);

        $display("Instruction  Opcode  Addr1  Addr2  WE");
        $display("---------------------------------------");

        // ADD R0, R1
        instruction = 8'b000_00_01_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b000) &&
            (read_addr1 == 2'b00) &&
            (read_addr2 == 2'b01) &&
            (we == 1'b1))
            $display("PASS: ADD");

        else
            $display("FAIL: ADD");

        // SUB R1, R0
        instruction = 8'b001_01_00_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b001) &&
            (read_addr1 == 2'b01) &&
            (read_addr2 == 2'b00) &&
            (we == 1'b1))
            $display("PASS: SUB");

        else
            $display("FAIL: SUB");

        // AND R1, R2
        instruction = 8'b010_01_10_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b010) &&
            (read_addr1 == 2'b01) &&
            (read_addr2 == 2'b10) &&
            (we == 1'b1))
            $display("PASS: AND");

        else
            $display("FAIL: AND");

        // OR R2, R1
        instruction = 8'b011_10_01_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b011) &&
            (read_addr1 == 2'b10) &&
            (read_addr2 == 2'b01) &&
            (we == 1'b1))
            $display("PASS: OR");

        else
            $display("FAIL: OR");

        // XOR R0, R3
        instruction = 8'b100_00_11_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b100) &&
            (read_addr1 == 2'b00) &&
            (read_addr2 == 2'b11) &&
            (we == 1'b1))
            $display("PASS: XOR");

        else
            $display("FAIL: XOR");

        // NOT R2
        instruction = 8'b101_10_00_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b101) &&
            (read_addr1 == 2'b10) &&
            (read_addr2 == 2'b00) &&
            (we == 1'b1))
            $display("PASS: NOT");

        else
            $display("FAIL: NOT");

        // INC R1
        instruction = 8'b110_01_00_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b110) &&
            (read_addr1 == 2'b01) &&
            (read_addr2 == 2'b00) &&
            (we == 1'b1))
            $display("PASS: INC");

        else
            $display("FAIL: INC");

        // DEC R3
        instruction = 8'b111_11_00_0;
        #10;

        $display("%08b       %03b     %02b     %02b    %b",
                 instruction, opcode, read_addr1, read_addr2, we);

        if ((opcode == 3'b111) &&
            (read_addr1 == 2'b11) &&
            (read_addr2 == 2'b00) &&
            (we == 1'b1))
            $display("PASS: DEC");

        else
            $display("FAIL: DEC");

        $display("");
        $display("CONTROL UNIT TEST COMPLETE");

        #10 $finish;
    end

endmodule