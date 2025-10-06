module alu #(
  BW = 16 // bitwidth
  ) (
  input  logic signed  [BW-1:0] in_a,
  input  logic signed  [BW-1:0] in_b,
  input  logic         [3:0] opcode,
  output logic signed  [BW-1:0] out,
  output logic         [2:0] flags // {overflow, negative, zero}
  );

logic [BW-1:0] res;
  // Complete your RTL code here
always_comb begin
  case (opcode)
    3'b000: res = in_a + in_b;
    3'b001: res = in_a - in_b; 
    3'b010: res = in_a && in_b; //logic and
    3'b011: res = in_a || in_b;
    3'b100: res = in_a ^ in_b;
    3'b101: res = in_a + 1;
    3'b110: res = in_a;
    3'b111: res = in_b;
    default: res = 0;
  endcase
end

assign out = res;
wire overflow, negative, zero;
assign flags = {overflow, negative, zero};

assign overflow = (opcode == 3'b000 && ((in_a > 0 && in_b > 0 && res < 0) || (in_a < 0 && in_b < 0 && res > 0))) ||
                  (opcode == 3'b001 && ((in_a > 0 && in_b < 0 && res < 0) || (in_a < 0 && in_b > 0 && res > 0)));

assign negative = res < 0;
assign zero = (res == 0);
endmodule




