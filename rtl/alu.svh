module alu(
    alu_inf.DUT i_inf 
);
    localparam ERROR_CODE = 16'hDEAD;
    logic [2*i_inf.DATA_WIDTH-1:0] result;
    always@(posedge i_inf.clk, posedge i_inf.reset) begin
        if(i_inf.reset) begin 
            result<= '0;
        end
        else if(i_inf.execute) begin
            case (i_inf.oper)

            3'd0: result<= '0;
            3'd1: result<= i_inf.A+i_inf.B;
            3'd2: result<= i_inf.A-i_inf.B;
            3'd3: result<= i_inf.A*i_inf.B;
            3'd4: result <= (i_inf.B=='0)? ERROR_CODE: (i_inf.A/i_inf.B);
            

            default: result <= result; 
            
            endcase


    end
    end 
    assign i_inf.res_out= result;

endmodule