# Java mocking example

This example shows us how mocking some part of an application allows us to access new portions of the code that are by default not accessible because they require special conditions.

In this example, we mock the `UserRepository.findById` function so that it returns a valid `User` with an email that contains fuzzed data:
```java
Mockito.when(userRepository.findById(Mockito.any())).thenReturn(Optional.of(user));
```

This allow us to reach the second part of the `validateEmail` function which contains a vulnerable regex injection.


## How to run it
```
cifuzz run com.UserServiceFuzzer -v
```
