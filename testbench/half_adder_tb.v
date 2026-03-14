module testbench;

reg a;
reg b;

wire sum;
wire carry;

half_adder uut(
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0,testbench);

    a=0; b=0;
    #10 a=0; b=1;
    #10 a=1; b=0;
    #10 a=1; b=1;

    #10 $finish;
end

endmodule