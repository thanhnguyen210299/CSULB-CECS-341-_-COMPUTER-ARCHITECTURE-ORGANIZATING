`timescale 1ns / 1ps

module RegFile(
    clk, reset, rg_wrt_en, // each 1 bit
    rg_wrt_addr,           // 5 bits
    rg_rd_addr1,           // 5 bits
    rg_rd_addr2,           // 5 bits
    rg_wrt_data,           // 32 bits
    rg_rd_data1,           // 32 bits
    rg_rd_data2            // 32 bits
    );
    
    // Define the input and output signals
    input         clk, reset, rg_wrt_en;
    input   [4:0] rg_wrt_addr;
    input   [4:0] rg_rd_addr1;
    input   [4:0] rg_rd_addr2;
    input  [31:0] rg_wrt_data;
    
    output [31:0] rg_rd_data1;
    output [31:0] rg_rd_data2;
    
    // Define the Register File modules ' behaviour
    // 32x32 bit array of registers
    reg [31:0] register_file [31:0];
    
    integer i;
    
    initial
        begin
        for (i = 0; i < 32; i = i + 1)
            register_file[i] <= 32'd0;
        end

    // writes are enabled on positive edge clock cycles
    always @ (posedge clk || reset)
        begin
        if (reset == 1'b1)
            begin
            for (i = 0; i < 32; i = i + 1)
                register_file[i] = 32'd0;
            end
        else
            begin
            // if write is set
            if (rg_wrt_en == 1'b1 && rg_wrt_addr)
                begin
                register_file[rg_wrt_addr] = rg_wrt_data;
                end
            end
        end
    
    // read
    assign rg_rd_data1 = register_file[rg_rd_addr1];
    assign rg_rd_data2 = register_file[rg_rd_addr2];
    
	
endmodule