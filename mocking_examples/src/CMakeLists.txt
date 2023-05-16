cmake_minimum_required(VERSION 3.16)
project(replacing_functions)

# Compile with debug symbols and without optimization
add_compile_options(-g -O0)

# Software under test as static and shared library
add_library(software_under_test_static STATIC Foo.cpp)
target_include_directories(software_under_test_static PUBLIC .)

add_library(software_under_test_shared SHARED Foo.cpp)
target_include_directories(software_under_test_shared PUBLIC .)

# Normal build
add_executable(normal_build main.cpp)
target_link_libraries(normal_build software_under_test_static)

# Wrapping Example
add_executable(wrapping_example main.cpp mocks/wrapper_mocks.cpp)
target_link_options(wrapping_example PRIVATE 
    "-Wl,--wrap=c_global_function,--wrap=_Z19cpp_global_functioni,--wrap=_ZN3bar3Foo26cpp_public_member_functionEi,--wrap=_ZNK3bar3Foo32cpp_public_const_member_functionEi,--wrap=_ZN3bar3Foo33cpp_public_static_member_functionEi"
)
target_link_libraries(wrapping_example software_under_test_static)

# LD_PRELOAD example
add_executable(ld_preload_example main.cpp)
target_link_libraries(ld_preload_example software_under_test_shared)

add_library(ld_preload_mocks SHARED mocks/ld_preload_mocks.cpp)
target_include_directories(ld_preload_mocks PUBLIC .)


add_executable(overwriting_example main.cpp mocks/overwriting_mocks.cpp)
target_link_libraries(overwriting_example software_under_test_static)
# Weaken and globalize all symbols we want to mock
add_custom_command(TARGET overwriting_example PRE_BUILD
    COMMAND objcopy
    --weaken-symbol=c_global_function
    --weaken-symbol=c_function_called_by_other_function
    --weaken-symbol=c_function_called_by_other_function_in_same_file
    --weaken-symbol=_Z19cpp_global_functioni
    --weaken-symbol=_ZN3bar3Foo26cpp_public_member_functionEi
    --weaken-symbol=_ZNK3bar3Foo32cpp_public_const_member_functionEi
    --weaken-symbol=_ZN3bar3Foo64cpp_public_member_function_called_by_other_function_in_same_fileEi
    --weaken-symbol=_ZN3bar3Foo27cpp_private_member_functionEi
    --weaken-symbol=_ZN3bar3Foo33cpp_public_static_member_functionEi
    $<TARGET_FILE:software_under_test_static>
    COMMENT "Enabling overwriting functions"
)
