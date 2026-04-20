`timescale 1ns / 1ps

module and_gate(
    input  wire membranch,
    input  wire zero,
    output wire PCSrc
);
    assign PCSrc = membranch & zero;
endmodule
