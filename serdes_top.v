module serdes_top(

input clk,
input rst,

input tx_valid,
input [7:0] tx_data,
input rx_enable,

output tx_done,
output [7:0] rx_data,
output rx_ready,
output  bit_clk,
output serial_wire
);



// instantiation of baud generation block
baud_gen bg(
.clk(clk),
.rst(rst),
.bit_clk(bit_clk)
);

//instantiation of serializer block
serializer tx(
.bit_clk(bit_clk),
.rst(rst),
.load(tx_valid),
.pdata(tx_data),
.sdata(serial_wire),
.done(tx_done)
);

//instantiation of deserializer block
deserializer rx(
.bit_clk(bit_clk),
.rst(rst),
.tx_done(tx_done),
.enable(rx_enable),
.sdata(serial_wire),
.pdata(rx_data),
.ready(rx_ready)
);

endmodule
