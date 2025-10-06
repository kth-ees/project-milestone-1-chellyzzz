module alu_tb;

  localparam BW = 16; // bitwidth
  logic signed [BW-1:0] in_a;
  logic signed [BW-1:0] in_b;
  logic             [3:0] opcode;
  logic signed [BW-1:0] out;
  logic             [2:0] flags; // {overflow, negative, zero}

  // Instantiate the ALU
  alu #(BW) dut (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .out(out),
    .flags(flags)
  );
  
  initial begin
    // use iverilog to create a waveform file
    $dumpfile("alu_tb.vcd");
    $dumpvars(0, alu_tb);
    #1000ns;
    $finish;
  end

  // Generate stimuli to test the ALU
  initial begin
    in_a = '0;
    in_b = '0;
    opcode = '0;
    #10ns;
    // Complete your testbench code here
    in_a = 16'sd10000; in_b = 16'sd20000; opcode = 4'b0000; #10ns; // Addition
    in_a = 16'sd30000; in_b = 16'sd10000; opcode = 4'b0001; #10ns; // Subtraction
    in_a = 16'sd15; in_b = 16'sd27; opcode = 4'b0010; #10ns; // Logical AND
    in_a = 16'sd15; in_b = 16'sd27; opcode = 4'b0011; #10ns; // Logical OR
    in_a = 16'sd29; in_b = 16'sd15; opcode = 4'b0100; #10ns; // Bitwise XOR
    in_a = 16'sd42; opcode = 4'b0101; #10ns; // Increment
    in_a = 16'sd12345; opcode = 4'b0110; #10ns; // Pass through A
    in_b = 16'sd54321; opcode = 4'b0111; #10ns; // Pass through B
    // check overflow
    in_a = 16'sd20000; in_b = 16'sd200
    00; opcode = 4'b0000; #10ns; // Addition overflow
    in_a = -16'sd20000; in_b = -16'sd200
    00; opcode = 4'b0000; #10ns; // Addition overflow
    in_a = 16'sd20000; in_b = -16'sd-
    10000; opcode = 4'b0001; #10ns; // Subtraction overflow
    in_a = -16'sd20000; in_b = 16'sd20000; opcode = 4'b0001; #10ns; // Subtraction overflow
    // check zero and negative
    in_a = 16'sd10000; in_b = -16'sd10000; opcode = 4'b0001; #10ns; // Result zero
    in_a = -16'sd10000; in_b = 16'sd20000; opcode = 4'b0001; #10ns; // Result negative
    // Reset inputs at the end
    in_a = 16'sd0; in_b = 16'sd0; opcode = 4'b0000; #10ns;
  end

endmodule
