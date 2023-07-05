`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2022 09:43:25 PM
// Design Name: 
// Module Name: alu_uart_interface
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module alu_uart_interface#
    (
        parameter BUS_SIZE = 8
    )
    (
        input wire rx,
        output wire tx,
        input wire i_clock,
        input wire i_reset,
        output wire full,
        output wire carry,
        output wire [BUS_SIZE - 1 : 0] result
    );
        localparam [1:0]
          DATOA = 2'b01,
          DATOB  = 2'b10,
          OPCODE  = 2'b11;
        
        reg [BUS_SIZE - 1 : 0] value_a;
        reg [BUS_SIZE - 1 : 0] value_b;
        reg [BUS_SIZE - 1 : 0] opcode;
        wire [BUS_SIZE - 1 : 0] rx_data;
        reg [BUS_SIZE - 1 : 0] tx_data;
        reg rd_signal;
        reg wr_signal;
        wire [BUS_SIZE - 1 : 0]alu_out;
        reg [BUS_SIZE - 1 : 0]o_result;
        wire o_carry;
        wire rx_empty;
        reg [1:0] state_reg, state_next;
        
        initial
        begin
            value_a = 0;
            value_b = 0;
            opcode = 0;
            rd_signal = 0;
            wr_signal = 0;
        end
        
        always @(posedge i_clock)
        begin
          if (i_reset)
             begin
                state_reg = DATOA;
             end
          else state_reg = state_next;
        end
          
        always@*
        begin
          if(~rx_empty)
          begin    
              case (state_reg)
                 DATOA:
                    begin
                        rd_signal = 1'b1;
                        value_a = rx_data;
                        state_next =  DATOB;
                    end
                 DATOB:
                      begin
                        rd_signal =  1'b1;
                        value_b =  rx_data;
                        state_next =  OPCODE;
                      end
                 OPCODE:
                      begin
                        rd_signal =  1'b1;
                        opcode =  rx_data;
                        tx_data =  alu_out;
                        o_result = alu_out;
                        wr_signal =  1'b1;
                        state_next =  DATOA;
                      end
              endcase
          end
          else
          begin
                rd_signal =  1'b0;
                wr_signal =  1'b0;
          end 
       end   
     
    uart#()
    uart_instance
       (
          .clk(i_clock),
          .reset(i_reset),
          .r_data(rx_data),
          .w_data(tx_data),
          .tx(tx),
          .rx(rx),
          .rd_uart(rd_signal),
          .wr_uart(wr_signal),
          .rx_empty(rx_empty),
          .tx_full(full)
       );
       
       alu#()
    alu_instance
        (
            .o_alu_out(alu_out),
            .i_opcode(opcode),
            .i_value_a(value_a),
            .i_value_b(value_b),
            .o_carry(o_carry)   
        );
        
     assign result = o_result;
     assign carry = o_carry;
                
endmodule
