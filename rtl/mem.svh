`include "mem_inf.svh"

module mem(mem_inf i_inf)
reg [0:i_inf.DATA_WIDTH-1] mem [(2**i_inf.ADDR_WIDTH)-1:0];
reg [i_inf.DATA_WIDTH] read_buff;
integer i;
always @(posedge i_inf.clk , posedge i_inf.reset) begin
    if(i_inf.reset) begin 
        for (i=0;i<2**i_inf.ADDR_WIDTH;i=i+1) begin
		mem[i]<={i_inf.DATA_WIDTH{1'b1}};
    end
    i_inf.rd_data<={i_inf.DATA_WIDTH{1'b1}};
    
end
else if(i_inf.enable&&i_inf.rd_wr==0) begin
    mem[i_inf.addr]<=wr_data;

    end//end write
    else if (i_inf.enable&&i_inf.rd_wr==1) begin
      read_buff<=mem[i_inf.addr];  
    end//read
    
end

);
assign i_inf.rd_data=read_buff;
    
endmodule