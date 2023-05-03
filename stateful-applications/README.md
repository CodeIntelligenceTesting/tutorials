# README

Run fuzz test with:
```
cifuzz run stateful_example_1
```

Check coverage:
```
cifuzz coverage stateful_example_1 -f lcov -o lcov.info
```

Run with dictionary:
```
cifuzz run stateful_example_1 --dict="dictionary.txt"
```

Debug Finding
```
NO_CIFUZZ=1 ./.cifuzz-build/libfuzzer/address+undefined/stateful_example_1 stateful_example_1_inputs/{finding_name}
```

Run fuzz test that resets global variable:
```
cifuzz run stateful_example_2
```

Debug Finding
```
NO_CIFUZZ=1 ./.cifuzz-build/libfuzzer/address+undefined/stateful_example_2 stateful_example_2_inputs/{finding_name}
```