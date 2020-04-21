transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/debounce.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/clkref.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/lift.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/pb_pulse.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/ud_disp.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/switch_pulse.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/debounce_sw.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/level2_led.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/leveltg_led.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/number_disp.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/flreq.v}
vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/lift_sm.v}

vlog -vlog01compat -work work +incdir+C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl {C:/Users/admin/Documents/Verilog_Proj/Project_Lift/lift/hdl/liftsm_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc"  liftsm_tb

add wave *
view structure
view signals
run -all
