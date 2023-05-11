# README
This example shows how disabling certain checks in the software under test can benefit a fuzz test. The function under tests expects the inputs to contain valid crc32 checksums. It can be difficult for the fuzzer to generate inputs with a correct checksum. While one solution for it might be creating a custom mutator, another solution is to just disable these checks since the goal of this fuzz test is not checking the crc32 checksum calculator.

## Requirements
This tutorial has the following requirements:
- [CI Fuzz](https://github.com/CodeIntelligenceTesting/cifuzz)
- Linux
- CMake

Run fuzz test with:
```
cifuzz run stub_checks
```
The fuzzer will most likely not find the bug in the application.
Check coverage:
```
cifuzz coverage stub_checks -f lcov -o lcov.info
```
Prepare the stubs for the crc32 sum calculation:
Compile stubbed crc32 sum:
```
mkdir build && cd build
cmake ..
make ld_preload_crc32
cd ..
```

Execute with replaced crc32 calculation:
```
LD_PRELOAD=build/libld_preload_crc32.so cifuzz run stub_checks
```
Now the fuzz test can find the bug.