module control_states_fsm(
    input wire clk,
    input wire rst,
    input wire mode_pulse,
    input wire control_pulse,
    output reg [1:0] current_state,
    output reg [1:0] sw_state
);

    localparam
        STATE_TIME=2'b00,
        STATE_STOPWATCH=2'b01,
        STATE_ALARM_SET=2'b10,
        STATE_TIME_SET=2'b11;

    localparam
        SW_RESET = 2'b00,
        SW_RUN   = 2'b01,
        SW_STOP  = 2'b10;

    reg [1:0] next_state;
    reg [1:0] next_sw_state;


always @(*)
begin
    case(current_state)
        STATE_TIME:begin
            if (mode_pulse) next_state=STATE_STOPWATCH;
            else next_state=current_state;
        end
        STATE_STOPWATCH:begin
            if (mode_pulse) next_state=STATE_ALARM_SET;
            else next_state=current_state;
        end
        STATE_ALARM_SET:begin
            if (mode_pulse) next_state=STATE_TIME_SET;
            else next_state=current_state;
        end
        STATE_TIME_SET:begin
            if (mode_pulse) next_state=STATE_TIME;
            else next_state=current_state;
        end
        default:next_state=STATE_TIME;
    endcase
end 

    always @(*) begin
        next_sw_state=sw_state;
        if (current_state == STATE_STOPWATCH) 
            case(sw_state)
                SW_RESET: next_sw_state = control_pulse ? SW_RUN   : SW_RESET;
                SW_RUN:   next_sw_state = control_pulse ? SW_STOP  : SW_RUN;
                SW_STOP:  next_sw_state = control_pulse ? SW_RESET : SW_STOP;
                default:  next_sw_state = SW_RESET;
            endcase
    end

always @(posedge clk)
begin
    if (rst) begin
        current_state<=STATE_TIME;
        sw_state<=SW_RESET;
    end
    else begin
        current_state<=next_state;
        sw_state<=next_sw_state;
    end
end
endmodule
