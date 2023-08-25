# README

This example shows how the instrumentation of your fuzzed Java code
can be controlled. In default mode the Jazzer agent will insert coverage
markers into the JVM bytecode during class loading. If you want to exclude
specific parts of the target code you can use `--instrumentation_excludes`
to exclude classes:

- exclude a specific class with ```--instrumentation_excludes=com.example2.IgnoreMe```
- exclude multiple specific classes with ```--instrumentation_excludes=com.example2.IgnoreMe:com.example3.IgnoreMe```
- exclude multiple classes under classpath with ```--instrumentation_excludes=com.example2.**```.

## Requirements

This tutorial has the following requirements:

- [CI Fuzz](https://github.com/CodeIntelligenceTesting/cifuzz)
- maven

## Running this example

To run this tutorial, execute the following commands.

```bash
cifuzz run com.example.FuzzTestCase
```
