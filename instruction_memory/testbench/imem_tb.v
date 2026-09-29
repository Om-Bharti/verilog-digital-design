`timescale 1ns/1ps

module imem_tb;

    reg [3:0] address;
    wire [7:0] instruction;

    instruction_memory uut(
        .address(address),
        .instruction(instruction)
    );

    initial begin
        $dumpfile("imem_wave.vcd");
        $dumpvars(0, imem_tb);

        $display("ADDR   INSTRUCTION   HEX");
        $display("-------------------------");

        address = 4'd0;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b000_00_01_0)
            $display("PASS: Address 0 = ADD R0,R1");
        else
            $display("FAIL: Address 0 incorrect");

        address = 4'd1;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b001_01_00_0)
            $display("PASS: Address 1 = SUB R1,R0");
        else
            $display("FAIL: Address 1 incorrect");

        address = 4'd2;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b010_01_10_0)
            $display("PASS: Address 2 = AND R1,R2");
        else
            $display("FAIL: Address 2 incorrect");

        address = 4'd3;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b011_10_01_0)
            $display("PASS: Address 3 = OR R2,R1");
        else
            $display("FAIL: Address 3 incorrect");

        address = 4'd4;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b100_00_11_0)
            $display("PASS: Address 4 = XOR R0,R3");
        else
            $display("FAIL: Address 4 incorrect");

        address = 4'd5;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b101_10_00_0)
            $display("PASS: Address 5 = NOT R2");
        else
            $display("FAIL: Address 5 incorrect");

        address = 4'd6;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b110_01_00_0)
            $display("PASS: Address 6 = INC R1");
        else
            $display("FAIL: Address 6 incorrect");

        address = 4'd7;
        #10;
        $display(" %2d      %08b      %02h", address, instruction, instruction);

        if (instruction == 8'b111_11_00_0)
            $display("PASS: Address 7 = DEC R3");
        else
            $display("FAIL: Address 7 incorrect");

        // Check default initialized locations
        address = 4'd8;
        #10;

        if (instruction == 8'b000_00_00_0)
            $display("PASS: Address 8 default value");
        else
            $display("FAIL: Address 8 incorrect");

        address = 4'd15;
        #10;

        if (instruction == 8'b000_00_00_0)
            $display("PASS: Address 15 default value");
        else
            $display("FAIL: Address 15 incorrect");

        $display("");
        $display("INSTRUCTION MEMORY TEST COMPLETE");

        #10 $finish;
    end

endmodule