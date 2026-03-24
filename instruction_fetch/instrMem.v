module instrMem(
    input  wire        clk,   
    input  wire        rst,   
    input  wire [31:0] addr,
    output reg  [31:0] data
);

    reg [31:0] mem [0:9];

    initial begin
        mem[0] = 32'hA00000AA; // address 0
        mem[1] = 32'h10000011; // address 4
        mem[2] = 32'h20000022; // address 8
        mem[3] = 32'h30000033; // address 12
        mem[4] = 32'h40000044; // address 16
        mem[5] = 32'h50000055; // address 20
        mem[6] = 32'h60000066; // address 24
        mem[7] = 32'h70000077; // address 28
        mem[8] = 32'h80000088; // address 32
        mem[9] = 32'h90000099; // address 36
    end

    always @(*) begin
        case (addr)
            32'd0  : data = mem[0];
            32'd4  : data = mem[1];
            32'd8  : data = mem[2];
            32'd12 : data = mem[3];
            32'd16 : data = mem[4];
            32'd20 : data = mem[5];
            32'd24 : data = mem[6];
            32'd28 : data = mem[7];
            32'd32 : data = mem[8];
            32'd36 : data = mem[9];
            default: data = 32'h00000000;
        endcase
    end
