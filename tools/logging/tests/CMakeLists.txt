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
