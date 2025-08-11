module top(
    input logic clk, reset,output logic [2* mem_inf.DATA_WIDTH-1:0] res_out
);
mem_inf memi_inf(clk, reset);
alu_inf alui_inf(clk,reset);



mem mem_inst(memi_inf.DUT);
alu alu_inst(alui_inf.DUT);


assign alu_inf.A =mem_inf.A;
assign alu_inf.B= mem_inf.B;
assign alu_inf.oper=mem_inf.oper;
assign alu_inf.exec=mem_inf.exec;
assign res_out=alu_inf.res_out; /// out of the top 



    
endmodule