module control_unit(
    input [7:0] instruction,

    output [2:0] opcode,
    output [1:0] read_addr1,
    output [1:0] read_addr2,
    output reg we
);

// Decode fields
assign opcode      = instruction[7:5];
assign read_addr1  = instruction[4:3];
assign read_addr2 = instruction[1:0];

// Simple write enable logic
always @(*) begin
    case(opcode)
        3'b000: we = 1; // ADD
        3'b001: we = 1; // SUB
        3'b010: we = 1; // AND
        3'b011: we = 1; // OR
        3'b100: we = 1; // XOR
        default: we = 0;
    endcase
end

endmodule