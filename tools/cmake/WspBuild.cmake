include_guard(GLOBAL)

if(CMAKE_VERSION VERSION_LESS 3.20)
  message(FATAL_ERROR "WspBuild.cmake requires CMake 3.20 or newer")
endif()

option(
  WSP_ENABLE_BUILD_WARNINGS
  "Apply the WSP compiler-warning baseline"
  ON
)
option(
  WSP_ENABLE_HARDENING
  "Apply the WSP native build-hardening baseline"
  ON
)
option(
  WSP_ENABLE_STATIC_ANALYSIS
  "Run the WSP clang-tidy baseline while compiling"
  OFF
)
option(
  WSP_REQUIRE_STACK_PROTECTION
  "Reject targets whose compiler cannot emit stack canaries"
  OFF
)
option(
  WSP_TINYCC_BOUNDS_CHECKING
  "Enable TinyCC -b bounds checks in Debug configurations"
  OFF
)

get_filename_component(
  _wsp_default_clang_tidy_config
  "${CMAKE_CURRENT_LIST_DIR}/../static-analysis/wsp-clang-tidy.yml"
  ABSOLUTE
)
set(
  WSP_CLANG_TIDY_EXECUTABLE
  ""
  CACHE FILEPATH
  "Path to clang-tidy; required when WSP_ENABLE_STATIC_ANALYSIS is ON"
)
set(
  WSP_CLANG_TIDY_CONFIG
  "${_wsp_default_clang_tidy_config}"
  CACHE FILEPATH
  "clang-tidy configuration used by the WSP build baseline"
)
unset(_wsp_default_clang_tidy_config)

function(_wsp_target_details target output_scope output_type)
  if(NOT TARGET "${target}")
    message(FATAL_ERROR "WSP build baseline target does not exist: ${target}")
  endif()

  get_target_property(_alias_target "${target}" ALIASED_TARGET)
  if(_alias_target)
    message(
      FATAL_ERROR
      "Apply the WSP build baseline to ${_alias_target}, not alias ${target}"
    )
  endif()

  get_target_property(_imported "${target}" IMPORTED)
  if(_imported)
    message(
      FATAL_ERROR
      "The WSP build baseline cannot modify imported target ${target}"
    )
  endif()

  get_target_property(_target_type "${target}" TYPE)
  if(_target_type STREQUAL "INTERFACE_LIBRARY" OR
      _target_type STREQUAL "UTILITY")
    message(
      FATAL_ERROR
      "The WSP build baseline requires a compiled target: ${target}"
    )
  endif()

  set("${output_scope}" PRIVATE PARENT_SCOPE)
  set("${output_type}" "${_target_type}" PARENT_SCOPE)
endfunction()

function(_wsp_enabled_languages output)
  set(_languages)
  if(CMAKE_C_COMPILER_LOADED)
    list(APPEND _languages C)
  endif()
  if(CMAKE_CXX_COMPILER_LOADED)
    list(APPEND _languages CXX)
  endif()
  if(NOT _languages)
    message(
      FATAL_ERROR
      "The WSP build baseline requires the C or CXX language"
    )
  endif()
  set("${output}" "${_languages}" PARENT_SCOPE)
endfunction()

function(_wsp_compiler_family language output)
  set(_id_variable "CMAKE_${language}_COMPILER_ID")
  set(_frontend_variable "CMAKE_${language}_COMPILER_FRONTEND_VARIANT")
  set(_compiler_id "${${_id_variable}}")
  set(_frontend "${${_frontend_variable}}")

  if(_compiler_id STREQUAL "MSVC" OR _frontend STREQUAL "MSVC")
    set(_family MSVC)
  elseif(_compiler_id STREQUAL "TinyCC")
    set(_family TinyCC)
  elseif(_compiler_id MATCHES "^(GNU|Clang|AppleClang|IntelLLVM)$")
    set(_family GNU)
  else()
    set(_family Unsupported)
  endif()

  set("${output}" "${_family}" PARENT_SCOPE)
endfunction()

function(_wsp_add_compile_options target scope language)
  foreach(_option IN LISTS ARGN)
    target_compile_options(
      "${target}"
      ${scope}
      "$<$<COMPILE_LANGUAGE:${language}>:${_option}>"
    )
  endforeach()
endfunction()

function(wsp_enable_build_warnings target)
  _wsp_target_details("${target}" _scope _target_type)
  _wsp_enabled_languages(_languages)

  foreach(_language IN LISTS _languages)
    _wsp_compiler_family("${_language}" _family)
    if(_family STREQUAL "MSVC")
      _wsp_add_compile_options(
        "${target}"
        "${_scope}"
        "${_language}"
        /W4
      )
    elseif(_family STREQUAL "TinyCC")
      _wsp_add_compile_options(
        "${target}"
        "${_scope}"
        "${_language}"
        -Wall
        -Wunsupported
        -Werror
      )
    elseif(_family STREQUAL "GNU")
      _wsp_add_compile_options(
        "${target}"
        "${_scope}"
        "${_language}"
        -Wall
        -Wextra
        -Wpedantic
      )
    else()
      message(
        FATAL_ERROR
        "No WSP warning baseline exists for ${_language} compiler "
        "${CMAKE_${_language}_COMPILER_ID}"
      )
    endif()
  endforeach()
