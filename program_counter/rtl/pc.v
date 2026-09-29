`timescale 1ns/1ps

module program_counter(
    input clk,
    input reset,
    output reg [3:0] pc
);

    always @(posedge clk or posedge reset) begin
        if (reset)
            pc <= 4'b0000;
        else
            pc <= pc + 4'b0001;
    end

endmodule