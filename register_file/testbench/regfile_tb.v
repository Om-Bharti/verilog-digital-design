module regfile_tb;

reg clk;
reg we;
reg [1:0] write_addr;
reg [1:0] read_addr1;
reg [1:0] read_addr2;
reg [3:0] write_data;

wire [3:0] read_data1;
wire [3:0] read_data2;

register_file uut(
    .clk(clk),
    .we(we),
    .write_addr(write_addr),
    .read_addr1(read_addr1),
    .read_addr2(read_addr2),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

// Clock generation
always #5 clk = ~clk;

initial begin
    $dumpfile("wave.vcd");
    $dumpvars(0, regfile_tb);

    clk = 0;
    we = 1;

    // Write values
    write_addr = 2'b00; write_data = 4'b1010; #10;
    write_addr = 2'b01; write_data = 4'b0101; #10;
    write_addr = 2'b10; write_data = 4'b1111; #10;

    // Read values
    we = 0;
    read_addr1 = 2'b00;
    read_addr2 = 2'b01; #10;

    read_addr1 = 2'b10;
    read_addr2 = 2'b00; #10;

    #10 $finish;
end

endmodule