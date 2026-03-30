module imem_tb;

reg [3:0] address;
wire [7:0] instruction;

instruction_memory uut(
    .address(address),
    .instruction(instruction)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, imem_tb);

    address = 0; #10;
    address = 1; #10;
    address = 2; #10;
    address = 3; #10;
    address = 4; #10;

    #10 $finish;
end

endmodule