# C++ Project Template with CMake

[![pages-build-deployment](https://github.com/7osssam/CPP_Project_Template/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/7osssam/CPP_Project_Template/actions/workflows/pages/pages-build-deployment)
[![Documentation](https://github.com/7osssam/CPP_Project_Template/actions/workflows/documentation.yml/badge.svg)](https://github.com/7osssam/CPP_Project_Template/actions/workflows/documentation.yml)
[![Ubuntu CI Test](https://github.com/7osssam/CPP_Project_Template/actions/workflows/Ubuntu.yml/badge.svg)](https://github.com/7osssam/CPP_Project_Template/actions/workflows/Ubuntu.yml)
![C++](https://img.shields.io/badge/c++-%2300599C.svg?style=for-the-badge&logo=c%2B%2B&logoColor=white)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
## Overview

This project template provides a robust foundation for C++ projects using CMake as the build system. It includes CI/CD integration, documentation setup with Doxygen, unit testing using Google Test, and modularized CMakeLists.txt for easy project management.

### Features

- **CI/CD Integration:** GitHub Actions workflows for Ubuntu CI (testing) and Documentation (GitHub Pages).
- **Documentation:** Doxygen setup with customizable Doxyfile.in for generating API documentation.
- **Unit Testing:** Google Test framework for writing and running unit tests.
- **Modular CMakeLists:** Abstracted CMakeLists.txt files for each module (app, user modules, test suite).
- **CMake Modules:** Includes modules for adding git submodules, enabling sanitizers, adding warning flags, etc.

## Folder Structure

```
├───.github
│   └───workflows
│       ├───documentation.yml   // GitHub Actions for Documentation (GitHub Pages)
│       └───Ubuntu.yml           // GitHub Actions for Ubuntu CI for Testing
├───app
│   ├───CMakeLists.txt           // CMakeLists for main app module
│   └───main.cpp
├───build                        // Default build directory
├───cmake
│   ├───AddGitSubmodule.cmake    // CMake module to add git submodules
│   ├───Docs.cmake               // CMake module to generate documentation
│   ├───Sanitizer.cmake          // CMake module to add sanitizer flags
│   └───Warnings.cmake           // CMake module to add warning flags
├───docs
│   ├───diagrams
│   │   ├───mermaid
│   │   └───plantuml
│   └───doxygen
│       └───Doxyfile.in          // Doxygen configuration file
├───lib
│   └───json                     // Sample lib submodule (can be replaced)
├───src
│   └───Module
│       └───CMakeLists.txt       // CMakeLists for user module
├───testing
│   ├───TS                       // Test Suite
│   │   └───CMakeLists.txt       // CMakeLists for test suite
│   ├───lib
│   │   └───googletest
│   └───test_suite
├───CMakeLists.txt           // Root CMakeLists.txt for project configuration
├─.clang-uml 				 // Clang UML configuration file
├─.clang-format 			 // Clang format configuration file
└─.clang-tidy 				 // Clang tidy configuration file
```

## Getting Started

1. **Clone the Repository:**
   ```
   https://github.com/7osssam/CPP_Project_Template
   cd CPP_Project_Template
   ```

2. **Install Dependencies:**
   ```
   make dependency
   ```

   This command installs necessary dependencies including compilers, CMake, LLVM, Ninja, Doxygen, Graphviz, and other tools based on your operating system.

3. **Prepare the Build Environment:**
   ```
   make clean-cache-reconfigure
   ```

   Cleans the cache and reconfigures the build environment using CMake, setting up for a Debug build with Ninja.

4. **Build the Project:**
   ```
   make build
   ```

   Configures and builds the project in Debug mode using CMake and Ninja.

5. **Run the Project:**
   ```
   make run
   ```

   Executes the compiled project executable. This command automatically detects the OS to run the correct executable file.

6. **Generate Documentation:**
   ```
   make doc
   ```

   Generates HTML and PDF documentation using Doxygen from the configured Doxyfile.in.

7. **Run Unit Tests:**
   ```
   make test
   ```

   Executes unit tests using Google Test framework.

8. **Generate Diagrams (Optional):**
<!-- https://clang-uml.github.io -->

   ```
   make diagrams
   ```
   -  Using [Clang UML](https://clang-uml.github.io) to generate UML diagrams from C++ code (Check `.clang-uml` file for configuration).

   Generates diagrams (PlantUML and Mermaid) from diagrams stored in `docs/diagrams`.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature/feature-name`).
3. Commit your changes (`git commit -am [Feature message]`).
4. Push to the branch (`git push origin feature/feature-name`).
5. Create a new Pull Request.

## TODO
- [ ] Add support for Windows CI/CD.
- [ ] Add support for macOS CI/CD.
- [ ] Add support for Code Coverage.
- [ ] Add support for Static Code Analysis (linting).

## License
Feel free to use this project template for your own projects.

This project is licensed under the [MIT License](LICENSE).
