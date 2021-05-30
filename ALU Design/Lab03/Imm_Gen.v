`timescale 1ns / 1ps

module Imm_Gen(
    InstCode,
    ImmOut
    );
    
    input      [31:0] InstCode;
    output reg [31:0] ImmOut;
    
    always @(InstCode)
        begin
        case (InstCode[6:0])
            7'b0000011: /*I-type load*/
                ImmOut = {InstCode[31] ? {20{1'b1}} : 20'b0, InstCode[31:20]};
            7'b0010011: /*I-type addi*/
                ImmOut = {InstCode[31] ? {20{1'b1}} : 20'b0, InstCode[31:20]};
            7'b0100011: /*S-type store*/
                ImmOut = {InstCode[31] ? {20{1'b1}} : 20'b0, InstCode[31:25], InstCode[11:7]};
            default:
                ImmOut = {32'b0};
        endcase
        end
endmodule