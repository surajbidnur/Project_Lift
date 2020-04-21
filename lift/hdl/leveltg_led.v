/*
        This module is used to generate the request signal for the
        top and ground floor LED and also for the state machine
        movement. It receives the debounced and cleaned up push
        button pulse as well as clear signal from the lift.
*/	

module leveltg_led(
    input            clk, resetb, slowref,
    input            pbpulse,
    input            clr,           // From lift
    output reg       tg                     
);

reg nxttg;    // wire-reg

parameter INIT = 1'b0,                      // OFF
          pTG  = 1'b1;                      // ON

always @(posedge clk or negedge resetb)
    if (!resetb) tg <= INIT;
    else         tg <= nxttg;
    
always @(*)
    if (slowref) begin
        case (tg)
            INIT : if (clr)          nxttg = INIT;
                   else if (pbpulse) nxttg = pTG;
                   else              nxttg = INIT;
            pTG  : if (clr)          nxttg = INIT;
                   else              nxttg = pTG;
            default :                nxttg = 1'bx;
        endcase
    end else nxttg = tg;
endmodule