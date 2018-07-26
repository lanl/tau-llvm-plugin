# For use with C programs
add_llvm_loadable_module(TAU_Profiling
  Instrument.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )

# For use with C++ programs
add_llvm_loadable_module(TAU_Profiling_CXX
  Instrument.cpp

  DEPENDS
  intrinsics_gen
  PLUGIN_TOOL
  opt
  )

target_compile_definitions(TAU_Profiling_CXX PUBLIC TAU_PROF_CXX)
