# README

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