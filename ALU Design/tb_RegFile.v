`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/29/2020 06:57:21 PM
// Design Name: 
// Module Name: tb_RegFile
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


module tb_RegFile();
    // Inputs
    reg clk;
    reg reset;
    reg rg_wrt_en;
    reg [4:0] rg_wrt_addr;
    reg [4:0] rg_rd_addr1;
    reg [4:0] rg_rd_addr2;
    reg [31:0] rg_wrt_data;
    
    // Output
    wire [31:0] rg_rd_data1;
    wire [31:0] rg_rd_data2;
    
    // Instantiate the module want to test
    RegFile dut(clk, reset, rg_wrt_en, rg_wrt_addr, rg_rd_addr1, rg_rd_addr2, rg_wrt_data, rg_rd_data1, rg_rd_data2);
    
    // Generate Clock
    initial
        begin
        clk = 1;
        forever #20 clk = ~clk;
        end 
    
    // Testcase for writing
    initial
        begin
        // Case 1 when reset is on and write flag is set
        reset = 1;
        rg_wrt_en = 1;
        rg_wrt_addr = 5'b10010;
        rg_wrt_data = 32'h45;
        #100;
        
        // Case 2 when reset is off and write flag is set
        reset = 0;
        #100
        
        rg_wrt_addr = 5'b00101;
        rg_wrt_data = 32'h89;
        #100;
        
        // Case 3 when reset is off and write flag is not set
        rg_wrt_en = 0;
        #100;
        
        // Case 4 test asynchronous reset
        #10;
        reset = 1;
        #100;
        
        // Case 5 test writing into register[0]
        reset = 0;
        rg_wrt_en = 1;
        rg_wrt_addr = 5'b00000;
        rg_wrt_data = 32'h32;
        #100;
        
        // Case 6 test reading after reset
        rg_wrt_addr = 5'b10010;
        rg_wrt_data = 32'h7b;
        end 
        
    // Testcase for reading
    initial
        begin
        rg_rd_addr1 = 5'b10010;
        rg_rd_addr2 = 5'b00101;
        #600;
        
        rg_rd_addr2 = 5'b00000;
        end 
endmodule
