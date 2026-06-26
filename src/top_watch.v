module top_watch(
    input wire clk,
    input wire rst,
    input wire btn_mode,
    input wire btn_control,
    output wire [5:0] anode,
    output wire [6:0] seg
);

    wire tick_1hz;
    wire tick_1khz;
    wire sync_mode;
    wire sync_control;
    wire debounced_mode;
    wire debounced_control;
    wire mode_pulse;
    wire control_pulse;
    wire [1:0] current_state;
    wire [1:0] sw_state;

    wire [3:0] sec_units;
    wire [2:0] sec_tens;
    wire [3:0] min_units;
    wire [2:0] min_tens;
    wire [3:0] hour_units;
    wire [1:0] hour_tens;

    wire [3:0] sw_sec_units;
    wire [2:0] sw_sec_tens;
    wire [3:0] sw_min_units;
    wire [2:0] sw_min_tens;

    reg delay_mode;
    reg delay_control;

    clock_divider clk_div_inst (
        .clk(clk),
        .rst(rst),
        .tick_1Hz(tick_1hz),
        .tick_1KHz(tick_1khz)
    );

    synchronizer sync_mode_inst (
        .master_clk(clk),
        .rst(rst),
        .asyn_in(btn_mode),
        .sync_out(sync_mode)
    );

    synchronizer sync_control_inst (
        .master_clk(clk),
        .rst(rst),
        .asyn_in(btn_control),
        .sync_out(sync_control)
    );

    debouncer debounce_mode_inst (
        .clk(clk),
        .rst(rst),
        .tick_1KHz(tick_1khz),
        .btn_in(sync_mode),
        .btn_out(debounced_mode)
    );

    debouncer debounce_control_inst (
        .clk(clk),
        .rst(rst),
        .tick_1KHz(tick_1khz),
        .btn_in(sync_control),
        .btn_out(debounced_control)
    );

    always @(posedge clk) begin
        if (rst) begin
            delay_mode <= 1'b0;
            delay_control <= 1'b0;
        end else begin
            delay_mode <= debounced_mode;
            delay_control <= debounced_control;
        end
    end

    assign mode_pulse = debounced_mode && !delay_mode;
    assign control_pulse = debounced_control && !delay_control;

    control_states_fsm watch_fsm_inst (
        .clk(clk),
        .rst(rst),
        .mode_pulse(mode_pulse),
        .control_pulse(control_pulse),
        .current_state(current_state),
        .sw_state(sw_state)
    );

    time_counters time_core_inst(
        .clk(clk),
        .rst(rst),
        .tick_1Hz(tick_1hz),
        .sw_state(sw_state),
        .sec_units(sec_units),
        .sec_tens(sec_tens),
        .min_units(min_units),
        .min_tens(min_tens),
        .hour_units(hour_units),
        .hour_tens(hour_tens),
        .sw_sec_units(sw_sec_units),
        .sw_sec_tens(sw_sec_tens),
        .sw_min_units(sw_min_units),
        .sw_min_tens(sw_min_tens)
    );

    seven_seg_mux display_driver_inst (
        .clk(clk),
        .rst(rst),
        .refresh_tick(tick_1khz),
        .current_state(current_state),
        .sw_state(sw_state),
        .sec_units(sec_units),
        .sec_tens(sec_tens),
        .min_units(min_units),
        .min_tens(min_tens),
        .hour_units(hour_units),
        .hour_tens(hour_tens),
        .sw_sec_units(sw_sec_units),
        .sw_sec_tens(sw_sec_tens),
        .sw_min_units(sw_min_units),
        .sw_min_tens(sw_min_tens),
        .anode(anode),
        .seg(seg)
    );

endmodule
