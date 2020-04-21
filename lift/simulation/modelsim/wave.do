onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /liftsm_tb/clk
add wave -noupdate /liftsm_tb/resetb
add wave -noupdate /liftsm_tb/lift0/slowref
add wave -noupdate /liftsm_tb/pbsig0
add wave -noupdate /liftsm_tb/pbsig1
add wave -noupdate /liftsm_tb/pbsig2
add wave -noupdate /liftsm_tb/swsig0
add wave -noupdate /liftsm_tb/swsig1
add wave -noupdate /liftsm_tb/swsig2
add wave -noupdate /liftsm_tb/upreq0
add wave -noupdate /liftsm_tb/upreq1
add wave -noupdate /liftsm_tb/dnreq1
add wave -noupdate /liftsm_tb/dnreq2
add wave -noupdate /liftsm_tb/flreq0
add wave -noupdate /liftsm_tb/flreq1
add wave -noupdate /liftsm_tb/flreq2
add wave -noupdate /liftsm_tb/lift0/clrup0
add wave -noupdate /liftsm_tb/lift0/clrup1
add wave -noupdate /liftsm_tb/lift0/clrdn1
add wave -noupdate /liftsm_tb/lift0/clrdn2
add wave -noupdate /liftsm_tb/lift0/numdisp
add wave -noupdate /liftsm_tb/lift0/floorno
add wave -noupdate /liftsm_tb/lift0/sm0/sm
add wave -noupdate /liftsm_tb/lift0/sm0/ctr
add wave -noupdate /liftsm_tb/d1
add wave -noupdate /liftsm_tb/d2
add wave -noupdate /liftsm_tb/numdisp
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1829 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 171
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {10507 ps}
