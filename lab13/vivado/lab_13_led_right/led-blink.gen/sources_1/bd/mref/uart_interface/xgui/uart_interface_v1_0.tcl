# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "clk_per_bit" -parent ${Page_0}
  ipgui::add_param $IPINST -name "ctr_size" -parent ${Page_0}


}

proc update_PARAM_VALUE.clk_per_bit { PARAM_VALUE.clk_per_bit } {
	# Procedure called to update clk_per_bit when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.clk_per_bit { PARAM_VALUE.clk_per_bit } {
	# Procedure called to validate clk_per_bit
	return true
}

proc update_PARAM_VALUE.ctr_size { PARAM_VALUE.ctr_size } {
	# Procedure called to update ctr_size when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.ctr_size { PARAM_VALUE.ctr_size } {
	# Procedure called to validate ctr_size
	return true
}


proc update_MODELPARAM_VALUE.clk_per_bit { MODELPARAM_VALUE.clk_per_bit PARAM_VALUE.clk_per_bit } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.clk_per_bit}] ${MODELPARAM_VALUE.clk_per_bit}
}

proc update_MODELPARAM_VALUE.ctr_size { MODELPARAM_VALUE.ctr_size PARAM_VALUE.ctr_size } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.ctr_size}] ${MODELPARAM_VALUE.ctr_size}
}

