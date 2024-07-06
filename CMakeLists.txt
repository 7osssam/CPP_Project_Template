# CMakeLists.txt for the root directory of the project

# Set minimum CMake version
cmake_minimum_required(VERSION 3.20)

# Set Project Name
set (PROJECT_NAME "BankApp")

# Set Project Version
set (PROJECT_VERSION 1.0.0)

# Set Project Description
set (PROJECT_DESCRIPTION "Bank Application")

# Set supported languages
set(PROJECT_LANGUAGES C CXX)

# Set generator 
set(CMAKE_GENERATOR "Ninja" CACHE INTERNAL "" )

# Set project name
project(
	${PROJECT_NAME}
	VERSION ${PROJECT_VERSION}
	DESCRIPTION ${PROJECT_DESCRIPTION}
	LANGUAGES ${PROJECT_LANGUAGES}
	)


#==============================================================================
# Display project information
#==============================================================================
message(STATUS "[${PROJECT_NAME}] Project Name: ${PROJECT_NAME}")
message(STATUS "[${PROJECT_NAME}] Project Version: ${PROJECT_VERSION}")
message(STATUS "[${PROJECT_NAME}] Project Description: ${PROJECT_DESCRIPTION}")

message(STATUS "[${PROJECT_NAME}] CMake version ${CMAKE_VERSION}")

message(STATUS "[${PROJECT_NAME}] C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "[${PROJECT_NAME}] C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "[${PROJECT_NAME}] Build Type: ${CMAKE_BUILD_TYPE}")
message(STATUS "[${PROJECT_NAME}] C Compiler ID: ${CMAKE_C_COMPILER_ID}")
message(STATUS "[${PROJECT_NAME}] C++ Compiler ID: ${CMAKE_CXX_COMPILER_ID}")
message(STATUS "[${PROJECT_NAME}] Processor ${CMAKE_SYSTEM_PROCESSOR}")
message(STATUS "[${PROJECT_NAME}] Generator: ${CMAKE_GENERATOR}")

# GoogleTest requires at least C++11
if(NOT "${CMAKE_CXX_STANDARD}")
	set(CMAKE_CXX_STANDARD 11)
	set(CMAKE_CXX_STANDARD_REQUIRED ON)
	message(STATUS "[${PROJECT_NAME}] Default C++ Standard Selected: ${CMAKE_CXX_STANDARD}")
endif()

# Include standard headers in compile_commands.json (used by clang-uml)
set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})

# Generate compile_commands.json
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Set cmake Diagnostic colors
set(CMAKE_COLOR_DIAGNOSTICS ON)


#==============================================================================
# Project Options
#==============================================================================
option(ENABLE_TESTS "Enable All Tests" ON)
option(ENABLE_COVERAGE "Enable Coverage" ON) # TODO: Adding code coverage Support for this template

option(ENABLE_WARNINGS "Enable to add warnings to a target." OFF)
option(ENABLE_WARNINGS_AS_ERRORS "Enable to treat warnings as errors." OFF)

option(ENABLE_SANITIZE_ADDR "Enable address sanitize." OFF)
option(ENABLE_SANITIZE_UNDEF "Enable undefined sanitize." OFF)
option(ENABLE_SANITIZE_LEAK "Enable leak sanitize (Gcc/Clang only)." OFF)
option(ENABLE_SANITIZE_THREAD "Enable thread sanitize (Gcc/Clang only)." OFF)

set(CMAKE_CONFIGURATION_TYPES "Debug;Release" CACHE STRING "" FORCE)

# Set the output directories for Debug and Release configurations
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${CMAKE_BINARY_DIR}/build/Debug)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${CMAKE_BINARY_DIR}/build/Release)

#==============================================================================
# CMake Modules
#==============================================================================
set(CMAKE_MODULE_PATH "${PROJECT_SOURCE_DIR}/cmake/")

include(AddGitSubmodule)
include(Docs)


if(ENABLE_WARNINGS)
    include(Warnings)
endif()

if(ENABLE_SANITIZE_ADDR
   OR ENABLE_SANITIZE_UNDEF
   OR ENABLE_SANITIZE_LEAK
   OR ENABLE_SANITIZE_THREAD)
    include(Sanitizer)
    add_sanitizer_flags()
endif()


# Add your global submodules here
add_git_submodule(lib/json https://github.com/nlohmann/json)


# Add subdirectories
add_subdirectory(src) # user Modules 
add_subdirectory(app) # Application (main)

if (ENABLE_TESTS)
	enable_testing()
	add_subdirectory(testing)
	#if (ENABLE_COVERAGE)
		#include(CodeCoverage)
    	#append_coverage_compiler_flags()
	#endif()

endif()
