`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2020 11:10:47 PM
// Design Name: 
// Module Name: tb_FF
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


module tb_FF();
    // Inputs
    reg [7:0] d;
    reg clk;
    reg reset;
    
    // Output
    wire [7:0] q;
    
    // Instantiate the module want to test
    FlipFlop dut(clk, reset, d, q);
    
    // Generate Clock
    initial
        begin
        clk = 1;
        forever #20 clk = ~clk;
        end 
    
    // Testcase
    initial 
        begin 
        // Case 1 when reset is set
        reset = 1; 
        d = $random;
        #100;
        
        // Case 2 when reset is not set and d is not change 
        reset = 0; 
        #200;
        
        // Case 3 when reset is not set and d is change
        d = $random;
        #200;
        
        // Case 4 when reset is set again and d is not change
        reset = 1;
        #100;
        
        // Case 5 when reset is set and d is change
        d = $random;
        #200;
        
        // Case 6 when reset is not set again
        reset = 0;
        end
endmodule
