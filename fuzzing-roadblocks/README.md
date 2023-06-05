# Strategies for overcoming fuzzing roadblocks

In many projects there are places where fuzzers can get stuck. This can happen for example when the software under test performs very specific checks on the input data before processing it further. For example, the validation of a checksum could be such a "fuzzing roadblock" or sometimes also simply a check for specific magic header bytes. In this example here, we will have a look at the software "pngcheck". Let's start by running the fuzz test for a while:
```sh
cifuzz run fuzztest
```

After running the fuzz test for a couple of minutes, we can have a look at the code coverage. To measure and export the coverage as an lcov file, use the following command:
```sh
cifuzz coverage -v --format=lcov -o lcov.info fuzztest
```

The [Coverage Gutters](https://marketplace.visualstudio.com/items?itemName=ryanluker.vscode-coverage-gutters) extension for VS Code let's us then see which parts of the software were covered and which not.
