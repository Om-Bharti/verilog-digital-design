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
    $dumpfile("wave.vcd");
    $dumpvars(0, cu_tb);

    // ADD R0, R1
    instruction = 8'b000_00_01; #10;

    // SUB R1, R0
    instruction = 8'b001_01_00; #10;

    // AND R1, R2
    instruction = 8'b010_01_10; #10;

    // OR R2, R1
    instruction = 8'b011_10_01; #10;

    // XOR R0, R3
    instruction = 8'b100_00_11; #10;

    #10 $finish;
end

endmodule