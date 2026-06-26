module time_counters (
    input wire clk,
    input wire rst,
    input wire tick_1Hz,
    input wire [1:0] sw_state,
    output reg [3:0] sec_units,
    output reg [2:0] sec_tens,
    output reg [3:0] min_units,
    output reg [2:0] min_tens,
    output reg [3:0] hour_units,
    output reg [1:0] hour_tens,
    output reg [3:0] sw_sec_units,
    output reg [2:0] sw_sec_tens,
    output reg [3:0] sw_min_units,
    output reg [2:0] sw_min_tens
);

    localparam SW_RESET = 2'b00;
    localparam SW_RUN   = 2'b01;
    localparam SW_STOP  = 2'b10;


    always @(posedge clk)
    begin
        if (rst) begin
            sec_units<=0;
            sec_tens<=0;
            min_units<=0;
            min_tens<=0;
            hour_units<=0;
            hour_tens<=0;
        end
        else if (tick_1Hz) begin
            if (sec_units==4'd9) begin
                sec_units<=0;
                if (sec_tens==3'd5) begin
                    sec_tens<=0;
                    if (min_units==4'd9) begin
                        min_units<=0;
                        if (min_tens==3'd5) begin
                            min_tens<=0;
                            if ((hour_tens<2) && hour_units==4'd9) begin
                                hour_units<=0;
                                hour_tens<=hour_tens+1;
                            end
                            else if (hour_tens==2'd2 && hour_units==4'd3) begin
                                hour_tens<=0;
                                hour_units<=0;
                            end
                            else hour_units<=hour_units+1;
                        end
                        else min_tens<=min_tens+1;
                    end
                    else min_units<=min_units+1;
                end
                else sec_tens<=sec_tens+1;
            end
            else sec_units<=sec_units+1;
        end
    end


    always @(posedge clk)
    begin
        if (rst || (sw_state == SW_RESET)) begin
            sw_sec_units <= 4'd0;
            sw_sec_tens  <= 3'd0;
            sw_min_units <= 4'd0;
            sw_min_tens  <= 3'd0;
        end else if (sw_state == SW_RUN && tick_1Hz) begin
            if (sw_sec_units == 4'd9) begin
                sw_sec_units <= 4'd0;
                if (sw_sec_tens == 3'd5) begin
                    sw_sec_tens <= 3'd0;
                    if (sw_min_units == 4'd9) begin
                        sw_min_units <= 4'd0;
                        if (sw_min_tens == 3'd5) begin
                            sw_min_tens <= 3'd0;
                        end else begin
                            sw_min_tens <= sw_min_tens + 3'd1;
                        end
                    end else begin
                        sw_min_units <= sw_min_units + 4'd1;
                    end
                end else begin
                    sw_sec_tens <= sw_sec_tens + 3'd1;
                end
            end else begin
                sw_sec_units <= sw_sec_units + 4'd1;
            end
        end 
    end
endmodule
