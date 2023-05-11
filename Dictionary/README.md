# README

This example shows how the usage of a dictionary can improve the results of a fuzz test. First the fuzz test will be executed without without a dictionary and without value_profile. Afterwards it is shown how dictionaries and value_profile can help the fuzzing engine to improve code coverage and uncover more bugs.

## Requirements
This tutorial has the following requirements:
- [CI Fuzz](https://github.com/CodeIntelligenceTesting/cifuzz)
- CMake

## Running this example
Run fuzz test with:
```
cifuzz run dictionary_example
```

Check coverage:
```
cifuzz coverage dictionary_example -f lcov -o lcov.info
```

Delete corpus:
```
./delete_corpus.sh
```

Run with value profile:
```
cifuzz run dictionary_example --engine-arg="-use_value_profile=1"
```

Delete corpus:
```
./delete_corpus.sh
```

Run with dictionary:
```
cifuzz run dictionary_example --dict="dictionary.txt"
```

You can also enable value profile or the use of a dictionary in the cifuzz.yaml file.