module vending_machine_2503(
    input clk,
    input rst,
    input [1:0] in,   // 01 = 5rs, 10 = 10rs
    output reg out,
    output reg [1:0] change
);

parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;

reg [1:0] c_state, n_state;

always @(posedge clk or posedge rst) begin
    if (rst)
        c_state <= s0;
    else
        c_state <= n_state;
end

// Combinational block: next state and outputs
always @(*) begin
    n_state = c_state;
    out = 0;
    change = 2'b00;

    case (c_state)
        s0: begin
            if (in == 2'b00)
                n_state = s0;
            else if (in == 2'b01)
                n_state = s1;
            else if (in == 2'b10)
                n_state = s2;
        end

        s1: begin
            if (in == 2'b00) begin
                n_state = s0;
                change = 2'b01;   // return 5
            end
            else if (in == 2'b01)
                n_state = s2;
            else if (in == 2'b10) begin
                n_state = s0;
                out = 1;
            end
        end

        s2: begin
            if (in == 2'b00) begin
                n_state = s0;
                change = 2'b10;   // return 10
            end
            else if (in == 2'b01) begin
                n_state = s0;
                out = 1;
            end
            else if (in == 2'b10) begin
                n_state = s0;
                out = 1;
                change = 2'b01;   // return 5
            end
        end

        default: begin
            n_state = s0;
            out = 0;
            change = 2'b00;
        end
    endcase
end

endmodule