# Clock signal
set_property PACKAGE_PIN W5 [get_ports i_clock]							
	set_property IOSTANDARD LVCMOS33 [get_ports i_clock]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports i_clock]
	
# LEDs
set_property PACKAGE_PIN U16 [get_ports {carry}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {carry}]
set_property PACKAGE_PIN E19 [get_ports {full}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {full}]
	
##Buttons
set_property PACKAGE_PIN U18 [get_ports i_reset]						
	set_property IOSTANDARD LVCMOS33 [get_ports i_reset]
	
##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx]						
	set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property PACKAGE_PIN A18 [get_ports tx]						
	set_property IOSTANDARD LVCMOS33 [get_ports tx]