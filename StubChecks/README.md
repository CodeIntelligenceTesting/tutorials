# README

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