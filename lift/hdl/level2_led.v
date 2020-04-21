/*
        This module is for the level-1 requests from the external
        push button. One press means UP request.
        Two presses means DOWN request. Three presses means BOTH requests.
        Debounced and pulsed push button signal is the input along with
        clear signals from the lift state machine. The output
        is an upreq and dnreq signals.
*/

module level2_led(
    input            clk, resetb, slowref,
    input            pbpulse,
    input            clrup,clrdn,          // Clear signal from the lift
    output           upreq, dnreq          // Up and down request signals
);

reg [1:0] ud; // MSB-> UP, LSB-> DOWN
reg [1:0] nxtud;    // wire-reg

parameter INIT = 2'b00,                    // Both led OFF
            UP = 2'b10, DN = 2'b01,        // Up or Down led ON
           UDN = 2'b11;                    // Both up and down led are ON

assign upreq = ud[1], dnreq = ud[0];

always @(posedge clk or negedge resetb)
    if (!resetb) ud <= INIT;
    else         ud <= nxtud;
    
always @(*)
    if (slowref) begin
        case (ud)
            INIT : if (clrup)        nxtud = ud;
                   else if (clrdn)   nxtud = ud;
                   else if (pbpulse) nxtud = UP;
                   else              nxtud = ud;
            UP   : if (clrup)        nxtud = INIT;
                   else if (clrdn)   nxtud = ud;
                   else if (pbpulse) nxtud = DN;
                   else              nxtud = ud;
            DN   : if (clrup)        nxtud = ud;
                   else if (clrdn)   nxtud = INIT;
                   else if (pbpulse) nxtud = UDN;
                   else              nxtud = ud;
            UDN  : if (clrup)        nxtud = DN;
                   else if (clrdn)   nxtud = UP;
                   else if (pbpulse) nxtud = ud;
                   else              nxtud = ud;

            default : nxtud = INIT;
        endcase
    end else nxtud = ud;
endmodule