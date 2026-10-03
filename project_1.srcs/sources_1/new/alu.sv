`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.09.2026 17:59:33
// Design Name: 
// Module Name: alu
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


module alu (
    input  logic [3:0] A,
    input  logic [3:0] B,
    input  logic [2:0] Operation,
    output logic [3:0] Output,
    output logic       n, // negative
    output logic       z, // zero
    output logic       o, // overflow
    output logic       c  // carry/borrow
);

    logic [4:0] A_ext;
    logic [4:0] B_ext;
    logic [4:0] res_ext;

    always_comb begin
        // Valores por defecto
        A_ext = {1'b0, A};
        B_ext = {1'b0, B};
        res_ext = 5'b00000;
        Output = 4'b0000;
        n = 1'b0;
        z = 1'b0;
        o = 1'b0;
        c = 1'b0;

        case (Operation)
            3'b000: begin // Addition: A + B
                res_ext = A_ext + B_ext;
                Output = res_ext[3:0];
                c = res_ext[4];
                // Overflow para suma: el signo de A y B es igual, pero diferente al del resultado
                o = (A[3] == B[3]) && (Output[3] != A[3]);
            end
            3'b001: begin // Subtraction: A - B
                res_ext = A_ext - B_ext;
                Output = res_ext[3:0];
                c = res_ext[4]; // Si hay borrow, el bit 4 será 1
                // Overflow para resta: el signo de A y B es diferente, y el resultado tiene diferente signo que A
                o = (A[3] != B[3]) && (Output[3] != A[3]);
            end
            3'b010: begin // Bitwise AND
                Output = A & B;
            end
            3'b011: begin // Bitwise OR
                Output = A | B;
            end
            3'b100: begin // Bitwise XOR
                Output = A ^ B;
            end
            3'b101: begin // Bitwise NOT on A
                Output = ~A;
            end
            3'b110: begin // Logical Shift Left
                Output = A << 1;
                c = A[3]; // El bit que sale por la izquierda se va al carry
            end
            3'b111: begin // Logical Shift Right
                Output = A >> 1;
            end
            default: begin
                Output = 4'b0000;
            end
        endcase

        // Bandera de Zero
        if (Output == 4'b0000)
            z = 1'b1;
        else
            z = 1'b0;

        // Bandera de Negative (MSB del resultado)
        n = Output[3];
    end

endmodule
