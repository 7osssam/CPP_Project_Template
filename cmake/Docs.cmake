# Docs.cmake file
# ===========================================
#             Doxygen Configuration
# ===========================================

# Check if Doxygen is installed
find_package(Doxygen REQUIRED)

# Check if pdflatex is installed
find_program(PDFLATEX pdflatex)

# Helper functions to convert paths between Windows and Linux (will be used in Doxyfile.in)
macro(path_linux_to_win MsysPath ResultingPath)
  string(REGEX REPLACE "^/([a-zA-Z])/" "\\1:/" ${ResultingPath} "${MsysPath}")
endmacro()
macro(path_win_to_linux MsysPath ResultingPath)
  string(REGEX REPLACE "^([a-zA-Z]):/" "/\\1/" ${ResultingPath} "${MsysPath}")
endmacro()

if (DOXYGEN_FOUND)

	# Add git submodule for doxygen-awesome-css
	add_git_submodule(docs/doxygen/doxygen-awesome https://github.com/jothepro/doxygen-awesome-css)

    set(DOXYGEN_OUTPUT_DIR ${CMAKE_SOURCE_DIR}/docs/doxygen)
    set(DOCS_LATEX_PATH ${CMAKE_SOURCE_DIR}/docs/doxygen/latex)
	set(AWESOME_DOXYGEN_PATH ${CMAKE_SOURCE_DIR}/docs/doxygen/doxygen-awesome)

    # Ensure the documentation directories exist
    file(MAKE_DIRECTORY ${DOXYGEN_OUTPUT_DIR})
    file(MAKE_DIRECTORY ${DOCS_LATEX_PATH})

    # Convert paths based on running OS
    if (WIN32)
        path_linux_to_win(${CMAKE_SOURCE_DIR} CMAKE_SOURCE_DIR_CONVERTED)
        path_linux_to_win(${DOXYGEN_OUTPUT_DIR} DOXYGEN_OUTPUT_DIR_CONVERTED)
        path_linux_to_win(${DOCS_LATEX_PATH} DOCS_LATEX_PATH_CONVERTED)
		path_linux_to_win(${AWESOME_DOXYGEN_PATH} AWESOME_DOXYGEN_PATH_CONVERTED)
    elseif(UNIX)
        path_win_to_linux(${CMAKE_SOURCE_DIR} CMAKE_SOURCE_DIR_CONVERTED)
        path_win_to_linux(${DOXYGEN_OUTPUT_DIR} DOXYGEN_OUTPUT_DIR_CONVERTED)
        path_win_to_linux(${DOCS_LATEX_PATH} DOCS_LATEX_PATH_CONVERTED)
		path_win_to_linux(${AWESOME_DOXYGEN_PATH} AWESOME_DOXYGEN_PATH_CONVERTED)
    endif()


    # Set input and output paths for Doxyfile
    set(doxyfile_in ${CMAKE_SOURCE_DIR}/docs/doxygen/Doxyfile.in)
    set(doxyfile ${DOXYGEN_OUTPUT_DIR}/Doxyfile)
    configure_file(${doxyfile_in} ${doxyfile} @ONLY)

    add_custom_target(html 
        COMMAND ${CMAKE_COMMAND} -E echo "Generating API documentation with Doxygen..."
        COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile} > ${CMAKE_BINARY_DIR}/doxygen_output.log 2>&1
        WORKING_DIRECTORY ${DOXYGEN_OUTPUT_DIR}
        BYPRODUCTS ${DOXYGEN_OUTPUT_DIR}/html/index.html
        COMMENT "Generating API documentation with Doxygen"
        VERBATIM
    )

    if (PDFLATEX)
        add_custom_target(pdf
            COMMAND ${DOXYGEN_EXECUTABLE} ${doxyfile} > ${CMAKE_BINARY_DIR}/doxygen_pdf_output.log 2>&1
            COMMAND pdflatex -interaction=nonstopmode -output-directory ${DOCS_LATEX_PATH} ${DOCS_LATEX_PATH}/refman.tex > ${CMAKE_BINARY_DIR}/pdflatex_output.log 2>&1
            WORKING_DIRECTORY ${DOCS_LATEX_PATH}
			BYPRODUCTS ${DOCS_LATEX_PATH}/refman.pdf
            COMMENT "Generating PDF documentation with Doxygen and LaTeX"
            VERBATIM
        )
	
    else()
        message(WARNING "pdflatex not found. PDF generation disabled.")
    endif()

    # Add a target to generate both documentation and PDF
    add_custom_target(all_docs
        DEPENDS html pdf
        COMMENT "Generating both HTML and PDF documentation"
    )

    # Add a target to generate the html documentation
    add_custom_command(TARGET html POST_BUILD
        COMMAND echo "Documentation generated in ${DOXYGEN_OUTPUT_DIR}/html/index.html"
    )
	add_custom_command(TARGET pdf POST_BUILD
		COMMAND echo "PDF documentation generated in ${DOCS_LATEX_PATH}/refman.pdf"
	)

endif()
