module seven_seg_mux (
    input wire clk,
    input wire rst,
    input wire refresh_tick,
    input wire [1:0] current_state,
    input wire [1:0] sw_state,
    input wire [3:0] sec_units,
    input wire [2:0] sec_tens,
    input wire [3:0] min_units,
    input wire [2:0] min_tens,
    input wire [3:0] hour_units,
    input wire [1:0] hour_tens,
    input wire [3:0] sw_sec_units,
    input wire [2:0] sw_sec_tens,
    input wire [3:0] sw_min_units,
    input wire [2:0] sw_min_tens,
    output reg [5:0] anode,
    output reg [6:0] seg
);

    wire [2:0] digit_select;
    reg [4:0] current_nibble;
    reg [2:0] digit_counter;

    always @(posedge clk) begin
        if (rst) begin
            digit_counter <= 3'd0;
        end else if (refresh_tick) begin
            if (digit_counter == 3'd5)
                digit_counter <= 3'd0;
            else
                digit_counter <= digit_counter + 3'd1;
        end
    end

    assign digit_select = (rst) ? 3'd0 : digit_counter;

    always @(*) begin
        anode = 6'b111111;
        if (!rst) begin
            anode[digit_select] = 1'b0;
        end
        current_nibble = 5'd0;
        
        case(current_state)
            2'b00: begin
                case(digit_select)
                    3'd0: current_nibble = {1'b0, sec_units};
                    3'd1: current_nibble = {2'b00, sec_tens};
                    3'd2: current_nibble = {1'b0, min_units};
                    3'd3: current_nibble = {2'b00, min_tens};
                    3'd4: current_nibble = {1'b0, hour_units};
                    3'd5: current_nibble = {3'b00, hour_tens};
                endcase
            end
            
            2'b01: begin
                case(sw_state)
                    2'b00: begin
                        current_nibble = 5'd0;
                    end
                    2'b01, 2'b10: begin
                        case(digit_select)
                            3'd0: current_nibble = {1'b0, sw_sec_units};
                            3'd1: current_nibble = {2'b00, sw_sec_tens};
                            3'd2: current_nibble = {1'b0, sw_min_units};
                            3'd3: current_nibble = {2'b00, sw_min_tens};
                            3'd4: current_nibble = 5'd0;
                            3'd5: current_nibble = 5'd0;
                        endcase
                    end
                    default: begin
                        current_nibble = 5'd0;
                    end
                endcase
            end

            2'b10: begin
                case(digit_select)
                    3'd0: current_nibble = 5'd16;
                    3'd1: current_nibble = 5'd14;
                    3'd2: current_nibble = 5'd10;
                    3'd3: current_nibble = 5'd14;
                    3'd4: current_nibble = 5'd13;
                    3'd5: current_nibble = 5'd14;
                endcase
            end

            2'b11: begin
                case(digit_select)
                    3'd0: current_nibble = 5'd15;
                    3'd1: current_nibble = 5'd13;
                    3'd2: current_nibble = 5'd16;
                    3'd3: current_nibble = 5'd15;
                    3'd4: current_nibble = 5'd12;
                    3'd5: current_nibble = 5'd11;
                endcase
            end
        endcase
    end

    always @(*) begin
        case(current_nibble)
            5'd0:  seg = 7'b1000000;
            5'd1:  seg = 7'b1111001;
            5'd2:  seg = 7'b0100100;
            5'd3:  seg = 7'b0110000;
            5'd4:  seg = 7'b0011001;
            5'd5:  seg = 7'b0010010;
            5'd6:  seg = 7'b0000010;
            5'd7:  seg = 7'b1111000;
            5'd8:  seg = 7'b0000000;
            5'd9:  seg = 7'b0010000;
            5'd10: seg = 7'b0101111; 
            5'd11: seg = 7'b0010010; 
            5'd12: seg = 7'b0000110; 
            5'd13: seg = 7'b1000111; 
            5'd14: seg = 7'b0001000; 
            5'd15: seg = 7'b0001100; 
            5'd16: seg = 7'b1111111; 
            default: seg = 7'b1111111;
        endcase
    end

endmodule
