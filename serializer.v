module serializer(
input bit_clk,
input rst,
input load,
input [7:0] pdata,
output reg sdata,
output reg done
);

reg [7:0] shift_reg;
reg [3:0] count;

always @(posedge bit_clk or posedge rst)
begin
    if(rst)
    begin
		  sdata<=0; // resets the serial data register
        shift_reg <= 0;
        count <= 0;
        done <= 0;
    end

    else if(load)
    begin
        shift_reg <= pdata;
        count <= 9;
        done <= 0;
    end

    else if(count != 0)
    begin
        sdata <= shift_reg[7]; // transmits the MSB of the parallel data
        shift_reg <= shift_reg << 1; // left shift operation 
        count <= count - 1;

        if(count == 1)
            done <= 1;
    end
    else
        done <= 0;

end

endmodule

