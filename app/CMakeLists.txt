# CMakeLists.txt for the app module

set(APPNAME ${PROJECT_NAME})

message(STATUS "[Application: ${APPNAME}] Module Processing...")

# Collect files without having to explicitly list each header and source file
file(GLOB APP_HEADERS
  "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
  "${CMAKE_CURRENT_SOURCE_DIR}/*.hpp")

file(GLOB APP_SOURCES
  "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
  "${CMAKE_CURRENT_SOURCE_DIR}/*.cc")

# Create named folders for the sources within the project
source_group("header" FILES ${APP_HEADERS})
source_group("src" FILES ${APP_SOURCES})

# Set Properties->General->Configuration Type to Dynamic Library (.dll/.so/.dylib)
add_executable(${APPNAME} ${APP_HEADERS} ${APP_SOURCES}) # for dynamic library use SHARED

target_include_directories(${APPNAME} PUBLIC
						   ${CMAKE_CURRENT_SOURCE_DIR}
						   ${CMAKE_SOURCE_DIR}/Bank/
						   ${CMAKE_SOURCE_DIR}/BankAccount/
						   )
############# etc....

# Add any dependencies or compile options specific to lock6g
target_link_libraries(${APPNAME} PRIVATE Bank BankAccount nlohmann_json)
############# etc....

# Set the compile warnings options if enabled
if(${ENABLE_WARNINGS})
    target_set_warnings(
        TARGET ${APPNAME}
        ENABLE ${ENABLE_WARNINGS}
        AS_ERRORS ${ENABLE_WARNINGS_AS_ERRORS})
endif()


install(TARGETS ${APPNAME}
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin )
		
message(STATUS "[Application: ${APPNAME}] Added Executable target: ${APPNAME}")
