interface alu_inf #(parameter DATA_WIDTH=8)( input clk, reset);
logic [DATA_WIDTH-1:0] A;
logic [DATA_WIDTH-1:0] B;
logic [2:0] oper;
logic execute;
logic [2*DATA_WIDTH-1:0] res_out;

modport DUT(input A,B,oper,exec, clk, reset ,output res_out);

    
endinterface