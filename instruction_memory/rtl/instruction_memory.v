module instruction_memory(
    input [3:0] address,
    output reg [7:0] instruction
);

reg [7:0] memory [15:0]; // 16 instructions

// Initialize instructions
initial begin
    memory[0] = 8'b000_00_01; // ADD R0, R1
    memory[1] = 8'b001_01_00; // SUB R1, R0
    memory[2] = 8'b010_01_10; // AND R1, R2
    memory[3] = 8'b011_10_01; // OR  R2, R1
    memory[4] = 8'b100_00_11; // XOR R0, R3
end

always @(*) begin
    instruction = memory[address];
end

endmodule