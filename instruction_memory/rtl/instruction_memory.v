`timescale 1ns/1ps

module instruction_memory(
    input [3:0] address,
    output reg [7:0] instruction
);

    reg [7:0] memory [0:15];
    integer i;

    initial begin
        for (i = 0; i < 16; i = i + 1)
            memory[i] = 8'b000_00_00_0;

        // [7:5] opcode, [4:3] source/destination, [2:1] source
        memory[0] = 8'b000_00_01_0; // ADD R0, R1
        memory[1] = 8'b001_01_00_0; // SUB R1, R0
        memory[2] = 8'b010_01_10_0; // AND R1, R2
        memory[3] = 8'b011_10_01_0; // OR R2, R1
        memory[4] = 8'b100_00_11_0; // XOR R0, R3
        memory[5] = 8'b101_10_00_0; // NOT R2
        memory[6] = 8'b110_01_00_0; // INC R1
        memory[7] = 8'b111_11_00_0; // DEC R3
    end

    always @(*) begin
        instruction = memory[address];
    end

endmodule