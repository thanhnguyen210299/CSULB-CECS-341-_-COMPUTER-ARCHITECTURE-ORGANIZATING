`timescale 1ns / 1ps

module FlipFlop(
    clk, reset, // 1 bit each
    d,          // 8 bit
    q           // 8 bit
    );
    
    // Define the input and output signals
    input            clk;
    input            reset;
    input      [7:0] d;
    output reg [7:0] q;
    
    // Define the D Flip Flop modules' behaviour
    always @(posedge clk, posedge reset)
        begin
        if (reset == 1'b1)
            q <= 0;
        else
            q <= d;
        end
endmodule