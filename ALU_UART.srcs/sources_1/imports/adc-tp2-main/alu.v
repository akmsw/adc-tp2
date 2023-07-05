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
  localparam ADD = 8'b01100001;
  localparam SUB = 8'b01100010;
  localparam AND = 8'b01100011;
  localparam OR  = 8'b01100100;
  localparam XOR = 8'b01100101;
  localparam NOR = 8'b01100110;
  localparam SRL = 8'b01100111;
  localparam SRA = 8'b01101000;

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
