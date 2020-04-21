module lift (
  input        clk, resetb,                       // 50 MHz clock and active low reset
  input        pbsig0,pbsig1,pbsig2,              // Push Button Raw Input
  input        swsig0,swsig1,swsig2,              // Raw input from toggle switch
  output       upreq1, dnreq1,                    // LED display for floor-1
  output       upreq0, dnreq2,                    // LED display for floor-0 and floor-2
  output [7:0] d1, d2,                            // UP/DN display on seven segment display
  output       flreq0,flreq1,flreq2,              // Inside lift floor request panel LED
  output [7:0] numdisp                            // Floor number display on seven segment display 
);

wire       slowref;                               // Slowed down clock reference signal
wire       clrup0,clrup1;                         // Clear up for the external call request from push button
wire       clrdn1,clrdn2;                         // Clear down for the external call request from push button
wire       upsig;                                 // Moving up signal from lift
wire       dnsig;                                 // Moving down signal from lift
wire       moving;                                // Moving signal from lift
wire       clr_flreq0,clr_flreq1,clr_flreq2;      // Clearing request of foor panel inside lift
wire [1:0] floorno;                               // Next state floor number from lift
wire       clean0,clean1,clean2;                  // Debounced output of push button
wire       pbpulse0,pbpulse1,pbpulse2;            // Pulse output from push button
wire       sw_pulse0,sw_pulse1,sw_pulse2;         // Pulse output from toggle switch
wire       cleansw0,cleansw1,cleansw2;            // Debounced output of toggle switch
wire       clr;                                   // Clear signal for ground and second floor


// Reference clock generator module
clkref c0(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref)
);

// Debounce module for ground floor ext panel
debounce db0(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref),
    .pbsig(pbsig0),
    .clean(clean0)
);

// Pulse generator for froung floor ext panel
pb_pulse p0(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .clean(clean0),
    .pbpulse(pbpulse0)          // Pulse output from debounced signal
);

// Debounce module for first floor ext panel
debounce db1(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref),
    .pbsig(pbsig1),
    .clean(clean1)
);

// Pulse generator module for first floor ext panel
pb_pulse p1(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .clean(clean1),
    .pbpulse(pbpulse1)          // Pulse output from debounced signal
);

// Debounce module for second floor ext panel
debounce db2(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref),
    .pbsig(pbsig2),
    .clean(clean2)
);

// Pulse generator for second floor ext panel
pb_pulse p2(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .clean(clean2),
    .pbpulse(pbpulse2)          // Pulse output from debounced signal
);

// Debounce module for ground floor int panel
debounce_sw dbs0(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),          // 8 to 32 Hz reference strobe
    .swsig(swsig0),             // Push Button Raw Input
    .cleansw(cleansw0)          // Debounced output from switch
);

// Pulse generator module for ground floor int panel
switch_pulse s0(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
	.cleansw(cleansw0),
    .sw_pulse(sw_pulse0)        // Pulse output from debounced signal
);

// Debounce module for first floor int panel
debounce_sw dbs1(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),          // 8 to 32 Hz reference strobe
    .swsig(swsig1),             // Push Button Raw Input
    .cleansw(cleansw1)          // Debounced output from switch
);

// Debounce module for first floor int panel
switch_pulse s1(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
	.cleansw(cleansw1),
    .sw_pulse(sw_pulse1)        // Pulse output from debounced signal
);

// Debounce module for second floor int panel
debounce_sw dbs2(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),          // 8 to 32 Hz reference strobe
    .swsig(swsig2),             // Push Button Raw Input
    .cleansw(cleansw2)          // Debounced output from switch
);

// Pulse generator module for second floor int panel
switch_pulse s2(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
	.cleansw(cleansw2),
    .sw_pulse(sw_pulse2)         // Pulse output from debounced signal
);

// LED request generator for ground floor
leveltg_led tg_0(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .pbpulse(pbpulse0),
	.clr(clrup0),                // From lift
    .tg(upreq0)                  // MSB-> UP, LSB-> DOWN
);

// LED request generator for first floor 
level2_led f0(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .pbpulse(pbpulse1),
    .clrup(clrup1),
	.clrdn(clrdn1),              // From lift
    .upreq(upreq1),              // UP
	.dnreq(dnreq1)               // DOWN          
);

// LED request generator for second floor
leveltg_led tg_2(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .pbpulse(pbpulse2),
	.clr(clrdn2),                // From lift
    .tg(dnreq2)                    
);

//Int panel floor select - Ground floor
flreq flr0(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref),
    .sw_pulse(sw_pulse0),        // Pulse from the switch transition
    .clr_flreq(clr_flreq0),      // Clear signal from lift
    .flreq_led(flreq0)           // Floor request led, inside the lift
);

//Int panel floor select - First floor
flreq flr1(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref),
    .sw_pulse(sw_pulse1),        // Pulse from the switch transition
    .clr_flreq(clr_flreq1),      // Clear signal from lift
    .flreq_led(flreq1)           // Floor request led, inside the lift
);

//Int panel floor select - Second floor
flreq flr2(
    .clk(clk),
    .resetb(resetb),
    .slowref(slowref),
    .sw_pulse(sw_pulse2),        // Pulse from the switch transition
    .clr_flreq(clr_flreq2),      // Clear signal from lift
    .flreq_led(flreq2)           // Floor request led, inside the lift
);

// UP/DOWN display module
ud_disp ud0(
    .clk(clk),
	.resetb(resetb),
	.slowref(slowref),
    .upsig(upsig),
	.dnsig(dnsig),              // Up and Down signal sent by lift indicating direction of motion
    .moving(moving),            // Signal sent from lift when moving 
    .d1(d1),                    
	.d2(d2)                     // Display output to seven-seg 
);

// Floor number display module
number_disp nd0(
   .clk(clk),
   .resetb(resetb),
   .slowref(slowref),
   .floorno(floorno),            // Input from lift which tells us the current floor number 
   .numdisp(numdisp)             // Seven segment display to show floor number 
);

// Lift State Machine
lift_sm sm0(
   .clk(clk),
   .resetb(resetb),
   .slowref(slowref),
   .floorno(floorno),            // Input from lift which tells us the current floor number
   .upreq0(upreq0),
   .upreq1(upreq1),
   .dnreq1(dnreq1),
   .dnreq2(dnreq2),   
   .flreq0(flreq0),
   .flreq1(flreq1),
   .flreq2(flreq2),
   .clr_flreq0(clr_flreq0),
   .clr_flreq1(clr_flreq1),
   .clr_flreq2(clr_flreq2),       
   .clrup0(clrup0),
   .clrup1(clrup1),
   .clrdn1(clrdn1),
   .clrdn2(clrdn2),
   .upsig(upsig),
   .dnsig(dnsig),
   .moving(moving)
);

endmodule