if {[file exists work]} {
	vdel -lib work -all
}
vlib work
vmap work work

### ---------------------------------------------- ###
### Compile code ###
### Enter files here; copy line for multiple files ###

# reset & synchronizer
vlog -sv -work work [pwd]/reset.sv
vlog -sv -work work [pwd]/synchronizer.sv

# adder (from lab 4)
vlog -sv -work work [pwd]/fullAdder.sv
vlog -sv -work work [pwd]/adder.sv
vlog -sv -work work [pwd]/subtractor.sv
vlog -sv -work work [pwd]/sixBitAddSub.sv

# seven segment display (from lab 6)
vlog -sv -work work [pwd]/binToDec.sv
vlog -sv -work work [pwd]/setSevSeg.sv
vlog -sv -work work [pwd]/dispSevSeg.sv
vlog -sv -work work [pwd]/dualSevDisp.sv

# FIFO (from lab 8)
vlog -sv -work -suppress 7061 work [pwd]/memory.sv
vlog -sv -work work [pwd]/fsm_control.sv
vlog -sv -work work [pwd]/lab8_FIFO.sv

# logic operations
vlog -sv -work work [pwd]/logic_operation.sv

# Top Level Module & testbench
vlog -sv -work work [pwd]/lab9_ALU.sv
vlog -sv -work work [pwd]/lab9_ALU_tb.sv

### ---------------------------------------------- ###
### Load design for simulation ###
### Replace topLevelModule with the name of your top level module (no .sv) ###
### Do not duplicate! ###
vsim -voptargs=+acc lab9_ALU_tb

### ---------------------------------------------- ###
### Add waves here ###
### Use add wave * to see all signals ###
add wave *
delete wave /lab9_ALU_tb/over
delete wave /lab9_ALU_tb/aInteger
delete wave /lab9_ALU_tb/bInteger
delete wave /lab9_ALU_tb/negAB
delete wave /lab9_ALU_tb/calcAdd
delete wave /lab9_ALU_tb/calcSub

### Force waves here ###

### ---------------------------------------------- ###
### Run simulation ###
### Do not modify ###
# to see your design hierarchy and signals 
view structure 

# to see all signal names and current values
view signals 

### ---------------------------------------------- ###
### Edit run time ###
run 100000

### ---------------------------------------------- ###
### Will create large wave window and zoom to show all signals
view -undock wave
wave zoomfull 
