# For use with C programs
add_llvm_library(TAU_Profiling
  MODULE
  Instrument.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )

# For use with C++ programs
add_llvm_library(TAU_Profiling_CXX
  MODULE
  Instrument.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )

target_compile_definitions(TAU_Profiling_CXX PUBLIC TAU_PROF_CXX)
