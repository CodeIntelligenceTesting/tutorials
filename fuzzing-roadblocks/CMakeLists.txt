cmake_minimum_required(VERSION 3.16)
include(FetchContent)
project(PngcheckFuzzing)

# Enable cifuzz
find_package(cifuzz)
enable_fuzz_testing()

# Obtain the pngcheck source code
set(PNGCHECK_PRJ "pngcheck-3.0.3")
set(PNGCHECK_DIR "${CMAKE_BINARY_DIR}/${PNGCHECK_PRJ}")
FetchContent_Declare(pngcheck
    URL "http://www.libpng.org/pub/png/src/${PNGCHECK_PRJ}.tar.gz"
    URL_HASH SHA256=c36a4491634af751f7798ea421321642f9590faa032eccb0dd5fb4533609dee6
    SOURCE_DIR ${PNGCHECK_DIR}
    DOWNLOAD_EXTRACT_TIMESTAMP TRUE
)
if(NOT EXISTS ${PNGCHECK_DIR})
    FetchContent_Populate(pngcheck)
    # Rename the main function, so that we can
    # later link the fuzzer with its own main.
    execute_process(WORKING_DIRECTORY ${PROJECT_SOURCE_DIR} 
        COMMAND sed -i "s/int main(/int original_main(/g" "${PNGCHECK_DIR}/pngcheck.c"
    )
endif()

# Build target for our fuzz test
add_fuzz_test(fuzztest
    "fuzztest.cpp"
    "print_wrapper.c"
    "${PNGCHECK_DIR}/pngcheck.c"
)
target_link_options(fuzztest PRIVATE
    "-Wl,--wrap=printf"
    "-Wl,--wrap=fprintf"
)