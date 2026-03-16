module rca_tb;

reg [3:0] a;
reg [3:0] b;
reg cin;

wire [3:0] sum;
wire cout;

rca_4bit uut(
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .cout(cout)
);

initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0, rca_tb);

    a = 4'b0000; b = 4'b0000; cin = 0;
    #10 a = 4'b0011; b = 4'b0001;
    #10 a = 4'b0101; b = 4'b0011;
    #10 a = 4'b1111; b = 4'b0001;
    #10 a = 4'b1010; b = 4'b0101;

    #10 $finish;

end

endmodule