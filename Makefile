#
# Helper script to build the project using CMake and CI/CD pipelines
#

# Variables
BUILD_DIR := build

.PHONY: all install dependency clean-cache-reconfigure build run clean doc test

all: install dependency clean-cache-reconfigure build run doc test

# Install dependencies
dependency:
	@echo "Installing dependencies..."
ifeq ($(OS), Windows_NT)
	@choco install gcc g++ cmake llvm ninja doxygen graphviz clang-format  lcov
else
	@sudo apt-get install -y gcc g++ cmake llvm ninja-build doxygen graphviz clang-format texlive
endif

# Dependency graph generation
dep_graph:
	@echo "Generating dependency graph..."
	@mkdir -p $(BUILD_DIR)
	@cd $(BUILD_DIR) && cmake .. --graphviz=graph.dot
	@dot -Tpng $(BUILD_DIR)/graph.dot -o $(BUILD_DIR)/graphImage.png

# Prepare the build directory
clean:
	@echo "Preparing build directory..."
	@rm -rf $(BUILD_DIR)
	@mkdir $(BUILD_DIR)

# Clean cache and reconfigure
clean-cache-reconfigure:
	@echo "Cleaning cache and reconfiguring..."
	@rm -rf $(BUILD_DIR)/CMakeCache.txt $(BUILD_DIR)/CMakeFiles $(BUILD_DIR)/Makefile $(BUILD_DIR)/cmake_install.cmake
	@cmake -S . -B $(BUILD_DIR) -DCMAKE_BUILD_TYPE=Debug -G "Ninja"

# Build the project
build: 
	@echo "Building the project..."
	@cd $(BUILD_DIR) && cmake .. && cmake --build . --config Debug -j 4

# Run the project
run:
	@echo "Running the project..."
ifeq ($(OS), Windows_NT)
	@./$(BUILD_DIR)/build/Debug/*.exe
else
	@./$(BUILD_DIR)/build/Debug/*
endif

# Generate documentation (custom target)
html:
	@echo "Generating html doxygen documentation..."
	@cd $(BUILD_DIR) && cmake --build . --target html

pdf:
	@echo "Generating pdf-latex doxygen documentation..."
	@cd $(BUILD_DIR) && cmake --build . --target pdf

doc: html pdf
	@echo "All Documentation generated successfully!"

# Run tests
test:
	@echo "Running tests..."
	@cd $(BUILD_DIR) && ctest --output-on-failure


diagrams: build

ifeq ($(OS), Windows_NT)
	@echo "Generating diagrams..."
	mkdir -p docs/diagrams/plantuml 
	mkdir -p docs/diagrams/mermaid
	clang-uml -g plantuml -g json -g mermaid -p
	@echo "Convert .puml files to svg images"
	plantuml -tsvg -nometadata -o plantuml docs/diagrams/*.puml
	@echo "Convert .mmd files to svg images"
	py util/generate_mermaid.py docs/diagrams/*.mmd
	@echo "Format generated SVG files..."
	py util/format_svg.py docs/diagrams/plantuml/*.svg
	py util/format_svg.py docs/diagrams/mermaid/*.svg
else
	@echo "installing dependencies..."
	sudo apt-get install -y plantuml npm python3 python3-pip python3-yaml 
	npm install -g mermaid.cli
	pip install pyyaml
	@echo "installing clang-uml..."

	sudo add-apt-repository ppa:bkryza/clang-uml
	sudo apt update
	sudo apt install clang-uml
	@echo "Generating diagrams..."
	mkdir -p docs/diagrams/plantuml 
	mkdir -p docs/diagrams/mermaid
	clang-uml -g plantuml -g json -g mermaid -p
	@echo "Convert .puml files to svg images"
	plantuml -tsvg -nometadata -o plantuml docs/diagrams/*.puml
	@echo "Convert .mmd files to svg images"
	py util/generate_mermaid.py docs/diagrams/*.mmd
	@echo "Format generated SVG files..."
	py util/format_svg.py docs/diagrams/plantuml/*.svg
	py util/format_svg.py docs/diagrams/mermaid/*.svg
endif