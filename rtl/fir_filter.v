`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2026 15:27:41
// Design Name: 
// Module Name: fir_filter
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


module fir_filter (
    input clk,
    input rst,
    input signed [15:0] x_in,
    output reg signed [15:0] y_out
);

    parameter N = 16;

    // Q1.15 coefficients (scaled integers)
    reg signed [15:0] coeffs [0:N-1];

    initial begin
        coeffs[0]  = 16'sd0;
        coeffs[1]  = 16'sd183;
        coeffs[2]  = 16'sd259;
        coeffs[3]  = -16'sd541;
        coeffs[4]  = -16'sd1665;
        coeffs[5]  = 16'sd0;
        coeffs[6]  = 16'sd6027;
        coeffs[7]  = 16'sd12139;
        coeffs[8]  = 16'sd12139;
        coeffs[9]  = 16'sd6027;
        coeffs[10] = 16'sd0;
        coeffs[11] = -16'sd1665;
        coeffs[12] = -16'sd541;
        coeffs[13] = 16'sd259;
        coeffs[14] = 16'sd183;
        coeffs[15] = 16'sd0;
    end

    // Shift register (delay line)
    reg signed [15:0] shift_reg [0:N-1];

    integer i;
    reg signed [31:0] acc;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < N; i = i + 1)
                shift_reg[i] <= 0;
            y_out <= 0;
        end else begin
            // Shift input samples
            shift_reg[0] <= x_in;
            for (i = 1; i < N; i = i + 1)
                shift_reg[i] <= shift_reg[i-1];

            // Multiply-Accumulate
            acc = 0;
            for (i = 0; i < N; i = i + 1)
                acc = acc + shift_reg[i] * coeffs[i];

            // Scale back (Q1.15)
            y_out <= acc >>> 15;
        end
    end

endmodule
