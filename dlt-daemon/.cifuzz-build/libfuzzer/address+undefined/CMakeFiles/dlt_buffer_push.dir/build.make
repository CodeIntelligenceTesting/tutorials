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
include CMakeFiles/dlt_buffer_push.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/dlt_buffer_push.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/dlt_buffer_push.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/dlt_buffer_push.dir/flags.make

CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o: CMakeFiles/dlt_buffer_push.dir/flags.make
CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o: ../../../dlt_buffer_push.c
CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o: CMakeFiles/dlt_buffer_push.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o -MF CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o.d -o CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o -c /home/dae/testing/dlt-daemon/dlt_buffer_push.c

CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.i"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dae/testing/dlt-daemon/dlt_buffer_push.c > CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.i

CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.s"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dae/testing/dlt-daemon/dlt_buffer_push.c -o CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.s

CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o: CMakeFiles/dlt_buffer_push.dir/flags.make
CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o: /home/dae/.local/share/cifuzz/src/launcher.c
CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o: CMakeFiles/dlt_buffer_push.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o -MF CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o.d -o CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o -c /home/dae/.local/share/cifuzz/src/launcher.c

CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.i"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dae/.local/share/cifuzz/src/launcher.c > CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.i

CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.s"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dae/.local/share/cifuzz/src/launcher.c -o CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.s

CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o: CMakeFiles/dlt_buffer_push.dir/flags.make
CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o: /home/dae/.local/share/cifuzz/src/dumper.c
CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o: CMakeFiles/dlt_buffer_push.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o -MF CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o.d -o CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o -c /home/dae/.local/share/cifuzz/src/dumper.c

CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing C source to CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.i"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/dae/.local/share/cifuzz/src/dumper.c > CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.i

CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling C source to assembly CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.s"
	/usr/bin/clang $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/dae/.local/share/cifuzz/src/dumper.c -o CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.s

# Object files for target dlt_buffer_push
dlt_buffer_push_OBJECTS = \
"CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o" \
"CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o" \
"CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o"

# External object files for target dlt_buffer_push
dlt_buffer_push_EXTERNAL_OBJECTS =

dlt_buffer_push: CMakeFiles/dlt_buffer_push.dir/dlt_buffer_push.c.o
dlt_buffer_push: CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/launcher.c.o
dlt_buffer_push: CMakeFiles/dlt_buffer_push.dir/home/dae/.local/share/cifuzz/src/dumper.c.o
dlt_buffer_push: CMakeFiles/dlt_buffer_push.dir/build.make
dlt_buffer_push: src/daemon/libdlt-daemon-lib.a
dlt_buffer_push: CMakeFiles/dlt_buffer_push.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Linking C executable dlt_buffer_push"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/dlt_buffer_push.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/dlt_buffer_push.dir/build: dlt_buffer_push
.PHONY : CMakeFiles/dlt_buffer_push.dir/build

CMakeFiles/dlt_buffer_push.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/dlt_buffer_push.dir/cmake_clean.cmake
.PHONY : CMakeFiles/dlt_buffer_push.dir/clean

CMakeFiles/dlt_buffer_push.dir/depend:
	cd /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/dae/testing/dlt-daemon /home/dae/testing/dlt-daemon /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined /home/dae/testing/dlt-daemon/.cifuzz-build/libfuzzer/address+undefined/CMakeFiles/dlt_buffer_push.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/dlt_buffer_push.dir/depend

