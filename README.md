# Hamming Code Encoder/Decoder

## Overview
This project provides a Verilog implementation of a Hamming Code Encoder and Decoder. The Hamming code is a popular error-detecting and error-correcting code used in digital communication and data storage systems.

## Modules

### Hamming Encoder
The Hamming Encoder module takes an 8-bit input data and outputs a 12-bit Hamming code.

#### Ports
- `input wire [7:0] data_in`: 8-bit input data
- `output wire [11:0] data_out`: 12-bit Hamming code output

#### Functionality
- Calculates parity bits using XOR operations.
- Combines parity and data bits into a 12-bit Hamming code.

### Hamming Decoder
The Hamming Decoder module takes a 12-bit Hamming code and outputs the corrected 8-bit data along with an error detection signal.

#### Ports
- `input wire [11:0] data_in`: 12-bit Hamming code input
- `output wire [7:0] data_out`: 8-bit corrected data output
- `output wire error`: Error detected signal

#### Functionality
- Extracts parity bits.
- Calculates syndrome bits to detect errors.
- Corrects single-bit errors if detected.
- Outputs the corrected 8-bit data.

### Testbench
A testbench is provided to simulate and verify the functionality of the Hamming Encoder and Decoder modules. The testbench runs through all possible 8-bit input values, encodes them, and then adds single-bit errors to test the decoder's error correction capabilities.

### Usage
To use these modules, instantiate them in your top-level Verilog file and connect the inputs and outputs as needed.

### Simulation
To run the simulation, set the runtime to at least 358400ns to see all possible outcomes.
