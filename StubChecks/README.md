# README
This example shows how disabling certain checks in the software under test can benefit a fuzz test. The function under tests expects the inputs to contain valid crc32 checksums. It can be difficult for the fuzzer to generate inputs with a correct checksum. While one solution for it might be creating a custom mutator, another solution is to just disable these checks since the goal of this fuzz test is not checking the crc32 checksum calculator.

Run fuzz test with:
```
cifuzz run stub_checks
```

Check coverage:
```
cifuzz coverage stub_checks -f lcov -o lcov.info
```

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