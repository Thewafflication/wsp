cmake_minimum_required(VERSION 3.20)
project(wsp_logging_tests LANGUAGES C)

enable_testing()
add_subdirectory(.. wsp-logging)

add_executable(wsp_logging_test test_logging.c)
target_link_libraries(wsp_logging_test PRIVATE wsp::logging)

add_test(
  NAME wsp_logging_file
  COMMAND wsp_logging_test "${CMAKE_CURRENT_BINARY_DIR}/wsp.log"
)

add_library(wsp_logging_va_copy_fallback STATIC ../wsp_log.c)
target_include_directories(
  wsp_logging_va_copy_fallback
  PUBLIC
    "${CMAKE_CURRENT_LIST_DIR}/.."
)
target_compile_definitions(
  wsp_logging_va_copy_fallback
  PRIVATE
    WSP_LOG_FORCE_VA_COPY_ASSIGNMENT
)
set_target_properties(
  wsp_logging_va_copy_fallback
  PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED YES
    C_EXTENSIONS NO
)

add_executable(wsp_logging_va_copy_fallback_test test_logging.c)
target_link_libraries(
  wsp_logging_va_copy_fallback_test
  PRIVATE
    wsp_logging_va_copy_fallback
)

add_test(
  NAME wsp_logging_va_copy_fallback
  COMMAND wsp_logging_va_copy_fallback_test
    "${CMAKE_CURRENT_BINARY_DIR}/wsp-fallback.log"
)
