#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/home/aq/installations/xilinx_2022/Vivado/2022.2/ids_lite/ISE/bin/lin64:/home/aq/installations/xilinx_2022/Vivado/2022.2/bin
else
  PATH=/home/aq/installations/xilinx_2022/Vivado/2022.2/ids_lite/ISE/bin/lin64:/home/aq/installations/xilinx_2022/Vivado/2022.2/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/aq/git/courses/digital-design-toolbox/lab13/lab_13_1/vivado/lab_13_led_right/led-blink.runs/impl_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

# pre-commands:
/bin/touch .write_bitstream.begin.rst
EAStep vivado -log top_led_bd_wrapper.vdi -applog -m64 -product Vivado -messageDb vivado.pb -mode batch -source top_led_bd_wrapper.tcl -notrace


