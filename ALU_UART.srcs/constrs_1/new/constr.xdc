## This file is a general .xdc for the Nexys4 DDR Rev. C
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { i_clock }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {i_clock}];

##Buttons

set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { i_reset }]; #IO_L9P_T1_DQS_14 Sch=btnc

##USB-RS232 Interface

set_property -dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports { rx }]; #IO_L7P_T1_AD6P_35 Sch=uart_txd_in
set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { tx }]; #IO_L11N_T1_SRCC_35 Sch=uart_rxd_out

## Leds

set_property -dict { PACKAGE_PIN H17   IOSTANDARD LVCMOS33 } [get_ports { result[0] }]; #IO_L18P_T2_A24_15 Sch=result[0]
set_property -dict { PACKAGE_PIN K15   IOSTANDARD LVCMOS33 } [get_ports { result[1] }]; #IO_L24P_T3_RS1_15 Sch=result[1]
set_property -dict { PACKAGE_PIN J13   IOSTANDARD LVCMOS33 } [get_ports { result[2] }]; #IO_L17N_T2_A25_15 Sch=result[2]
set_property -dict { PACKAGE_PIN N14   IOSTANDARD LVCMOS33 } [get_ports { result[3] }]; #IO_L8P_T1_D11_14 Sch=result[3]
set_property -dict { PACKAGE_PIN R18   IOSTANDARD LVCMOS33 } [get_ports { result[4] }]; #IO_L7P_T1_D09_14 Sch=result[4]
set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { result[5] }]; #IO_L18N_T2_A11_D27_14 Sch=result[5]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { result[6] }]; #IO_L17P_T2_A14_D30_14 Sch=result[6]
set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports { result[7] }]; #IO_L18P_T2_A12_D28_14 Sch=result[7]

set_property -dict { PACKAGE_PIN V12   IOSTANDARD LVCMOS33 } [get_ports { full }]; #IO_L20N_T3_A07_D23_14 Sch=result[14]
set_property -dict { PACKAGE_PIN V11   IOSTANDARD LVCMOS33 } [get_ports { carry }]; #IO_L21N_T3_DQS_A06_D22_14 Sch=result[15]
