`timescale 1ns/1ps

module regfile_tb;

    reg clk;
    reg reset;
    reg we;

    reg [1:0] write_addr;
    reg [3:0] write_data;

    reg [1:0] read_addr1;
    reg [1:0] read_addr2;

    wire [3:0] read_data1;
    wire [3:0] read_data2;

    register_file uut(
        .clk(clk),
        .reset(reset),
        .we(we),
        .write_addr(write_addr),
        .write_data(write_data),
        .read_addr1(read_addr1),
        .read_addr2(read_addr2),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("regfile_wave.vcd");
        $dumpvars(0, regfile_tb);

        clk = 1'b0;
        reset = 1'b1;
        we = 1'b0;

        write_addr = 2'b00;
        write_data = 4'b0000;
        read_addr1 = 2'b00;
        read_addr2 = 2'b00;

        #2;

        if ((uut.regfile[0] == 4'b0101) &&
            (uut.regfile[1] == 4'b0011) &&
            (uut.regfile[2] == 4'b0010) &&
            (uut.regfile[3] == 4'b0001))
            $display("PASS: Reset values");
        else
            $display("FAIL: Reset values");

        reset = 1'b0;

        read_addr1 = 2'b00;
        read_addr2 = 2'b01;
        #1;

        if ((read_data1 == 4'b0101) &&
            (read_data2 == 4'b0011))
            $display("PASS: Read R0/R1");
        else
            $display("FAIL: Read R0/R1");

        read_addr1 = 2'b10;
        read_addr2 = 2'b11;
        #1;

        if ((read_data1 == 4'b0010) &&
            (read_data2 == 4'b0001))
            $display("PASS: Read R2/R3");
        else
            $display("FAIL: Read R2/R3");

        we = 1'b1;
        write_addr = 2'b00;
        write_data = 4'b1010;
        #8;

        if (uut.regfile[0] == 4'b1010)
            $display("PASS: Write R0");
        else
            $display("FAIL: Write R0");

        write_addr = 2'b01;
        write_data = 4'b0101;
        #10;

        if (uut.regfile[1] == 4'b0101)
            $display("PASS: Write R1");
        else
            $display("FAIL: Write R1");

        write_addr = 2'b10;
        write_data = 4'b1111;
        #10;

        if (uut.regfile[2] == 4'b1111)
            $display("PASS: Write R2");
        else
            $display("FAIL: Write R2");

        write_addr = 2'b11;
        write_data = 4'b1001;
        #10;

        if (uut.regfile[3] == 4'b1001)
            $display("PASS: Write R3");
        else
            $display("FAIL: Write R3");

        we = 1'b0;

        read_addr1 = 2'b00;
        read_addr2 = 2'b01;
        #1;

        if ((read_data1 == 4'b1010) &&
            (read_data2 == 4'b0101))
            $display("PASS: Read R0/R1 after write");
        else
            $display("FAIL: Read R0/R1 after write");

        read_addr1 = 2'b10;
        read_addr2 = 2'b11;
        #1;

        if ((read_data1 == 4'b1111) &&
            (read_data2 == 4'b1001))
            $display("PASS: Read R2/R3 after write");
        else
            $display("FAIL: Read R2/R3 after write");

        write_addr = 2'b00;
        write_data = 4'b0000;
        #10;

        if (uut.regfile[0] == 4'b1010)
            $display("PASS: Write disabled");
        else
            $display("FAIL: Write disabled");

        read_addr1 = 2'b01;
        read_addr2 = 2'b10;
        #1;

        if ((read_data1 == 4'b0101) &&
            (read_data2 == 4'b1111))
            $display("PASS: Asynchronous read");
        else
            $display("FAIL: Asynchronous read");

        $display("");
        $display("Final register state:");
        $display("R0 = %b", uut.regfile[0]);
        $display("R1 = %b", uut.regfile[1]);
        $display("R2 = %b", uut.regfile[2]);
        $display("R3 = %b", uut.regfile[3]);

        #10 $finish;
    end

endmodule