module synchronizer(
    input wire asyn_in,
    input wire rst,
    input wire master_clk,
    output reg sync_out
);
    reg q1;
    always @(posedge master_clk)
    begin
        if (rst) begin
            q1<=0;
            sync_out<=0;
        end
        else begin
            q1<=asyn_in;
            sync_out<=q1;
        end
    end
endmodule

