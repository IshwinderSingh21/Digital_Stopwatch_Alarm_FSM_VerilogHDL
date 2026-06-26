`timescale 1ns / 1ns

module top_watch_tb();

    reg clk;
    reg rst;
    reg btn_mode;
    reg btn_control;

    wire [5:0] anode;
    wire [6:0] seg;

    top_watch uut (
        .clk(clk),
        .rst(rst),
        .btn_mode(btn_mode),
        .btn_control(btn_control),
        .anode(anode),
        .seg(seg)
    );
    initial begin
        clk=1'b0;
    end
    always begin
        #5 clk = ~clk;
    end

    initial begin
        $dumpfile("watch_sim.vcd");
        $dumpvars(0, top_watch_tb);

    // =========================
        // INITIAL RESET
        // =========================
        rst = 1;
        btn_mode = 0;
        btn_control = 0;

        #100;
        rst = 0;

        // let system settle
        #1000;

        // =========================
        // TEST 1: MODE PRESS (TIME -> STOPWATCH)
        // =========================
        btn_mode = 1;
        #300;
        btn_mode = 0;

        #2000;

        // =========================
        // TEST 2: CONTROL PRESS (START STOPWATCH)
        // =========================
        btn_control = 1;
        #300;
        btn_control = 0;

        #5000;

        // =========================
        // TEST 3: CONTROL PRESS (PAUSE STOPWATCH)
        // =========================
        btn_control = 1;
        #300;
        btn_control = 0;

        #2000;

        // =========================
        // TEST 4: CONTROL PRESS (RESET STOPWATCH)
        // =========================
        btn_control = 1;
        #300;
        btn_control = 0;

        #2000;

        // =========================
        // TEST 5: MODE PRESS (STOPWATCH -> ALARM SET)
        // =========================
        btn_mode = 1;
        #300;
        btn_mode = 0;

        #2000;

        // =========================
        // TEST 6: MODE PRESS (ALARM SET -> TIME SET)
        // =========================
        btn_mode = 1;
        #300;
        btn_mode = 0;

        #2000;

        // =========================
        // TEST 7: MODE PRESS (TIME SET -> TIME)
        // =========================
        btn_mode = 1;
        #300;
        btn_mode = 0;

        #2000;

        $finish;
    end

endmodule
