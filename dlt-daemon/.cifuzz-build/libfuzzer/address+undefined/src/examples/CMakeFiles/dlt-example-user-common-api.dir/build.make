# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.22

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/dae/testing/dlt-daemon

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined

# Include any dependencies generated for this target.
include src/examples/CMakeFiles/dlt-example-user-common-api.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/examples/CMakeFiles/dlt-example-user-common-api.dir/compiler_depend.make

# Include the progress variables for this target.
include src/examples/CMakeFiles/dlt-example-user-common-api.dir/progress.make

# Include the compile flags for this target's objects.
include src/examples/CMakeFiles/dlt-example-user-common-api.dir/flags.make

src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o: src/examples/CMakeFiles/dlt-example-user-common-api.dir/flags.make
src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o: ../../../src/examples/dlt-example-user-common-api.c
src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o: src/examples/CMakeFiles/dlt-example-user-common-api.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o -MF CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o.d -o CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o -c /home/dae/testing/dlt-daemon/src/examples/dlt-example-user-common-api.c

src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.i"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dae/testing/dlt-daemon/src/examples/dlt-example-user-common-api.c > CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.i

src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.s"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dae/testing/dlt-daemon/src/examples/dlt-example-user-common-api.c -o CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.s

# Object files for target dlt-example-user-common-api
dlt__example__user__common__api_OBJECTS = \
"CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o"

# External object files for target dlt-example-user-common-api
dlt__example__user__common__api_EXTERNAL_OBJECTS =

src/examples/dlt-example-user-common-api: src/examples/CMakeFiles/dlt-example-user-common-api.dir/dlt-example-user-common-api.c.o
src/examples/dlt-example-user-common-api: src/examples/CMakeFiles/dlt-example-user-common-api.dir/build.make
src/examples/dlt-example-user-common-api: src/lib/libdlt.so.2.18.5
src/examples/dlt-example-user-common-api: src/examples/CMakeFiles/dlt-example-user-common-api.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking C executable dlt-example-user-common-api"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/dlt-example-user-common-api.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/examples/CMakeFiles/dlt-example-user-common-api.dir/build: src/examples/dlt-example-user-common-api
.PHONY : src/examples/CMakeFiles/dlt-example-user-common-api.dir/build

src/examples/CMakeFiles/dlt-example-user-common-api.dir/clean:
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples && $(CMAKE_COMMAND) -P CMakeFiles/dlt-example-user-common-api.dir/cmake_clean.cmake
.PHONY : src/examples/CMakeFiles/dlt-example-user-common-api.dir/clean

src/examples/CMakeFiles/dlt-example-user-common-api.dir/depend:
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dae/testing/dlt-daemon /home/dae/testing/dlt-daemon/src/examples /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/examples/CMakeFiles/dlt-example-user-common-api.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/examples/CMakeFiles/dlt-example-user-common-api.dir/depend

