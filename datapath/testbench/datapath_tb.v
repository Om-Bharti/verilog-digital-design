`timescale 1ns/1ps

module datapath_tb;

    reg clk;
    reg reset;
    reg we;

    reg [1:0] read_addr1;
    reg [1:0] read_addr2;
    reg [1:0] write_addr;

    reg [2:0] opcode;

    wire [3:0] alu_result;
    wire carry;
    wire borrow;
    wire overflow;
    wire zero;
    wire negative;

    datapath uut(
        .clk(clk),
        .reset(reset),
        .opcode(opcode),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .write_addr(write_addr),
        .we(we),
        .alu_result(alu_result),
        .carry(carry),
        .borrow(borrow),
        .overflow(overflow),
        .zero(zero),
        .negative(negative)
    );

    always #5 clk = ~clk;

    task display_state;
        begin
            $display(
                "TIME=%0t | OP=%03b | A=R%0d | B=R%0d | RESULT=%0h | C=%b B=%b O=%b Z=%b N=%b",
                $time,
                opcode,
                read_addr1,
                read_addr2,
                alu_result,
                carry,
                borrow,
                overflow,
                zero,
                negative
            );
        end
    endtask

    initial begin
        $dumpfile("datapath_wave.vcd");
        $dumpvars(0, datapath_tb);

        clk = 1'b0;
        reset = 1'b1;
        we = 1'b0;

        read_addr1 = 2'b00;
        read_addr2 = 2'b00;
        write_addr = 2'b00;
        opcode = 3'b000;

        #2;

        if ((uut.rf.regfile[0] == 4'b0101) &&
            (uut.rf.regfile[1] == 4'b0011) &&
            (uut.rf.regfile[2] == 4'b0010) &&
            (uut.rf.regfile[3] == 4'b0001))
            $display("PASS: Reset");
        else
            $display("FAIL: Reset");

        #8;
        reset = 1'b0;

        // ADD: R0 + R1 = 8
        read_addr1 = 2'b00;
        read_addr2 = 2'b01;
        write_addr = 2'b10;
        opcode = 3'b000;
        we = 1'b0;

        #2;
        display_state;

        if ((alu_result == 4'b1000) &&
            (carry == 1'b0) &&
            (overflow == 1'b1) &&
            (zero == 1'b0) &&
            (negative == 1'b1))
            $display("PASS: ADD");
        else
            $display("FAIL: ADD");

        we = 1'b1;
        #8;

        if (uut.rf.regfile[2] == 4'b1000)
            $display("PASS: ADD write-back");
        else
            $display("FAIL: ADD write-back");

        // SUB: R2 - R1 = 5
        we = 1'b0;
        read_addr1 = 2'b10;
        read_addr2 = 2'b01;
        write_addr = 2'b11;
        opcode = 3'b001;

        #2;
        display_state;

        if ((alu_result == 4'b0101) &&
            (borrow == 1'b0) &&
            (overflow == 1'b1) &&
            (zero == 1'b0) &&
            (negative == 1'b0))
            $display("PASS: SUB");
        else
            $display("FAIL: SUB");

        we = 1'b1;
        #8;

        if (uut.rf.regfile[3] == 4'b0101)
            $display("PASS: SUB write-back");
        else
            $display("FAIL: SUB write-back");

        // AND: R2 & R3 = 0
        we = 1'b0;
        read_addr1 = 2'b10;
        read_addr2 = 2'b11;
        write_addr = 2'b00;
        opcode = 3'b010;

        #2;
        display_state;

        if ((alu_result == 4'b0000) &&
            (carry == 1'b0) &&
            (borrow == 1'b0) &&
            (overflow == 1'b0) &&
            (zero == 1'b1) &&
            (negative == 1'b0))
            $display("PASS: AND");
        else
            $display("FAIL: AND");

        // OR: R2 | R3 = 13
        opcode = 3'b011;

        #2;
        display_state;

        if ((alu_result == 4'b1101) &&
            (carry == 1'b0) &&
            (borrow == 1'b0) &&
            (overflow == 1'b0) &&
            (zero == 1'b0) &&
            (negative == 1'b1))
            $display("PASS: OR");
        else
            $display("FAIL: OR");

        // XOR: R2 ^ R3 = 13
        opcode = 3'b100;

        #2;
        display_state;

        if ((alu_result == 4'b1101) &&
            (carry == 1'b0) &&
            (borrow == 1'b0) &&
            (overflow == 1'b0) &&
            (zero == 1'b0) &&
            (negative == 1'b1))
            $display("PASS: XOR");
        else
            $display("FAIL: XOR");

        // NOT: ~R2 = 7
        read_addr1 = 2'b10;
        opcode = 3'b101;

        #2;
        display_state;

        if ((alu_result == 4'b0111) &&
            (carry == 1'b0) &&
            (borrow == 1'b0) &&
            (overflow == 1'b0) &&
            (zero == 1'b0) &&
            (negative == 1'b0))
            $display("PASS: NOT");
        else
            $display("FAIL: NOT");

        // INC: R2 + 1 = 9
        opcode = 3'b110;

        #2;
        display_state;

        if ((alu_result == 4'b1001) &&
            (carry == 1'b0) &&
            (borrow == 1'b0) &&
            (overflow == 1'b0) &&
            (zero == 1'b0) &&
            (negative == 1'b1))
            $display("PASS: INC");
        else
            $display("FAIL: INC");

        // DEC: R2 - 1 = 7
        opcode = 3'b111;

        #2;
        display_state;

        if ((alu_result == 4'b0111) &&
            (carry == 1'b0) &&
            (borrow == 1'b0) &&
            (overflow == 1'b1) &&
            (zero == 1'b0) &&
            (negative == 1'b0))
            $display("PASS: DEC");
        else
            $display("FAIL: DEC");

        // Write enable
        we = 1'b0;
        write_addr = 2'b00;
        #10;

        if (uut.rf.regfile[0] == 4'b0101)
            $display("PASS: Write disabled");
        else
            $display("FAIL: Write disabled");

        $display("");
        $display("Final register state:");
        $display("R0 = %b", uut.rf.regfile[0]);
        $display("R1 = %b", uut.rf.regfile[1]);
        $display("R2 = %b", uut.rf.regfile[2]);
        $display("R3 = %b", uut.rf.regfile[3]);

        #10 $finish;
    end

endmodule