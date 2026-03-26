`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2026 15:32:40
// Design Name: 
// Module Name: tb_fir
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


`timescale 1ns / 1ps

module testbench_fir();

    reg clock, reset;
    reg signed [15:0] data_sin;   // FIX: make reg + 16-bit
    wire signed [15:0] Data_Out;

    FIR_filter UUT (
        .clk(clock),
        .rst(reset),
        .x_in(data_sin),
        .y_out(Data_Out)
    );

    // Clock
    always #5 clock = ~clock;

    integer i;
    real temp;

    initial begin
        clock = 0;
        reset = 1;
        data_sin = 0;

        #20 reset = 0;

        // Generate sinusoidal input
        for (i = 0; i < 200; i = i + 1) begin
            temp = 1000*$sin(2*3.14159*0.05*i);
            data_sin = temp;
            #10;
        end

        #100 $finish;
    end

    // Monitor
    always @(posedge clock) begin
        $display("Time=%0t | Input=%d | Output=%d", 
                  $time, data_sin, Data_Out);
    end

endmodule
