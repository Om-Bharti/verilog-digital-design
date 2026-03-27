module datapath_tb;

reg clk;
reg we;
reg [1:0] read_addr1;
reg [1:0] read_addr2;
reg [1:0] write_addr;
reg [2:0] opcode;

wire [3:0] alu_result;

datapath uut(
    .clk(clk),
    .we(we),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_addr(write_addr),
    .opcode(opcode),
    .alu_result(alu_result)
);

// Clock
always #5 clk = ~clk;

initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, datapath_tb);

    clk = 0;
    we = 1;

    // Step 1: Load values into registers
    write_addr = 2'b00; #10;  // R0
    write_addr = 2'b01; #10;  // R1

    // Step 2: Read and perform ADD
    we = 0;
    read_addr1 = 2'b00;
    read_addr2 = 2'b01;
    opcode = 3'b000; // ADD
    #10;

    // Step 3: Write result back
    we = 1;
    write_addr = 2'b10; #10;

    #20 $finish;

end

endmodule