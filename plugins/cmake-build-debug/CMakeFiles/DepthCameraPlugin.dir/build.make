# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.15

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
CMAKE_COMMAND = /home/ccr/Downloads/clion-2019.3/bin/cmake/linux/bin/cmake

# The command to remove a file.
RM = /home/ccr/Downloads/clion-2019.3/bin/cmake/linux/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/ccr/Desktop/IAI-project/plugins

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/ccr/Desktop/IAI-project/plugins/cmake-build-debug

# Include any dependencies generated for this target.
include CMakeFiles/DepthCameraPlugin.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/DepthCameraPlugin.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/DepthCameraPlugin.dir/flags.make

CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.o: CMakeFiles/DepthCameraPlugin.dir/flags.make
CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.o: ../DepthCameraPlugin.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/ccr/Desktop/IAI-project/plugins/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.o -c /home/ccr/Desktop/IAI-project/plugins/DepthCameraPlugin.cc

CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/ccr/Desktop/IAI-project/plugins/DepthCameraPlugin.cc > CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.i

CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/ccr/Desktop/IAI-project/plugins/DepthCameraPlugin.cc -o CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.s

# Object files for target DepthCameraPlugin
DepthCameraPlugin_OBJECTS = \
"CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.o"

# External object files for target DepthCameraPlugin
DepthCameraPlugin_EXTERNAL_OBJECTS =

libDepthCameraPlugin.so: CMakeFiles/DepthCameraPlugin.dir/DepthCameraPlugin.cc.o
libDepthCameraPlugin.so: CMakeFiles/DepthCameraPlugin.dir/build.make
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_client.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_gui.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_sensors.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_rendering.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_physics.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_ode.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_transport.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_msgs.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_util.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_common.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_gimpact.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_opcode.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_opende_ou.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_math.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libgazebo_ccd.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_program_options.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_regex.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_iostreams.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libprotobuf.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libsdformat.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libignition-math2.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreMain.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreTerrain.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libOgrePaging.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libignition-math2.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_thread.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_system.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_filesystem.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_program_options.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_regex.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_iostreams.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_date_time.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_chrono.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libboost_atomic.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libprotobuf.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libsdformat.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreMain.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libOgreTerrain.so
libDepthCameraPlugin.so: /usr/lib/x86_64-linux-gnu/libOgrePaging.so
libDepthCameraPlugin.so: CMakeFiles/DepthCameraPlugin.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/ccr/Desktop/IAI-project/plugins/cmake-build-debug/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX shared library libDepthCameraPlugin.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/DepthCameraPlugin.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/DepthCameraPlugin.dir/build: libDepthCameraPlugin.so

.PHONY : CMakeFiles/DepthCameraPlugin.dir/build

CMakeFiles/DepthCameraPlugin.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/DepthCameraPlugin.dir/cmake_clean.cmake
.PHONY : CMakeFiles/DepthCameraPlugin.dir/clean

CMakeFiles/DepthCameraPlugin.dir/depend:
	cd /home/ccr/Desktop/IAI-project/plugins/cmake-build-debug && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/ccr/Desktop/IAI-project/plugins /home/ccr/Desktop/IAI-project/plugins /home/ccr/Desktop/IAI-project/plugins/cmake-build-debug /home/ccr/Desktop/IAI-project/plugins/cmake-build-debug /home/ccr/Desktop/IAI-project/plugins/cmake-build-debug/CMakeFiles/DepthCameraPlugin.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/DepthCameraPlugin.dir/depend
