`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2020 04:51:00 PM
// Design Name: 
// Module Name: tb_InstMem
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


module tb_InstMem();
    // Inputs
    reg [7:0] addr;
    
    // Output
    wire [31:0] instruction;
    
    // Instantiate the module want to test
    InstMem dut(addr, instruction);
    
    // Testcase
    initial 
        begin 
        //Case 1
        addr = 32'd12;
        #200;
        
        //Case 2
        addr = 32'd64;
        #200;
        
        //Case 3
        addr = 32'd32;
        #200;
        
        //Case 4
        addr = 32'd40;
        #200;
        
        //Case 5
        addr = 32'd52;
        end
endmodule
