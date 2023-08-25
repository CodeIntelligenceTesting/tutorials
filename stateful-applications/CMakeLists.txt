project(stateful-applications)
cmake_minimum_required(VERSION 3.16)

find_package(cifuzz NO_SYSTEM_ENVIRONMENT_PATH)
enable_fuzz_testing()

add_library(SUT SUT.cpp)

add_fuzz_test(stateful_example_1 stateful_example_1.cpp)
target_link_libraries(stateful_example_1 SUT)

add_fuzz_test(stateful_example_2 stateful_example_2.cpp)
target_link_libraries(stateful_example_2 SUT)
