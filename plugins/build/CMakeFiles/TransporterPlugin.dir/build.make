# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.5

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
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
RM = /usr/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ccr/Desktop/IAI-project/plugins

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ccr/Desktop/IAI-project/plugins/build

# Include any dependencies generated for this target.
include CMakeFiles/TransporterPlugin.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/TransporterPlugin.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/TransporterPlugin.dir/flags.make

CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o: CMakeFiles/TransporterPlugin.dir/flags.make
CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o: ../TransporterPlugin.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ccr/Desktop/IAI-project/plugins/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o"
	/usr/bin/c++   $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o -c /home/ccr/Desktop/IAI-project/plugins/TransporterPlugin.cc

CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.i"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ccr/Desktop/IAI-project/plugins/TransporterPlugin.cc > CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.i

CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.s"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ccr/Desktop/IAI-project/plugins/TransporterPlugin.cc -o CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.s

CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.requires:

.PHONY : CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.requires

CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.provides: CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.requires
	$(MAKE) -f CMakeFiles/TransporterPlugin.dir/build.make CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.provides.build
.PHONY : CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.provides

CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.provides.build: CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o


# Object files for target TransporterPlugin
TransporterPlugin_OBJECTS = \
"CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o"

# External object files for target TransporterPlugin
TransporterPlugin_EXTERNAL_OBJECTS =

libTransporterPlugin.so: CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o
libTransporterPlugin.so: CMakeFiles/TransporterPlugin.dir/build.make
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_client.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_gui.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_sensors.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_rendering.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_physics.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_ode.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_transport.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_msgs.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_util.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_common.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_gimpact.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_opcode.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_opende_ou.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_math.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_ccd.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_program_options.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_regex.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_iostreams.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libpthread.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libprotobuf.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libsdformat.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libignition-math2.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreMain.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libpthread.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreTerrain.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libOgrePaging.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libignition-math2.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_program_options.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_regex.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_iostreams.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libpthread.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libprotobuf.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libsdformat.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreMain.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreTerrain.so
libTransporterPlugin.so: /usr/lib/x86_64-linux-gnu/libOgrePaging.so
libTransporterPlugin.so: CMakeFiles/TransporterPlugin.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ccr/Desktop/IAI-project/plugins/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libTransporterPlugin.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/TransporterPlugin.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/TransporterPlugin.dir/build: libTransporterPlugin.so

.PHONY : CMakeFiles/TransporterPlugin.dir/build

CMakeFiles/TransporterPlugin.dir/requires: CMakeFiles/TransporterPlugin.dir/TransporterPlugin.cc.o.requires

.PHONY : CMakeFiles/TransporterPlugin.dir/requires

CMakeFiles/TransporterPlugin.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/TransporterPlugin.dir/cmake_clean.cmake
.PHONY : CMakeFiles/TransporterPlugin.dir/clean

CMakeFiles/TransporterPlugin.dir/depend:
	cd /home/ccr/Desktop/IAI-project/plugins/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ccr/Desktop/IAI-project/plugins /home/ccr/Desktop/IAI-project/plugins /home/ccr/Desktop/IAI-project/plugins/build /home/ccr/Desktop/IAI-project/plugins/build /home/ccr/Desktop/IAI-project/plugins/build/CMakeFiles/TransporterPlugin.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/TransporterPlugin.dir/depend

