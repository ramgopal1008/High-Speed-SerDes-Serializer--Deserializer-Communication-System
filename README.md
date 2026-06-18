# High-Speed-SerDes-Serializer--Deserializer-Communication-System
This repository contains a synthesizable Verilog implementation of an 8-bit Serializer-Deserializer (SerDes) system. The design efficiently converts parallel data into a serial stream for single-wire transmission and reconstructs it back into 8-bit parallel data at the receiver end.

The project features a dedicated baud rate generator, allowing flexible control over the transmission frequency relative to the main system clock.

Key Architecture Components
Baud Rate Generator (baud_gen): Derives a steady operational bit-clock (bit_clk) from the main input clock based on configurable parameters.

Serializer (serializer): A loadable shift register that captures 8-bit parallel data on a tx_valid command and sequentially transmits it over a single wire, starting with the Most Significant Bit (MSB).

Deserializer (deserializer): Implements a serial-in, parallel-out shifting mechanism that gathers incoming serial bits and asserts a ready flag once a complete byte is reconstructed.

Functional Verification
The design was verified through comprehensive functional simulation in ModelSim. The testbench drives back-to-back 8-bit data packets (such as 0xA5 and 0x3C) to validate proper handshaking flags (tx_done and rx_ready), data integrity over the serial link (serial_wire), and the shifting mechanisms under the active receiver enable window.

Synthesis & Timing Analysis
The RTL was synthesized using a commercial-grade 130nm standard cell library (SkyWater 130nm PDK) to verify hardware mapping and timing feasibility:

Max Operating Frequency: 415.6 MHz (Critical Path Delay: 2.406 ns)

Setup Slack: +6.940 ns (Fully met)

Total Chip Area: 3388.61 µm²
