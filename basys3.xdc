## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project


## xdc para rs232

## Clock signal
set_property PACKAGE_PIN W5 [get_ports mclk]							
	set_property IOSTANDARD LVCMOS33 [get_ports mclk]
	create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports mclk]
 
## Switches
set_property PACKAGE_PIN V17 [get_ports { tx_data[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[0]}]
set_property PACKAGE_PIN V16 [get_ports { tx_data[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[1]}]
set_property PACKAGE_PIN W16 [get_ports { tx_data[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[2]}]
set_property PACKAGE_PIN W17 [get_ports { tx_data[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[3]}]
set_property PACKAGE_PIN W15 [get_ports { tx_data[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[4]}]
set_property PACKAGE_PIN V15 [get_ports { tx_data[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[5]}]
set_property PACKAGE_PIN W14 [get_ports { tx_data[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[6]}]
set_property PACKAGE_PIN W13 [get_ports { tx_data[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { tx_data[7]}]
#set_property PACKAGE_PIN V2 [get_ports {sw[8]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[8]}]
#set_property PACKAGE_PIN T3 [get_ports {sw[9]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[9]}]
#set_property PACKAGE_PIN T2 [get_ports {sw[10]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[10]}]
#set_property PACKAGE_PIN R3 [get_ports {sw[11]}]					
	#set_property IOSTANDARD LVCMOS33 [get_ports {sw[11]}]
#set_property PACKAGE_PIN W2 [get_ports {sw[12]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[12]}]
#set_property PACKAGE_PIN U1 [get_ports {sw[13]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[13]}]
#set_property PACKAGE_PIN T1 [get_ports {sw[14]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[14]}]
#set_property PACKAGE_PIN R2 [get_ports {sw[15]}]					
#	set_property IOSTANDARD LVCMOS33 [get_ports {sw[15]}]
 

## LEDs
set_property PACKAGE_PIN U16 [get_ports {leds[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[0]}]
set_property PACKAGE_PIN E19 [get_ports {leds[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[1]}]
set_property PACKAGE_PIN U19 [get_ports {leds[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[2]}]
set_property PACKAGE_PIN V19 [get_ports {leds[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[3]}]
set_property PACKAGE_PIN W18 [get_ports {leds[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[4]}]
set_property PACKAGE_PIN U15 [get_ports {leds[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[5]}]
set_property PACKAGE_PIN U14 [get_ports {leds[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[6]}]
set_property PACKAGE_PIN V14 [get_ports {leds[7]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {leds[7]}]

	
	
###7 segment display
set_property PACKAGE_PIN W7 [get_ports {a_to_g[6]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[6]}]
set_property PACKAGE_PIN W6 [get_ports {a_to_g[5]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[5]}]
set_property PACKAGE_PIN U8 [get_ports {a_to_g[4]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[4]}]
set_property PACKAGE_PIN V8 [get_ports {a_to_g[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[3]}]
set_property PACKAGE_PIN U5 [get_ports {a_to_g[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[2]}]
set_property PACKAGE_PIN V5 [get_ports {a_to_g[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[1]}]
set_property PACKAGE_PIN U7 [get_ports {a_to_g[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {a_to_g[0]}]

#set_property PACKAGE_PIN V7 [get_ports dp]							
	#set_property IOSTANDARD LVCMOS33 [get_ports dp]
	
	

set_property PACKAGE_PIN U2 [get_ports {an[0]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports {an[0]}]
set_property PACKAGE_PIN U4 [get_ports {an[1]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { an[1] }]
set_property PACKAGE_PIN V4 [get_ports { an[2]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { an[2]}]
set_property PACKAGE_PIN W4 [get_ports { an[3]}]					
	set_property IOSTANDARD LVCMOS33 [get_ports { an[3]}]


##Buttons

set_property PACKAGE_PIN W19 [get_ports clr]						
	set_property IOSTANDARD LVCMOS33 [get_ports clr]
set_property PACKAGE_PIN T17 [get_ports btn]						
	set_property IOSTANDARD LVCMOS33 [get_ports btn]

 

##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rxd]						
	set_property IOSTANDARD LVCMOS33 [get_ports rxd]
set_property PACKAGE_PIN A18 [get_ports txd]						
	set_property IOSTANDARD LVCMOS33 [get_ports txd]


