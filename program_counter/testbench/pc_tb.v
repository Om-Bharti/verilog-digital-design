module pc_tb;

reg clk;
reg reset;

wire [3:0] pc;

program_counter uut(
    .clk(clk),
    .reset(reset),
    .pc(pc)
);

// Clock
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, pc_tb);

    clk = 0;
    reset = 1;

    #10 reset = 0;

    #100 $finish;
end

endmodule