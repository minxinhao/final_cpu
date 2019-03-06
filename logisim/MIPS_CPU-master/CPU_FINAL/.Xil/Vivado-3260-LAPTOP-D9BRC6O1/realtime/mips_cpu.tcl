# 
# Synthesis run script generated by Vivado
# 

namespace eval rt {
    variable rc
}
set rt::rc [catch {
  uplevel #0 {
    set ::env(BUILTIN_SYNTH) true
    source $::env(HRT_TCL_PATH)/rtSynthPrep.tcl
    rt::HARTNDb_resetJobStats
    rt::HARTNDb_startJobStats
    set rt::cmdEcho 0
    rt::set_parameter writeXmsg true
    set ::env(RT_TMP) "./.Xil/Vivado-3260-LAPTOP-D9BRC6O1/realtime/tmp"
    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
      file mkdir $::env(RT_TMP)
    }

    rt::delete_design

    set rt::partid xc7a100tcsg324-1

    set rt::multiChipSynthesisFlow false
    source $::env(SYNTH_COMMON)/common.tcl
    set rt::defaultWorkLibName xil_defaultlib

    set rt::useElabCache false
    if {$rt::useElabCache == false} {
      rt::read_verilog {
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/H2D/H2D.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/MUX/sel_bits_2_mux.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/show_signal/_7Seg_Dirver_Decode.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/MUX/sel_bits_1_mux.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/counter/counter.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/show_signal/show_signal.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/IM/IM.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/Controler/controler.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/D_Ext/D_Ext.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/CPU_ALU/RISC_ALU.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/DM/DataMemo.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/DVM/DVM.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/NPC/NPC.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/RegisterFile/RF.v
      F:/Study_in_class/CPU/CPU/project_2/project_2.srcs/sources_1/imports/MIPS_CPU/CPU/MIPS_CPU.v
    }
      rt::filesetChecksum
    }
    rt::set_parameter usePostFindUniquification false
    set rt::top mips_cpu
    set rt::reportTiming false
    rt::set_parameter elaborateOnly true
    rt::set_parameter elaborateRtl true
    rt::set_parameter eliminateRedundantBitOperator false
    rt::set_parameter writeBlackboxInterface true
    rt::set_parameter merge_flipflops true
    rt::set_parameter srlDepthThreshold 3
    rt::set_parameter rstSrlDepthThreshold 4
    rt::set_parameter webTalkPath {}
    rt::set_parameter enableSplitFlowPath "./.Xil/Vivado-3260-LAPTOP-D9BRC6O1/"
    if {$rt::useElabCache == false} {
      rt::run_rtlelab -module $rt::top
    }

    set rt::flowresult [ source $::env(SYNTH_COMMON)/flow.tcl ]
    rt::HARTNDb_stopJobStats
    if { $rt::flowresult == 1 } { return -code error }

    if { [ info exists ::env(RT_TMP) ] } {
      file delete -force $::env(RT_TMP)
    }


    source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  } ; #end uplevel
} rt::result]

if { $rt::rc } {
  $rt::db resetHdlParse
  source $::env(HRT_TCL_PATH)/rtSynthCleanup.tcl
  return -code "error" $rt::result
}
