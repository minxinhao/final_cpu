# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
debug::add_scope template.lib 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.cache/wt [current_project]
set_property parent.project_path F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/H2D/H2D.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/MUX/sel_bits_2_mux.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/show_signal/_7Seg_Dirver_Decode.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/MUX/sel_bits_1_mux.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/counter/counter.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/show_signal/show_signal.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/IM/IM.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/Controler/controler.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/D_Ext/D_Ext.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/CPU_ALU/RISC_ALU.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/DM/DataMemo.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/DVM/DVM.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/NPC/NPC.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/RegisterFile/RF.v
  F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/CPU/MIPS_CPU.v
}
read_xdc F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/constrs_1/imports/MIPS_CPU/Nexys4DDR_Master.xdc
set_property used_in_implementation false [get_files F:/Study_in_class/CPU/CPU/project_2_2/project_2/project_2.srcs/constrs_1/imports/MIPS_CPU/Nexys4DDR_Master.xdc]

synth_design -top mips_cpu -part xc7a100tcsg324-1
write_checkpoint -noxdef mips_cpu.dcp
catch { report_utilization -file mips_cpu_utilization_synth.rpt -pb mips_cpu_utilization_synth.pb }