`timescale 1ns / 1ps

module tb_serdes_top;

    // Inputs to the design under test (DUT)
    reg clk;
    reg rst;
    reg tx_valid;
    reg [7:0] tx_data;
    reg rx_enable;

    // Outputs from the design under test (DUT)
    wire tx_done;
    wire [7:0] rx_data;
    wire rx_ready;
    wire bit_clk;
    wire serial_wire;

    // Instantiation of the top-level SerDes module
    serdes_top uut (
        .clk(clk),
        .rst(rst),
        .tx_valid(tx_valid),
        .tx_data(tx_data),
        .rx_enable(rx_enable),
        .tx_done(tx_done),
        .rx_data(rx_data),
        .rx_ready(rx_ready),
        .bit_clk(bit_clk),
        .serial_wire(serial_wire)
    );

    // Clock generation logic (100 MHz reference clock)
    always begin
        #5 clk = ~clk;
    end

    // Main stimulus block
    initial begin
        // Initialize all input signals
        clk = 0;
        rst = 1;
        tx_valid = 0;
        tx_data = 8'h00;
        rx_enable = 0;

        // Hold reset for a few clock cycles to stabilize the system
        #20;
        rst = 0;
        #20;

        // --- Test Case 1: Transmitting and Receiving 0xA5 ---
        // Enable the receiver to catch incoming serial data
        rx_enable = 1; 
        
        // Load the parallel data and assert valid signal
        tx_data = 8'hA5; 
        tx_valid = 1;
        
        // Wait for one bit clock period to let the data load properly
        @(posedge bit_clk);
        #1; 
        tx_valid = 0; // De-assert valid after loading is completed

        // Wait until the transmitter finishes sending all bits
        @(posedge tx_done);
        
        // Give it an extra bit clock cycle to finalize the flags
        @(posedge bit_clk);
        #1;

        // --- Test Case 2: Transmitting and Receiving 0x3C ---
        tx_data = 8'h3C;
        tx_valid = 1;
        
        @(posedge bit_clk);
        #1;
        tx_valid = 0;

        // Wait for the transmission to wrap up completely
        @(posedge tx_done);
        @(posedge bit_clk);
        #1;

        // Disable receiver and finish simulation
        rx_enable = 0;
        #100;
        $finish;
    end

    // Monitor block to track the values in the simulation console
    initial begin
        $monitor("Time = %0t | rst = %b | tx_data = %h | tx_done = %b | serial = %b | rx_data = %h | rx_ready = %b", 
                 $time, rst, tx_data, tx_done, serial_wire, rx_data, rx_ready);
    end

endmodule
