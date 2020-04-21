/*
        This module takes in the debounced and pulsed switch
        signal and is used to generate a floor request signal
        which lights up the request LED and is also used to
        move the state machine.
*/

module flreq(
    input         clk, resetb, slowref,
    input         sw_pulse,                 // Pulse from the switch transition
    input         clr_flreq,                // Clear signal from lift
    output reg    flreq_led                 // Floor request led, inside the lift
);

always @(posedge clk or negedge resetb)
    if (!resetb) flreq_led <= 0;
    else if (slowref) begin
        if (clr_flreq)     flreq_led <= 0;
        else if (sw_pulse) flreq_led <= 1;
        else ;                              // no change
    end
 
endmodule