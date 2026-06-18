module baud_gen #(
parameter FREQ_HZ = 100_000_000,
parameter BAUD    = 50_000_000
)
(
input clk,
input rst,
output reg bit_clk // to create internal clock for maintaining the desired frequency
);

localparam DIV = FREQ_HZ/(2*BAUD);  //bit clk generating formula

integer count;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        count <= 0;
        bit_clk <= 0;
    end
    else
    begin
        if(count == DIV-1)
        begin
            bit_clk <= ~bit_clk; // clock divides by 2;
            count <= 0;
        end
        else
            count <= count + 1;
    end
end

endmodule
