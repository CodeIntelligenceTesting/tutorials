# README

This example shows how important it is to reset the state of the software
under test when fuzzing stateful applications.

## Requirements

This tutorial has the following requirements:

- [CI Fuzz](https://github.com/CodeIntelligenceTesting/cifuzz)
- CMake >= 3.16

## Running this example

Run fuzz test with:

```bash
cifuzz run stateful_example_1
```

The fuzzer will most likely not find the bug in the application as it
the tested demo application requires multiple conditions to be met to crash.

Check coverage:

```bash
cifuzz coverage stateful_example_1 -f lcov -o lcov.info
```

To mitigate that, we can run the fuzz test with a dictionary:

```bash
cifuzz run stateful_example_1 --dict="dictionary.txt"
```

Now the fuzzer will find the bug after a while.
However, reproducing the finding won't be possible (in most cases).
Try to reproduce the finding via:

```bash
NO_CIFUZZ=1 ./.cifuzz-build/libfuzzer/address+undefined/stateful_example_1 stateful_example_1_inputs/{finding_name}
```

When reproducing the crash is not possible that is due to the fuzz test not taking
global application state into account. Only the combination of a specific input and
a particular global state lead to a crash.
In case the crash was reproducible for you, you were lucky enough to hit that specific
case. To test further delete the `stateful_example_1_inputs` directory and run
the fuzz test with the dictionary again to re-find the crash and check if it's
still reproducible.

Next, run the modified fuzz test that resets global variable state on every iteration:

```bash
cifuzz run stateful_example_2
```

This should lead to another reported crash after at most a few minutes.
Now, try to reproduce the finding

```bash
NO_CIFUZZ=1 ./.cifuzz-build/libfuzzer/address+undefined/stateful_example_2 stateful_example_2_inputs/{finding_name}
```

The finding can now be reproduced reliably.
