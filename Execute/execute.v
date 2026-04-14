module execute(

        input wire  clk,
        
        input  wire [1:0]  wb_ctl,
        input  wire [2:0]  m_ctl,
        input  wire        regdst,
        input  wire        alusrc,
        input  wire [1:0]  aluop,
    
        // data inputs from ID/EX
        input  wire [31:0] npcout,
        input  wire [31:0] rdata1,
        input  wire [31:0] rdata2,
        input  wire [31:0] s_extendout,
        input  wire [4:0]  instrout_2016,   
        input  wire [4:0]  instrout_1511,   
    
        // outputs from EX/MEM latch
        output wire [1:0]  wb_ctlout,
        output wire        branch,
        output wire        memread,
        output wire        memwrite,
        output wire [31:0] EX_MEM_NPC,
        output wire        zero,
        output wire [31:0] alu_result,
        output wire [31:0] rdata2out,
        output wire [4:0]  five_bit_muxout
    );
    
    wire [31:0] adder_out;
    wire [31:0] b;
    wire [31:0] aluout;
    wire [4:0]  muxout;
    wire [2:0]  control;
    wire        aluzero;
    
    
    adder adder3(
        .add_in1(npcout),
        .add_in2(s_extendout),
        .add_out(adder_out)
    );

    // destination register select
    // regdst=0 => rt (Instr[20:16])
    // regdst=1 => rd (Instr[15:11])
    bottom_mux bottom_mux3(
        .a(instrout_2016),
        .b(instrout_1511),
        .sel(regdst),
        .y(muxout)
    );

    // ALU control uses the REAL funct field from instruction[5:0]
    alu_control alu_control3(
        .funct(s_extendout[5:0]),
        .aluop(aluop),
        .select(control)
    );

    // ALU operand B select
    // alusrc=0 => rdata2
    // alusrc=1 => sign-extended immediate
    top_mux top_mux3(
        .a(rdata2),
        .b(s_extendout),
        .sel(alusrc),
        .y(b)
    );

    alu alu3(
        .a(rdata1),
        .b(b),
        .control(control),
        .result(aluout),
        .zero(aluzero)
    );

    // EX/MEM pipeline register
    ex_mem ex_mem3(
        .clk(clk),
        .ctlwb_out(wb_ctl),
        .ctlm_out(m_ctl),
        .adder_out(adder_out),
        .aluzero(aluzero),
        .aluout(aluout),
        .readdat2(rdata2),
        .muxout(muxout),

        .wb_ctlout(wb_ctlout),
        .branch(branch),
        .memread(memread),
        .memwrite(memwrite),
        .add_result(EX_MEM_NPC),
        .zero(zero),
        .alu_result(alu_result),
        .rdata2out(rdata2out),
        .five_bit_muxout(five_bit_muxout)
    );

    
endmodule
