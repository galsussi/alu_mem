`include "alu_inf.svh"
`include "mem_inf.svh"
`include "mem.svh"
`include "alu.svh"

module top(
    input logic clk, reset,output logic [2* mem_inf.DATA_WIDTH-1:0] res_out
);
mem_inf memi_inf(clk, reset);
alu_inf alui_inf(clk,reset);


mem mem_inst(memi_inf.DUT);
alu alu_inst(alui_inf.DUT);

localparam A_REG    = memi_inf.DATA_WIDTH'd0;
localparam B_REG    = memi_inf.DATA_WIDTH'd1;
localparam OP_REG   = memi_inf.DATA_WIDTH'd2;
localparam EXEC_REG   = memi_inf.DATA_WIDTH'd3;

assign alu_inst.A =mem_inst.mem[A_REG];
assign alu_inst.B= mem_inst.mem[B_REG];
assign alu_inst.oper=mem_inst.mem[OP_REG][2:0];
assign alu_inst.execute=mem_inst.mem[EXEC_REG][0];


assign res_out=alu_inst.res_out; /// out of the top 
    
endmodule