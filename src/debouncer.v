module debouncer(
    input clk,
    input rst,
    input tick_1KHz,
    input btn_in,
    output reg btn_out
    );
    reg[3:0] count;
    always @(posedge clk)
    begin
        if (rst) begin
            count<=0;
            btn_out<=0;
        end
        else if (!btn_in) begin
            count<=0;
            btn_out<=0;
        end
        else if(tick_1KHz) begin
            if (count==4'd15) begin
                btn_out<=1;
            end
            else begin
                count<=count+1;
            end
        end
    end
endmodule