endfunction()

function(wsp_enable_hardening target)
  _wsp_target_details("${target}" _scope _target_type)
  _wsp_enabled_languages(_languages)
  set(_families)

  foreach(_language IN LISTS _languages)
    _wsp_compiler_family("${_language}" _family)
    list(APPEND _families "${_family}")

    if(_family STREQUAL "MSVC")
      _wsp_add_compile_options(
        "${target}"
        "${_scope}"
        "${_language}"
        /GS
        /guard:cf
      )
      if(CMAKE_${_language}_COMPILER_ID STREQUAL "MSVC")
        _wsp_add_compile_options(
          "${target}"
          "${_scope}"
          "${_language}"
          /sdl
        )
      endif()
    elseif(_family STREQUAL "GNU")
      _wsp_add_compile_options(
        "${target}"
        "${_scope}"
        "${_language}"
        -fstack-protector-strong
      )
      if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
        string(
          CONCAT _fortify_expression
          "$<$<AND:$<COMPILE_LANGUAGE:${_language}>,"
          "$<OR:$<CONFIG:Release>,$<CONFIG:RelWithDebInfo>,"
          "$<CONFIG:MinSizeRel>>>:_FORTIFY_SOURCE=2>"
        )
        target_compile_definitions(
          "${target}"
          ${_scope}
          "${_fortify_expression}"
        )
        if(_target_type STREQUAL "EXECUTABLE")
          _wsp_add_compile_options(
            "${target}"
            "${_scope}"
            "${_language}"
            -fPIE
          )
        endif()
      endif()
    elseif(_family STREQUAL "TinyCC")
      if(WSP_REQUIRE_STACK_PROTECTION)
        message(
          FATAL_ERROR
          "TinyCC cannot emit stack canaries required by "
          "WSP_REQUIRE_STACK_PROTECTION. Use a hardened GCC, Clang, or MSVC "
          "release configuration."
        )
      endif()
      if(WSP_TINYCC_BOUNDS_CHECKING)
        string(
          CONCAT _bounds_expression
          "$<$<AND:$<COMPILE_LANGUAGE:${_language}>,"
          "$<CONFIG:Debug>>:-b>"
        )
        target_compile_options(
          "${target}"
          ${_scope}
          "${_bounds_expression}"
        )
      endif()
    else()
      message(
        FATAL_ERROR
        "No WSP hardening baseline exists for ${_language} compiler "
        "${CMAKE_${_language}_COMPILER_ID}. Disable it only with an "
        "approved tailoring decision."
      )
    endif()
  endforeach()

  list(REMOVE_DUPLICATES _families)
  list(LENGTH _families _family_count)
  if(_family_count GREATER 1)
    message(
      FATAL_ERROR
      "Mixed compiler families are not supported by WSP hardening: "
      "${_families}"
    )
  endif()
  list(GET _families 0 _family)

  set(_linkable FALSE)
  if(_target_type STREQUAL "EXECUTABLE" OR
      _target_type STREQUAL "SHARED_LIBRARY" OR
      _target_type STREQUAL "MODULE_LIBRARY")
    set(_linkable TRUE)
  endif()

  if(_linkable AND _family STREQUAL "MSVC")
    target_link_options(
      "${target}"
      ${_scope}
      /DYNAMICBASE
      /NXCOMPAT
      /guard:cf
    )
    if(CMAKE_SIZEOF_VOID_P EQUAL 8)
      target_link_options("${target}" ${_scope} /HIGHENTROPYVA)
    endif()
  elseif(_linkable AND _family STREQUAL "GNU")
    if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
      target_link_options(
        "${target}"
        ${_scope}
        LINKER:-z,relro
        LINKER:-z,now
        LINKER:-z,noexecstack
      )
      if(_target_type STREQUAL "EXECUTABLE")
        target_link_options("${target}" ${_scope} -pie)
      endif()
    elseif(MINGW)
      target_link_options(
        "${target}"
        ${_scope}
        LINKER:--dynamicbase
        LINKER:--nxcompat
      )
      if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        target_link_options(
          "${target}"
          ${_scope}
          LINKER:--high-entropy-va
        )
      endif()
    elseif(NOT APPLE)
      message(
        FATAL_ERROR
        "WSP GNU-style linker hardening is not defined for "
        "${CMAKE_SYSTEM_NAME}. Disable it only with an approved tailoring "
        "decision."
      )
    endif()
  elseif(_linkable AND _family STREQUAL "TinyCC")
    if(WIN32)
      target_link_options(
        "${target}"
        ${_scope}
        -Wl,-dynamicbase
        -Wl,-nxcompat
      )
      if(CMAKE_SIZEOF_VOID_P EQUAL 8)
        target_link_options(
          "${target}"
          ${_scope}
          -Wl,-high-entropy-va
        )
      endif()
    elseif(NOT CMAKE_SYSTEM_NAME STREQUAL "Linux")
      message(
        FATAL_ERROR
        "WSP TinyCC linker hardening is not defined for "
        "${CMAKE_SYSTEM_NAME}. Disable it only with an approved tailoring "
        "decision."
      )
    endif()
    if(WSP_TINYCC_BOUNDS_CHECKING AND
        _target_type STREQUAL "EXECUTABLE")
      target_link_options(
        "${target}"
        ${_scope}
        "$<$<CONFIG:Debug>:-b>"
      )
    endif()
  endif()
