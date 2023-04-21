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
include src/console/CMakeFiles/dlt-passive-node-ctrl.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include src/console/CMakeFiles/dlt-passive-node-ctrl.dir/compiler_depend.make

# Include the progress variables for this target.
include src/console/CMakeFiles/dlt-passive-node-ctrl.dir/progress.make

# Include the compile flags for this target's objects.
include src/console/CMakeFiles/dlt-passive-node-ctrl.dir/flags.make

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/flags.make
src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o: ../../../src/console/dlt-passive-node-ctrl.c
src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o -MF CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o.d -o CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o -c /home/dae/testing/dlt-daemon/src/console/dlt-passive-node-ctrl.c

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.i"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dae/testing/dlt-daemon/src/console/dlt-passive-node-ctrl.c > CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.i

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.s"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dae/testing/dlt-daemon/src/console/dlt-passive-node-ctrl.c -o CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.s

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/flags.make
src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o: ../../../src/console/dlt-control-common.c
src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o -MF CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o.d -o CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o -c /home/dae/testing/dlt-daemon/src/console/dlt-control-common.c

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.i"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dae/testing/dlt-daemon/src/console/dlt-control-common.c > CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.i

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.s"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && /usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dae/testing/dlt-daemon/src/console/dlt-control-common.c -o CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.s

# Object files for target dlt-passive-node-ctrl
dlt__passive__node__ctrl_OBJECTS = \
"CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o" \
"CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o"

# External object files for target dlt-passive-node-ctrl
dlt__passive__node__ctrl_EXTERNAL_OBJECTS =

src/console/dlt-passive-node-ctrl: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-passive-node-ctrl.c.o
src/console/dlt-passive-node-ctrl: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/dlt-control-common.c.o
src/console/dlt-passive-node-ctrl: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/build.make
src/console/dlt-passive-node-ctrl: src/lib/libdlt.so.2.18.5
src/console/dlt-passive-node-ctrl: src/console/CMakeFiles/dlt-passive-node-ctrl.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Linking C executable dlt-passive-node-ctrl"
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/dlt-passive-node-ctrl.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
src/console/CMakeFiles/dlt-passive-node-ctrl.dir/build: src/console/dlt-passive-node-ctrl
.PHONY : src/console/CMakeFiles/dlt-passive-node-ctrl.dir/build

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/clean:
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console && $(CMAKE_COMMAND) -P CMakeFiles/dlt-passive-node-ctrl.dir/cmake_clean.cmake
.PHONY : src/console/CMakeFiles/dlt-passive-node-ctrl.dir/clean

src/console/CMakeFiles/dlt-passive-node-ctrl.dir/depend:
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dae/testing/dlt-daemon /home/dae/testing/dlt-daemon/src/console /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/src/console/CMakeFiles/dlt-passive-node-ctrl.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/console/CMakeFiles/dlt-passive-node-ctrl.dir/depend

