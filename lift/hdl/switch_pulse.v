/*
        This module generates a pulse from the cleaned switch
        signal. Each transition is used to generate a pulse.
*/

module switch_pulse (
    input      clk, resetb,
    input      slowref,
    input      cleansw,                // Cleaned switch signal
    output reg sw_pulse                // Pulse output from debounced signal
);

reg c, d;

always@(posedge clk or negedge resetb)
    if (!resetb) begin
        sw_pulse <= 0;
        {c,d}    <= 2'b0;
    end
    else if (slowref) begin
        {c,d}     = {cleansw,c};
        sw_pulse <= (c ^ d);          // Switch pulse from debounced switch signal
    end
endmodule