endfunction()

function(_wsp_find_clang_tidy output)
  if(WSP_CLANG_TIDY_EXECUTABLE)
    if(IS_ABSOLUTE "${WSP_CLANG_TIDY_EXECUTABLE}")
      set(_clang_tidy "${WSP_CLANG_TIDY_EXECUTABLE}")
    else()
      find_program(
        _clang_tidy
        NAMES "${WSP_CLANG_TIDY_EXECUTABLE}"
      )
    endif()
  else()
    find_program(_clang_tidy NAMES clang-tidy)
  endif()

  if(NOT _clang_tidy OR NOT EXISTS "${_clang_tidy}")
    message(
      FATAL_ERROR
      "WSP static analysis requires clang-tidy. Set "
      "WSP_CLANG_TIDY_EXECUTABLE to its absolute path."
    )
  endif()

  execute_process(
    COMMAND "${_clang_tidy}" --version
    RESULT_VARIABLE _version_result
    OUTPUT_QUIET
    ERROR_QUIET
  )
  if(NOT _version_result EQUAL 0)
    message(
      FATAL_ERROR
      "clang-tidy did not execute successfully: ${_clang_tidy}"
    )
  endif()

  set("${output}" "${_clang_tidy}" PARENT_SCOPE)
endfunction()

function(wsp_enable_static_analysis target)
  _wsp_target_details("${target}" _scope _target_type)
  _wsp_enabled_languages(_languages)
  _wsp_find_clang_tidy(_clang_tidy)

  if(NOT EXISTS "${WSP_CLANG_TIDY_CONFIG}")
    message(
      FATAL_ERROR
      "WSP clang-tidy configuration does not exist: "
      "${WSP_CLANG_TIDY_CONFIG}"
    )
  endif()

  if(NOT CMAKE_GENERATOR MATCHES "(^Ninja|Makefiles|WMake)")
    message(
      FATAL_ERROR
      "CMake generator '${CMAKE_GENERATOR}' does not execute the "
      "<LANG>_CLANG_TIDY target property. Use Ninja or a Makefile generator "
      "for the required WSP analysis build."
    )
  endif()

  set(
    _clang_tidy_command
    "${_clang_tidy}"
    "--config-file=${WSP_CLANG_TIDY_CONFIG}"
    "--warnings-as-errors=*"
    "--extra-arg=-Wno-unknown-warning-option"
  )
  foreach(_language IN LISTS _languages)
    set(_property "${_language}_CLANG_TIDY")
    get_target_property(_existing "${target}" "${_property}")
    if(_existing)
      message(
        FATAL_ERROR
        "${target} already defines ${_property}; WSP will not silently "
        "replace an analyzer configuration"
      )
    endif()
    set_property(
      TARGET "${target}"
      PROPERTY "${_property}" "${_clang_tidy_command}"
    )
  endforeach()
endfunction()

function(wsp_apply_build_baseline target)
  if(WSP_REQUIRE_STACK_PROTECTION AND NOT WSP_ENABLE_HARDENING)
    message(
      FATAL_ERROR
      "WSP_REQUIRE_STACK_PROTECTION requires WSP_ENABLE_HARDENING=ON"
    )
  endif()
  if(WSP_TINYCC_BOUNDS_CHECKING AND NOT WSP_ENABLE_HARDENING)
    message(
      FATAL_ERROR
      "WSP_TINYCC_BOUNDS_CHECKING requires WSP_ENABLE_HARDENING=ON"
    )
  endif()
  if(WSP_ENABLE_BUILD_WARNINGS)
    wsp_enable_build_warnings("${target}")
  endif()
  if(WSP_ENABLE_HARDENING)
    wsp_enable_hardening("${target}")
  endif()
  if(WSP_ENABLE_STATIC_ANALYSIS)
    wsp_enable_static_analysis("${target}")
  endif()
endfunction()
