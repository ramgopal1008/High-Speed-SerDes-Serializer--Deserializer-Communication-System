module deserializer(
input bit_clk,
input rst,
input tx_done,
input enable,
input sdata,
output reg [7:0] pdata,
output reg ready
);

reg [3:0] count;

always @(posedge bit_clk or posedge rst)
begin
    if(rst)
    begin
        pdata <= 0; //resets the parallel data registser
        count <= 0;
        ready <= 0;
    end

    else if(enable)
    begin
        pdata <= {pdata[6:0],sdata}; // shifting operation using the concatenation operation 
			count<=(count==9)?0:count+1; 
		if(tx_done)
			ready<=1; // the receiver gets ready after the transmission of data
		else
			ready<=0;
        
    end
end

endmodule
