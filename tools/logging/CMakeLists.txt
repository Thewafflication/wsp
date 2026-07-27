cmake_minimum_required(VERSION 3.20)

add_library(wsp_logging STATIC wsp_log.c)
add_library(wsp::logging ALIAS wsp_logging)

target_include_directories(
  wsp_logging
  PUBLIC
    "${CMAKE_CURRENT_LIST_DIR}"
)

set_target_properties(
  wsp_logging
  PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED YES
    C_EXTENSIONS NO
)
