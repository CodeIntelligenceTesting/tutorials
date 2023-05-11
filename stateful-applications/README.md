# README

This example shows how important it is to reset the state of the software under test when fuzzing stateful applications.

## Requirements
This tutorial has the following requirements:
- [CI Fuzz](https://github.com/CodeIntelligenceTesting/cifuzz)
- CMake

## Running this example

Run fuzz test with:
```
cifuzz run stateful_example_1
```
The fuzzer will most likely not find the bug in the application.

Check coverage:
```
cifuzz coverage stateful_example_1 -f lcov -o lcov.info
```

Run with dictionary:
```
cifuzz run stateful_example_1 --dict="dictionary.txt"
```
Now the fuzzer will find the bug after a while. However, reproducing the issue with the "crashing input" identified by the fuzzer may not work.

Try to reproduce the finding
```
NO_CIFUZZ=1 ./.cifuzz-build/libfuzzer/address+undefined/stateful_example_1 stateful_example_1_inputs/{finding_name}
```
Most likely the the finding can not be reproduced.

Run fuzz test that resets global variable:
```
cifuzz run stateful_example_2
```

Try to reproduce the finding
```
NO_CIFUZZ=1 ./.cifuzz-build/libfuzzer/address+undefined/stateful_example_2 stateful_example_2_inputs/{finding_name}
```
The finding can now be reproduced reliably.