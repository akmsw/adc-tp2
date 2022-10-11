module alu
  #(
    parameter OPCODE_SIZE = 6,
    parameter BUS_SIZE = 8
  )
  (
    input wire [BUS_SIZE - 1 : 0] i_value_a,
    input wire [BUS_SIZE - 1 : 0] i_value_b,
    input wire [BUS_SIZE - 1 : 0] i_opcode,

    output wire o_carry,
    output wire [BUS_SIZE - 1 : 0] o_alu_out
  );

  // ALU opcodes
  localparam ADD = 6'b100000;
  localparam SUB = 6'b100010;
  localparam AND = 6'b100100;
  localparam OR  = 6'b100101;
  localparam XOR = 6'b100110;
  localparam NOR = 6'b100111;
  localparam SRL = 6'b000010;
  localparam SRA = 6'b000011;

  reg [BUS_SIZE : 0] result;

  assign o_alu_out = result;
  assign o_carry = result[BUS_SIZE];

  // Combinational logic
  always @(*)
  begin
    case (i_opcode)
      ADD:
        result = i_value_a + i_value_b;
      SUB:
        result = i_value_a - i_value_b;
      AND:
        result = i_value_a & i_value_b;
      OR:
        result = i_value_a | i_value_b;
      XOR:
        result = i_value_a ^ i_value_b;
      NOR:
        result = ~(i_value_a | i_value_b);
      SRL:
        result = i_value_a >> 1;
      SRA:
        result = i_value_a >>> 1;
      default:
        result = i_value_a + i_value_b;
    endcase
  end

endmodule
