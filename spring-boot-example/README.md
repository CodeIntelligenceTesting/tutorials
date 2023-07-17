<div align="center">
<a href="https://www.code-intelligence.com/">
<img src="https://www.code-intelligence.com/hubfs/Logos/CI%20Logos/Logo_quer_white.png" alt="Code Intelligence logo" width="450px">
</a>
</div>

# API testing

Building robust APIs is an important and challenging endeavor that requires
thorough testing. While unit tests are indispensable to ensure the functional
correctness of APIs, they're not enough to address the security and reliability
issues. In unit testing, you test the scenarios that you are aware of. However,
there exist unknown scenarios unknown that lead to security vulnerabilities or
performance problems.

In this example, you perform automated API testing for security and reliability
issues with JUnit. This is enabled by the JUnit integration provided by CI Fuzz.

## Demo Spring Boot app

The demo app offers REST API endpoints, such as, `hello` that can be called with
`name` parameter, and it replies with `"Hello <name>!"`. The endpoint fails when
the provided name is equal to `attacker` ignoring case. This tutorial guides you
through the concepts and steps of using CI Fuzz with the JUnit 5 integration to
test this app. Further, it demonstrates how you can automatically find the
failing test case. 

### Set up the repository

Download or clone the following repository: [https://github.com/CodeIntelligenceTesting/tutorials/tree/main/spring-boot-example](https://github.com/CodeIntelligenceTesting/tutorials/tree/main/spring-boot-example)

Run the app as follows

```shell
mvn spring-boot:run
```

You can reach the endpoint at `http://localhost:8080/hello` and call it via
`http://localhost:8080/hello?name=foo`

## Unit tests

The project contains two unit tests that test the endpoint with two names
`Developer` and `Contributor`. This demonstrates how you would test your code
using specific inputs triggering specific behavior. You can run the unit tests

```shell
mvn test
```

## Fuzz tests

While unit tests provide a great value to make sure that your code is
functionally correct. However, there might be corner cases and interactions that
you aren't aware of that can cause security and reliability issues. To address
these cases, you create a fuzz test, which is a method annotated with
`@FuzzTest` and at least one parameter. Using a single parameter of type
[FuzzedDataProvider](https://codeintelligencetesting.github.io/jazzer-docs/jazzer-api/com/code_intelligence/jazzer/api/FuzzedDataProvider.html),
which provides utility functions to produce commonly used Java values, or
`byte[]`. CI Fuzz then executes with method in a loop and in each iteration
provide new inputs that maximize code coverage and trigger interesting behavior
in your app.

In this example, you create a fuzz test that uses the fuzzer input as the `name`
parameter for the `hello` API. This way, CI Fuzz can explore the different
possibilities of the parameter that trigger interesting behaviors, and thus
quickly finds the prepared issue by generating the `"attacker"` name.

```java
@WebMvcTest()
public class HelloEndpointTests {
    @Autowired private MockMvc mockMvc;
    ...
    @FuzzTest
    public void fuzzTestHello(FuzzedDataProvider data) throws Exception {
        String name = data.consumeRemainingAsString();
        mockMvc.perform(get("/hello").param("name", name));
    }
}
```

### Run your fuzz test

1. (Once) Install the CI Fuzz CLI named `cifuzz`. You can get the
   [latest release from GitHub](https://github.com/CodeIntelligenceTesting/cifuzz/releases/latest)
   or by running the install script:

   ```shell
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/CodeIntelligenceTesting/cifuzz/main/install.sh)"
   ```

   If you are using Windows you can download the
   [latest release](https://github.com/CodeIntelligenceTesting/cifuzz/releases/latest/download/cifuzz_installer_windows_amd64.exe)
   and execute it.

2. Login to [CI App](https://app.code-intelligence.com/)

   ```shell
   cifuzz login
   ```

   This creates an API access token that `cifuzz` uses to communicate with the
   CI App. When logged in, the `cifuzz` can provide more details about the
   findings including severity. You are also able to run your tests at scale
   with the Code Intelligences SaaS solution.

3. Run the fuzz test with CI Fuzz. For that you just need to provide the test
   class containing the fuzz test.

   ```shell
   > cifuzz com.example.HelloEndpointTests
   ▄ Build in progress... Done.

   Running com.example.HelloEndpointTests
   Storing generated corpus in .cifuzz-corpus/com.example.HelloEndpointTests
   Starting from an empty corpus

   Use 'cifuzz finding <finding name>' for details on a finding.

   💥 [agitated_wolf] Security Issue: Remote Code Execution in 
   insecureHello (com.example.GreeterApplication:41)

   Note: The reproducing inputs have been copied to the seed corpus at:

      src/test/resources/com/example/HelloEndpointTestsInputs/agitated_wolf

   They will now be used as a seed input for all runs of the fuzz test,
   including remote runs with artifacts created via 'cifuzz bundle' and
   regression tests. For more information on regression tests, see:

       https://github.com/CodeIntelligenceTesting/cifuzz/blob/main/docs/Regression-Testing.md

   Execution time: 11s
   Average exec/s: 2806
   Findings:       1
   Corpus entries: 2 (+2)
   ```

   CI Fuzz quickly generates a test case triggering the bug (aka crashing
   input). This test case is saved as a resource in your project and is
   automatically picked up when you execute your normal unit tests. That's when
   you execute `mvn test`, you execute all your unit tests in addition to the
   fuzz tests. In this scenario, CI Fuzz only executes the tests with the
   crashing inputs and inputs from the corpus it has collected during fuzzing.
   This way you can ensure that you quickly test for regressions.

4. You can check the finding details as follows

   ```shell
   cifuzz finding agitated_wolf
   ```

5. You can also check the code covered by CI Fuzz

   ```shell
   > cifuzz coverage com.example.HelloEndpointTests
   Building com.example.HelloEndpointTests
   ▄  Build in progress... Done.

   ✅ Coverage Report:
                                  File | Functions Hit/Found | Lines Hit/Found | Branches Hit/Found
   com/example/GreeterApplication.java |      2 / 5  (40.0%) | 5 / 29  (17.2%) |     2 / 6  (33.3%)
                                       |                     |                 |                   
                                       | Functions Hit/Found | Lines Hit/Found | Branches Hit/Found
                                 Total |               2 / 5 |          5 / 29 |              2 / 6
   
   ```

   In addition, you also get a `jacoco` coverage report that you can observe in
   your browser. Having a look at coverage report helps understand the testing
   progress and observe the code areas that CI Fuzz has not yet covered. This is
   valuable so that you can improve and optimize your tests.

# Conclusion

In this short tutorial, you used CI Fuzz to test your API. `cifuzz` offers many
more features, which you can learn more about by running `cifuzz help` command.