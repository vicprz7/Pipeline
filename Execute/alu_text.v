module alu_test;

    reg  [31:0] a;
    reg  [31:0] b;
    reg  [2:0]  control;
    wire [31:0] result;
    wire        zero;

    alu uut (
        .a(a),
        .b(b),
        .control(control),
        .result(result),
        .zero(zero)
    );

    initial begin
        a = 32'd10;
        b = 32'd7;

        $monitor("time=%0t control=%b a=%0d b=%0d result=%0d zero=%b",
                 $time, control, a, b, result, zero);

        control = 3'b010; #10; // add = 17
        control = 3'b110; #10; // sub = 3
        control = 3'b001; #10; // or
        control = 3'b000; #10; // and
        control = 3'b111; #10; // slt = 0

        $finish;
    end

endmodule
