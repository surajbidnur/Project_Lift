module level2_led(
    input            clk, resetb, slowref,
    input            pbpulse,
    input            clrup,clrdn,          // From lift
    output reg [1:0] ud                   // MSB-> UP, LSB-> DOWN
);

reg [1:0] nxtud;    // wire-reg

parameter INIT = 2'b00,                // Both led OFF
          UP = 2'b10, DN = 2'b01,      // Up or Down led ON
          UD = 2'b11;                  // Both up and down led are ON

always @(posedge clk or negedge resetb)
    if (!resetb) ud <= INIT;
    else ud <= nxtud;
    
always @(*)
    if (slowref) begin
        case (ud)
            INIT : if (clrup) nxtud = ud;
                   else if (clrdn) nxtud = ud;
                   else if (pbpulse) nxtud = UP;
                   else nxtud = ud;
            UP   : if (clrup) nxtud = INIT;
                   else if (clrdn) nxtud = ud;
                   else if (pbpulse) nxtud = DN;
                   else nxtud = ud;
            DN   : if (clrup) nxtud = ud;
                   else if (clrdn) nxtud = INIT;
                   else if (pbpulse) nxtud = UD;
                   else nxtud = ud;
            UD   : if (clrup) nxtud = DN;
                   else if (clrdn) nxtud = UP;
                   else if (pbpulse) nxtud = ud;
                   else nxtud = ud;

            default : nxtud = INIT;
        endcase
    end else nxtud = ud;
endmodule