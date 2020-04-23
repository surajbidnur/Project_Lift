# Project_Lift
Simulating the working of an elevator using verilog hld coding and testing it on an FPGA

The project simulates the working of a 3 floor elevator (groung,first and second).The same functionality can be extended to more floors if needed.

This project has been simulated on Altera Quartus 2 software and been run on the Cyclone 2 FPGA. 

The inputs to select the floor number and choose the direction of elevator motion are given through switches and push buttons on the FPGA. It also has a dedicated push botton for a full system reset. All the inputs from switched are debounced to prevent glitches.
The floor number and direction of motion of the lift are displayed on 7 segment LED displays.

The operation is based on a state machine.  

The hdl code files are located at /lift/hdl/  
Test_Waveforms folder has some of the screenshots taken during testing the design.