`include "alu_inf.svh"
`include "mem_inf.svh"
`include "mem.svh"
`include "alu.svh"

module top #(
  parameter ADDR_WIDTH = 2,
  parameter DATA_WIDTH = 8
)(
  input  logic clk,
  input  logic reset,
  input  logic [i_inf.DATA_WIDTH] write_buff;
  input  logic [i_inf.addr] addr_write;
  output logic [2*DATA_WIDTH-1:0] res_out
);

mem_inf #(.ADDR_WIDTH(ADDR_WIDTH), .DATA_WIDTH(DATA_WIDTH)) m_if (clk, reset);
  alu_inf #(.DATA_WIDTH(DATA_WIDTH))                          a_if (clk, reset);


mem mem_inst (m_if.DUT);
alu alu_inst (a_if.DUT);

    typedef enum logic [3:0] {IDLE,RD_A,RD_B,RD_OPER,RD_EXEC} RD_STATE;



    always_ff@(posedge clk , posedge reset) begin
        if(reset) begin
            RD_STATE<= IDLE;
            res_out<=0;
             m_if.addr   <= '0;     
            m_if.enable <= 1'b0;   
            m_if.rd_wr  <= 1'b0;
            a_if.A<='0;
            a_if.B<='0;
            a_if.oper<='0;
            a_if.execute<=1'b0;
        end
        
        case (RD_STATE)

        IDLE: if(mem_inf.enable&&mem_inf.rd_wr)
        m_if.addr<=2'd0; 
        RD_STATE<=RD_A;

        RD_A: if(mem_inf.enable&&mem_inf.rd_wr) bgein
        a_if.A<= m_if.rd_data; // get the value in addr 0
        m_if.addr<=2'd1; 
        RD_STATE<=RD_B;
        else if(mem_inf.rd_wr==0) RD_STATE<=IDLE;

         RD_B: if(mem_inf.enable&&mem_inf.rd_wr) bgein
        a_if.B<= m_if.rd_data;// get the value in addr 1
        m_if.addr<=2'd2; 
        RD_STATE<=RD_OPER;
        else if(mem_inf.rd_wr==0) RD_STATE<=IDLE;

         RD_OPER: if(mem_inf.enable) bgein
        a_if.oper<= m_if.rd_data[2:0]; //get the value in addr 2
        m_if.addr<=2'd3; 
        RD_STATE<=RD_B
        else if(mem_inf.rd_wr==0) RD_STATE<=IDLE;

        RD_EXEC: if(mem_inf.enable) bgein
        m_if.addr<=2'd0; 
        a_if.execute<= m_if.rd_data[0]; //get the value in addr 3
        RD_STATE<=RD_A
         
        
        else if(mem_inf.rd_wr==0) RD_STATE<=IDLE;
            
        endcase
        
    end
    assign res_out= a_if.res_out;
endmodule