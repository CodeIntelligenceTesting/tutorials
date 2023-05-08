project(stub_checks)
cmake_minimum_required(VERSION 3.16)

find_package(cifuzz NO_SYSTEM_ENVIRONMENT_PATH)
enable_fuzz_testing()

add_library(SUT SUT.cpp)
target_link_libraries(SUT z)


add_fuzz_test(stub_checks stub_checks.cpp)
target_link_libraries(stub_checks SUT)

add_library(ld_preload_crc32 SHARED ld_preload_crc32.cpp)