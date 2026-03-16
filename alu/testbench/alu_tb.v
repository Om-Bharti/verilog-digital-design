module alu_tb;

reg [3:0] a;
reg [3:0] b;
reg [2:0] opcode;

wire [3:0] result;
wire carry;

alu_4bit uut(
    .a(a),
    .b(b),
    .opcode(opcode),
    .result(result),
    .carry(carry)
);

initial begin

    $dumpfile("wave.vcd");
    $dumpvars(0,alu_tb);

    $display("A   B   OPCODE  RESULT CARRY");

    a=4'b0101; b=4'b0011; opcode=3'b000; #10;
    $display("%b %b ADD  %b %b",a,b,result,carry);

    opcode=3'b001; #10;
    $display("%b %b SUB  %b %b",a,b,result,carry);

    opcode=3'b010; #10;
    $display("%b %b AND  %b %b",a,b,result,carry);

    opcode=3'b011; #10;
    $display("%b %b OR   %b %b",a,b,result,carry);

    opcode=3'b100; #10;
    $display("%b %b XOR  %b %b",a,b,result,carry);

    #10 $finish;

end

endmodule