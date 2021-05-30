`timescale 1ns / 1ps

`include "ALU.v"
`include "FlipFlop.v"
`include "Instr_mem.v"
`include "RegFile.v"
`include "Imm_Gen.v"
`include "Mux.v"
`include "Data_mem.v"

module data_path #(
    parameter PC_W       = 8,  // Program Counter
    parameter INS_W      = 32, // Instruction Width
    parameter RF_ADDRESS = 5,  // Register File Address
    parameter DATA_W     = 32, // Data Write Data
    parameter DM_ADDRES  = 9,  // Data Memory Address
    parameter ALU_CC_W   = 4   // ALU Control Code Width
    )(
    input                   clk,       // CLK in Datapath Figure
    input                   reset,     // Reset in Datapath Figure
    input                   reg_write, // RegWrite in Datapath Figure
    input                   mem2reg,   // MemtoReg in Datapath Figure
    input                   alu_src,   // ALUSrc in Datapath Figure
    input                   mem_write, // MemWrite in Datapath Figure
    input                   mem_read,  // MemRead in Datapath Figure
    input  [ALU_CC_W - 1:0] alu_cc,    // ALUCC in Datapath Figure
    output            [6:0] opcode,    // opcode in Datapath Figure
    output            [6:0] funct7,    // Funct7 in Datapath Figure
    output            [2:0] funct3,    // Funct3 in Datapath Figure
    output   [DATA_W - 1:0] alu_result // Datapath_Result in Datapath Figure
    );
    
    // Define Datapath Wires
    wire  [7:0] PC;          
    wire  [7:0] PCPlus4;     
    wire [31:0] Instruction;
    wire [31:0] Reg1;
    wire [31:0] Reg2;
    wire [31:0] ExtImm;
    wire [31:0] WriteBack_Data;
    wire [31:0] SrcB;
    wire [31:0] ALU_Result;
    wire [31:0] DataMem_read;
    wire        Carry_out, overflow, zero;
    
    // Assign relationships
    // Controller
    assign opcode = Instruction[6:0];
    assign funct3 = Instruction[14:12];
    assign funct7 = Instruction[31:25];
    
    // HA
    assign PCPlus4 = PC + 8'd4;
    
    // Flip FLop
    FlipFlop flip_flop(
        // inputs
        .clk(clk),     // 1 bit
        .reset(reset), // 1 bit
        .d(PCPlus4),   // 8 bits
        // output 
        .q(PC)         // 8 bits
        );
    
    // Instruction Memory
    InstMem instruction_memory(
        // input
        .addr(PC),                // 8 bits
        // output
        .instruction(Instruction) // 32 bits
    );
    
    // Register File
    RegFile register_file(
        // inputs
        .clk(clk),                        // 1 bit
        .reset(reset),                    // 1 bit
        .rg_wrt_en(reg_write),            // 1 bit
        .rg_wrt_addr(Instruction[11:7]),  // 5 bits
        .rg_rd_addr1(Instruction[19:15]), // 5 bits
        .rg_rd_addr2(Instruction[24:20]), // 5 bits
        .rg_wrt_data(WriteBack_Data),     // 32 bits
        // outputs
        .rg_rd_data1(Reg1),               // 32 bits
        .rg_rd_data2(Reg2)                // 32 bits
        );

    // Mux for ALU
    MUX21 mux_src(
        // inputs
        .D1(Reg2),   // 32 bits
        .D2(ExtImm), // 32 bits
        .S(alu_src), // 1 bit
        // output
        .Y(SrcB)     // 32 bits
        );
    
    // Sign Extend
    Imm_Gen immediate_generator(
        // input
        .InstCode(Instruction), // 32 bits
        // output
        .ImmOut(ExtImm)         // 32 bits
        );
    
    // ALU
    alu_32 ALU(
        // inputs
        .A_in(Reg1),           // 32 bits
        .B_in(SrcB),           // 32 bits
        .ALU_Sel(alu_cc),      // 4 bits
        // outputs
        .ALU_Out(ALU_Result),  // 32 bits
        .Carry_Out(Carry_out), // 1 bit
        .Zero(zero),           // 1 bit
        .Overflow(overflow)    // 1 bit
        );
        
     assign alu_result = ALU_Result;
    
    // Mux for Data memory
    MUX21 mux_memory_to_register(
        // inputs
        .D1(ALU_Result),   // 32 bits
        .D2(DataMem_read), // 32 bits
        .S(mem2reg),       // 1 bit
        // output
        .Y(WriteBack_Data) // 32 bits
        );
    
    // Data Memory
    DataMem data_memory(
        // inputs
        .MemRead(mem_read),      // 1 bit
        .MemWrite(mem_write),    // 1 bit
        .addr(ALU_Result[8:0]),  // 9 bits
        .write_data(Reg2),       // 32 bits
        // output
        .read_data(DataMem_read) // 32 bits
        );
    
endmodule