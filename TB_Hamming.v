`timescale 1ns / 1ps

//Must set simulation runtime to at least 358400ns to see all possible outcomes

module tb_hamming;

    reg [7:0] data_in;
    wire [11:0] encoded_data;
    reg [11:0] encoded_data_with_error;
    wire [7:0] decoded_data;
    wire error;
    integer i, j;

    // Initialize hamming encoder
    hamming_encoder encoder (
        .data_in(data_in),
        .data_out(encoded_data)
    );

    // Initialize hamming decoder
    hamming_decoder decoder (
        .data_in(encoded_data_with_error),
        .data_out(decoded_data),
        .error(error)
    );

    initial begin
        // Run through all possible 8-bit input values
        for (i = 0; i < 256; i = i + 1) begin
            data_in = i;
            #10;
            encoded_data_with_error = encoded_data;
            #10;
            $display("Input: %b, Encoded: %b, Decoded: %b, Error: %b", data_in, encoded_data_with_error, decoded_data, error);

            // Add single-bit errors at all possible positions
            for (j = 0; j < 12; j = j + 1) begin
                encoded_data_with_error = encoded_data;
                encoded_data_with_error[j] = ~encoded_data_with_error[j]; // Add error at bit j
                #10;
                $display("Input: %b, Encoded with error at bit %0d: %b, Decoded: %b, Error: %b", data_in, j, encoded_data_with_error, decoded_data, error);
            end
        end
        $finish;
    end

endmodule
