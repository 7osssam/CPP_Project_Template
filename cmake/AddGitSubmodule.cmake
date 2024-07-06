# AddGitSubmodule.cmake

# Helper function to add a git submodule to a CMake project
# Usage: add_git_submodule(relative_dir url)
# relative_dir: The path to the submodule relative to the root of the project
# url: The URL of the git repository to clone

# Function to add a git submodule to the project
function(add_git_submodule relative_dir url)
    find_package(Git REQUIRED)

    set(FULL_DIR ${CMAKE_SOURCE_DIR}/${relative_dir})

    # Check if the directory exists
    if(NOT EXISTS ${FULL_DIR})
        message(STATUS "Cloning submodule ${relative_dir} from ${url}")

        # Clone the submodule
        execute_process(
            COMMAND ${GIT_EXECUTABLE} submodule add ${url} ${relative_dir}
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            RESULT_VARIABLE result
        )
        if(result)
            message(FATAL_ERROR "Failed to add submodule ${relative_dir} from ${url}")
        endif()
    elseif(NOT IS_DIRECTORY ${FULL_DIR})
        message(FATAL_ERROR "${FULL_DIR} exists but is not a directory.")
    endif()

    message(STATUS "Updating submodule ${relative_dir}")

    # Update the submodule
    execute_process(
        COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive ${relative_dir}
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE result
    )
    if(result)
        message(FATAL_ERROR "Failed to update submodule ${relative_dir}")
    endif()

    # Check if the submodule has a CMakeLists.txt file
    if(EXISTS ${FULL_DIR}/CMakeLists.txt)
        message(STATUS "Adding submodule directory to build: ${FULL_DIR}")
        add_subdirectory(${FULL_DIR})
    else()
        message(WARNING "Submodule ${relative_dir} does not contain a CMake project.")
		return()
    endif()
endfunction()
