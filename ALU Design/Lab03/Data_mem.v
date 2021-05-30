`timescale 1ns / 1ps

module DataMem(
    MemRead,
    MemWrite,
    addr,
    write_data,
    read_data
    );
    
    // Define I/O ports 
    input         MemRead;    // Control signal for memory read
    input         MemWrite;   // Control signal for memory write
    input   [8:0] addr;       // Input Address - 9 LSB bits of the ALU output
    input  [31:0] write_data; // Data that needs to be written into the address
    
    output [31:0] read_data;  // Contents of memory location at Address
    
    // Describe data_mem behaviour
    // Memory Initialization
    reg [31:0] Memory[127:0]; // 128 x 32 memory block
    
    // Memory Write
    always @(posedge MemWrite) // write routine, creates flip-flops, Active high MemWrite
        begin
            Memory[addr] <= write_data; // Word written at location addr
        end
    
    // Memory Read
    assign read_data = (MemRead) ? Memory[addr] : 32'd0;

endmodule