module clock_divider (
    input wire clk,          
    input wire rst,          
    output reg tick_1Hz,     
    output reg tick_1KHz     
);

    reg [7:0] count_1hz;    
    reg [3:0] count_1khz;   

    always @(posedge clk) begin
        if (rst) begin
            count_1khz <= 4'd0;
            tick_1KHz  <= 1'b0;
        end else begin
            if (count_1khz == 4'd4) begin 
                count_1khz <= 4'd0;
                tick_1KHz  <= 1'b1;  
            end else begin
                count_1khz <= count_1khz + 4'd1;
                tick_1KHz  <= 1'b0;   
            end
        end
    end

    always @(posedge clk) begin
        if (rst) begin
            count_1hz <= 8'd0;
            tick_1Hz  <= 1'b0;
        end else begin
            if (count_1hz == 8'd99) begin 
                count_1hz <= 8'd0;
                tick_1Hz  <= 1'b1;   
            end else begin
                count_1hz <= count_1hz + 8'd1;
                tick_1Hz  <= 1'b0;    
            end
        end
    end

endmodule
