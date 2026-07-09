module synchronizer(
    input wire asyn_in,
    input wire rst,
    input wire master_clk,
    output wire sync_out
);
    reg q1;
    reg q2;
    
    always @(posedge master_clk)
    begin
        if (rst) begin
            q1<=0;
            q2<=0;
        end
        else begin
            q1<=asyn_in;
            q2<=q1;
        end
    end

    assign sync_out = q2;
    
endmodule

