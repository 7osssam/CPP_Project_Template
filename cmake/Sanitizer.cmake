# Cmake function to set compiler sanitizer flags
# Author: franneck94

function(add_sanitizer_flags)
    if(NOT ENABLE_SANITIZE_ADDR AND NOT ENABLE_SANITIZE_UNDEF)
        return()
    endif()

    if(CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR CMAKE_CXX_COMPILER_ID MATCHES
                                                "GNU")
        add_compile_options("-fno-omit-frame-pointer")
        add_link_options("-fno-omit-frame-pointer")

        if(ENABLE_SANITIZE_ADDR)
            message(STATUS "Activating Address Sanitizer")
            add_compile_options("-fsanitize=address")
            add_link_options("-fsanitize=address")
        endif()

        if(ENABLE_SANITIZE_UNDEF)
            message(STATUS "Activating Undefined Sanitizer")
            add_compile_options("-fsanitize=undefined")
            add_link_options("-fsanitize=undefined")
        endif()

        if(ENABLE_SANITIZE_LEAK)
            add_compile_options("-fsanitize=leak")
            add_link_options("-fsanitize=leak")
        endif()

        if(ENABLE_SANITIZE_THREAD)
            if(ENABLE_SANITIZE_ADDR OR ENABLE_SANITIZE_LEAK)
                message(WARNING "thread does not work with: address and leak")
            endif()
            message(STATUS "Activating Thread Sanitizer")
            add_compile_options("-fsanitize=thread")
            add_link_options("-fsanitize=thread")
        endif()
    elseif(CMAKE_CXX_COMPILER_ID STREQUAL "MSVC")
        if(ENABLE_SANITIZE_ADDR)
            message(STATUS "Activating Address Sanitizer")
            add_compile_options("/fsanitize=address")
        endif()

        if(ENABLE_SANITIZE_UNDEF)
            message(STATUS "sanitize=undefined not avail. for MSVC")
        endif()

        if(ENABLE_SANITIZE_LEAK)
            message(STATUS "sanitize=leak not avail. for MSVC")
        endif()

        if(ENABLE_SANITIZE_THREAD)
            message(STATUS "sanitize=thread not avail. for MSVC")
        endif()
    else()
        message(WARNING "This sanitizer not supported in this environment")
        return()
    endif()
endfunction(add_sanitizer_flags)
