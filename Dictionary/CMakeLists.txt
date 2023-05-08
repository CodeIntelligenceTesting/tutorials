project(dictionary)
cmake_minimum_required(VERSION 3.16)

find_package(cifuzz NO_SYSTEM_ENVIRONMENT_PATH)
enable_fuzz_testing()

add_fuzz_test(dictionary_example dictionary_example.cpp)