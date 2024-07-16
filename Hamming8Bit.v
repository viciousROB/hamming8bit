`timescale 1ns / 1ps

module hamming_encoder(
    input wire [7:0] data_in, // 8-bit input data
    output wire [11:0] data_out // 12-bit Hamming code output
);

    //initialize parity bits
    wire p1, p2, p4, p8;

    // Calculate parity bits using XOR
    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3] ^ data_in[4] ^ data_in[6];
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3] ^ data_in[5] ^ data_in[6];
    assign p4 = data_in[1] ^ data_in[2] ^ data_in[3] ^ data_in[7];
    assign p8 = data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[7];

    // Combine parity and data bits into Hamming code
    assign data_out = {data_in[7], data_in[6], data_in[5], data_in[4], p8, data_in[3], data_in[2], data_in[1], p4, data_in[0], p2, p1};

endmodule



module hamming_decoder (
    input wire [11:0] data_in, // 12-bit Hamming code input
    output wire [7:0] data_out, // 8-bit corrected data output
    output wire error // Error detected
);

    wire p1, p2, p4, p8;
    wire s1, s2, s4, s8;
    wire [3:0] syndrome;
    reg [11:0] corrected_data;

    // Extract parity bits
    assign p1 = data_in[0];
    assign p2 = data_in[1];
    assign p4 = data_in[3];
    assign p8 = data_in[7];

    // Calculate syndrome bits
    assign s1 = data_in[0] ^ data_in[2] ^ data_in[4] ^ data_in[6] ^ data_in[8] ^ data_in[10];
    assign s2 = data_in[1] ^ data_in[2] ^ data_in[5] ^ data_in[6] ^ data_in[9] ^ data_in[10];
    assign s4 = data_in[3] ^ data_in[4] ^ data_in[5] ^ data_in[6] ^ data_in[11];
    assign s8 = data_in[7] ^ data_in[8] ^ data_in[9] ^ data_in[10] ^ data_in[11];
    
    //make syndrome array of bits
    assign syndrome = {s8, s4, s2, s1};

    always @(*) begin
        corrected_data = data_in;

        // If syndrome is nonzero, correct error
        if (syndrome != 4'b0000) begin
            corrected_data[syndrome-1] = ~corrected_data[syndrome-1];
        end
    end

    // Extract corrected data bits
    assign data_out = {corrected_data[11], corrected_data[10], corrected_data[9], corrected_data[8], corrected_data[6], corrected_data[5], corrected_data[4], corrected_data[2]};
    assign error = (syndrome != 4'b0000);

endmodule
