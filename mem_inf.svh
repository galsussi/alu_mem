interface mem_inf #(parameter ADDR_WIDTH=2, parameter DATA_WIDTH =8 )(input logic clk,reset);
logic enable;
logic rd_wr;
logic [DATA_WIDTH-1:0] wr_data;
logic  [DATA_WIDTH-1:0] rd_data;
logic  [ADDR_WIDTH-1:0] addr;

logic [DATA_WIDTH-1:0] A;
    logic [DATA_WIDTH-1:0] B;
    logic [2:0] oper;
    logic exec;
modport DUT (input clk, reset,enable,rd_wr,wr_data,addr, output rd_data ,A,B,oper,exec);
    
endinterface