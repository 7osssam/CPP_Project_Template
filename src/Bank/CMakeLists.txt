# CMakeLists.txt for Bank module
set(ROOT src)

get_filename_component(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR} NAME)
set(PROJECT_NAME ${PROJECT_ROOT})

set(LIBNAME ${PROJECT_NAME})

message(STATUS "[${ROOT}/${LIBNAME}] Module Processing...")

# Collect files without having to explicitly list each header and source file
file(GLOB LIB_HEADERS
  "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")

file(GLOB LIB_SOURCES
  "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")

# Create named folders for the sources within the project
source_group("header" FILES ${LIB_HEADERS})
source_group("src" FILES ${LIB_SOURCES})

# Set Properties->General->Configuration Type to Dynamic Library (.dll/.so/.dylib)
add_library(${LIBNAME} STATIC ${LIB_HEADERS} ${LIB_SOURCES}) # for dynamic library use SHARED

target_include_directories(${LIBNAME} PUBLIC
						   ${CMAKE_CURRENT_SOURCE_DIR}
						   ${CMAKE_SOURCE_DIR}/src/BankAccount
						   )
############# etc....

#target_link_libraries(${LIBNAME} PRIVATE Bank BankAccount nlohmann_json)
############# etc....

# Set the compile warnings options if enabled
if(${ENABLE_WARNINGS})
    target_set_warnings(
        TARGET ${LIBNAME}
        ENABLE ${ENABLE_WARNINGS}
        AS_ERRORS ${ENABLE_WARNINGS_AS_ERRORS})
endif()

# Add any dependencies or compile options for this library
# target_link_libraries(${LIBNAME} PRIVATE utility)

install(TARGETS ${LIBNAME}
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin )
		
# Export the target so other modules can use it 
# export(TARGETS ${LIBNAME} FILE ${LIBNAME}Targets.cmake)

message(STATUS "[${ROOT}/${LIBNAME}] Added library target: ${LIBNAME}")
