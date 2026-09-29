`timescale 1ns/1ps

module register_file(
    input clk,
    input reset,

    input we,

    input [1:0] write_addr,
    input [3:0] write_data,

    input [1:0] read_addr1,
    input [1:0] read_addr2,

    output [3:0] read_data1,
    output [3:0] read_data2
);

    reg [3:0] regfile [0:3];

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            regfile[0] <= 4'b0101;
            regfile[1] <= 4'b0011;
            regfile[2] <= 4'b0010;
            regfile[3] <= 4'b0001;
        end
        else if (we) begin
            regfile[write_addr] <= write_data;
        end
    end

    assign read_data1 = regfile[read_addr1];
    assign read_data2 = regfile[read_addr2];

endmodule