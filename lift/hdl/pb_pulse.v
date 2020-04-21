/*
        This module generates a pulse from the push button
        cleaned up signal.
*/

module pb_pulse (
    input      clk, resetb,
    input      slowref,
    input      clean,                 // Cleaned up push button signal
    output reg pbpulse                // Pulse output from debounced signal
);

reg a,b;

always@(posedge clk or negedge resetb)
    if (!resetb) begin
        pbpulse <= 0;
        {a,b}   <= 2'b0;
    end
    else if (slowref) begin
        {a,b}    = {clean,a};
        pbpulse <= (!a && b);         // Leading Transition of Active Low Button Signal       
    end
endmodule
