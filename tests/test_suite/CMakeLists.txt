# CMakeLists.txt for unit test (bank) directory
set(ROOT tests)

get_filename_component(PROJECT_ROOT ${CMAKE_CURRENT_SOURCE_DIR} NAME)
set(PROJECT_NAME ${PROJECT_ROOT})

set(EXENAME ${PROJECT_NAME}_tests)

message(STATUS "[${ROOT}/${PROJECT_NAME}] Module Tests...")

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

enable_testing()

# Define the target for bank tests
add_executable(${EXENAME} ${LIB_HEADERS} ${LIB_SOURCES})

# Add included headers
target_include_directories(${EXENAME} PUBLIC
							${CMAKE_SOURCE_DIR}/src/Bank  
							${CMAKE_SOURCE_DIR}/src/BankAccount
							${CMAKE_CURRENT_SOURCE_DIR}
						   )
############# etc....

# Link against Google Test libraries
target_link_libraries(${EXENAME} PRIVATE 
	GTest::gtest
  	GTest::gmock
  	GTest::gtest_main
  	GTest::gmock_main
)

# Add any dependencies or compile options specific to bank tests
target_link_libraries(${EXENAME} PUBLIC 
	Bank
	BankAccount 
)
############# etc....

# Set the compile warnings options if enabled
if(${ENABLE_WARNINGS})
    target_set_warnings(
        TARGET ${EXENAME}
        ENABLE ${ENABLE_WARNINGS}
        AS_ERRORS ${ENABLE_WARNINGS_AS_ERRORS})
endif()


# Register the test with CTest
add_test(
  NAME ${EXENAME}
  COMMAND ${EXENAME}
)


install(TARGETS ${EXENAME}
        LIBRARY DESTINATION lib
        ARCHIVE DESTINATION lib
        RUNTIME DESTINATION bin )

# Discover tests using CTest
include(GoogleTest)
gtest_discover_tests(${EXENAME})

		
message(STATUS "[${ROOT}/${PROJECT_NAME}] Added target: ${EXENAME}")
