cmake_minimum_required(VERSION 3.18)
include_guard(GLOBAL)

set(FEATURE_opengl OFF)
set(FEATURE_ico OFF)
set(FEATURE_xcb OFF)
set(FEATURE_xcb_xlib OFF)
set(QT_FEATURE_network OFF)
set(QT_FEATURE_sctp OFF)
set(QT_FEATURE_widgets OFF)

# In case of error "Targets not yet defined: zstd::libzstd_static" try 
# set(FEATURE_zstd OFF)

set(QT_FEATURE_gui OFF)
set(FEATURE_androiddeployqt OFF)
set(X11_SUPPORTED OFF) # more https://bugreports.qt.io/browse/QTBUG-109028
set(FEATURE_c89 OFF)
set(FEATURE_pkg_config OFF)
#build static Qt 
set(BUILD_SHARED_LIBS OFF) #Build Qt statically (OFF) or dynamically (ON)
set(FEATURE_static ON)

set(CMAKE_C_FLAGS_INIT "static")
set(CMAKE_CXX_FLAGS_INIT "static")
set(CMAKE_BUILD_TYPE "Debug")

include(CMakeInitializeConfigs)

function(cmake_initialize_per_config_variable _PREFIX _DOCSTRING)
  if (_PREFIX MATCHES "CMAKE_(C|CXX|ASM)_FLAGS")
    set(CMAKE_${CMAKE_MATCH_1}_FLAGS_INIT "${QT_COMPILER_FLAGS}")
        
    foreach (config DEBUG RELEASE MINSIZEREL RELWITHDEBINFO)
      if (DEFINED QT_COMPILER_FLAGS_${config})
        set(CMAKE_${CMAKE_MATCH_1}_FLAGS_${config}_INIT "${QT_COMPILER_FLAGS_${config}}")
      endif()
    endforeach()
  endif()


  if (_PREFIX MATCHES "CMAKE_(SHARED|MODULE|EXE)_LINKER_FLAGS")
    foreach (config SHARED MODULE EXE)
      set(CMAKE_${config}_LINKER_FLAGS_INIT "${QT_LINKER_FLAGS}")
    endforeach()
  endif()

  _cmake_initialize_per_config_variable(${ARGV})
endfunction()
