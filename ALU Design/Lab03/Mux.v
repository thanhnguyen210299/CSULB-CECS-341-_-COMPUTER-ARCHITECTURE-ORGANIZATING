`timescale 1ns / 1ps

module MUX21(
    D1, D2, S, Y
    );
    
    input         S; // select line
    input  [31:0] D1;
    input  [31:0] D2;
    
    output [31:0] Y;
    
    assign Y = (!S) ? D1 : D2;
endmodule