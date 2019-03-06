@echo off
set xv_path=D:\\Vivado\\Vivado\\2015.2\\bin
call %xv_path%/xsim mips_cpu_tb_behav -key {Behavioral:sim_1:Functional:mips_cpu_tb} -tclbatch mips_cpu_tb.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
