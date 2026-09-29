`timescale 1ns/1ps

module pc_tb;

    reg clk;
    reg reset;

    wire [3:0] pc;

    program_counter uut(
        .clk(clk),
        .reset(reset),
        .pc(pc)
    );

    always #5 clk = ~clk;

    initial begin
        $dumpfile("pc_wave.vcd");
        $dumpvars(0, pc_tb);

        clk = 1'b0;
        reset = 1'b1;

        // Asynchronous reset
        #2;

        if (pc == 4'b0000)
            $display("PASS: PC reset to 0000");
        else
            $display("FAIL: PC reset incorrect");

        reset = 1'b0;

        // Increment
        @(posedge clk);
        #1;

        if (pc == 4'd1)
            $display("PASS: PC = 1");
        else
            $display("FAIL: Expected PC = 1, got %0d", pc);

        @(posedge clk);
        #1;

        if (pc == 4'd2)
            $display("PASS: PC = 2");
        else
            $display("FAIL: Expected PC = 2, got %0d", pc);

        @(posedge clk);
        #1;

        if (pc == 4'd3)
            $display("PASS: PC = 3");
        else
            $display("FAIL: Expected PC = 3, got %0d", pc);

        // Continuous counting
        repeat (5) begin
            @(posedge clk);
            #1;
            $display("PC = %0d", pc);
        end

        // 4-bit wraparound
        while (pc != 4'd15) begin
            @(posedge clk);
            #1;
        end

        $display("PASS: PC reached 15");

        @(posedge clk);
        #1;

        if (pc == 4'd0)
            $display("PASS: PC wrapped from 15 to 0");
        else
            $display("FAIL: PC did not wrap correctly");

        // Reset during operation
        @(posedge clk);
        #1;

        if (pc == 4'd1)
            $display("PASS: PC resumed counting");
        else
            $display("FAIL: PC did not resume correctly");

        #2;
        reset = 1'b1;

        #1;

        if (pc == 4'd0)
            $display("PASS: Asynchronous reset forced PC to 0");
        else
            $display("FAIL: Asynchronous reset failed");

        #2;
        reset = 1'b0;

        @(posedge clk);
        #1;

        if (pc == 4'd1)
            $display("PASS: PC resumed after reset");
        else
            $display("FAIL: PC did not resume after reset");

        $display("");
        $display("PROGRAM COUNTER TEST COMPLETE");

        #10 $finish;
    end

endmodule