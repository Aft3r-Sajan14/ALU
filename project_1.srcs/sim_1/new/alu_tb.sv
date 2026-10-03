`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 18:01:53
// Design Name: 
// Module Name: alu_tb
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


module alu_tb();

    logic [3:0] A;
    logic [3:0] B;
    logic [2:0] Operation;
    logic [3:0] Output;
    logic n, z, o, c;

    // Instancia del módulo ALU
    alu uut (
        .A(A),
        .B(B),
        .Operation(Operation),
        .Output(Output),
        .n(n),
        .z(z),
        .o(o),
        .c(c)
    );

    initial begin
        $display("Iniciando simulacion de la ALU...");
        
        // 000: Addition A + B
        Operation = 3'b000; A = 4'b0010; B = 4'b0011; #10; // 2 + 3 = 5
        A = 4'b0111; B = 4'b0001; #10; // 7 + 1 = 8 (-8) (Overflow, Negative)
        A = 4'b1111; B = 4'b0001; #10; // -1 + 1 = 0 (Carry, Zero)
        
        // 001: Subtraction A - B
        Operation = 3'b001; A = 4'b0101; B = 4'b0010; #10; // 5 - 2 = 3
        A = 4'b0010; B = 4'b0101; #10; // 2 - 5 = -3 (1101) (Borrow, Negative)
        A = 4'b1000; B = 4'b0001; #10; // -8 - 1 = 7 (Overflow)
        
        // 010: Bitwise AND
        Operation = 3'b010; A = 4'b1100; B = 4'b1010; #10; // 1100 & 1010 = 1000
        
        // 011: Bitwise OR
        Operation = 3'b011; A = 4'b1100; B = 4'b1010; #10; // 1100 | 1010 = 1110
        
        // 100: Bitwise XOR
        Operation = 3'b100; A = 4'b1100; B = 4'b1010; #10; // 1100 ^ 1010 = 0110
        
        // 101: Bitwise NOT A
        Operation = 3'b101; A = 4'b1010; B = 4'b0000; #10; // ~1010 = 0101
        
        // 110: Logical Shift Left
        Operation = 3'b110; A = 4'b0011; B = 4'b0000; #10; // 0011 << 1 = 0110
        A = 4'b1011; #10; // 1011 << 1 = 0110 (Carry = 1)
        
        // 111: Logical Shift Right
        Operation = 3'b111; A = 4'b0110; B = 4'b0000; #10; // 0110 >> 1 = 0011
        A = 4'b0001; #10; // 0001 >> 1 = 0000 (Zero = 1)

        $display("Simulacion finalizada.");
        $finish;
    end

endmodule
