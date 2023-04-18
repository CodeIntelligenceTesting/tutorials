package com.example;

import com.code_intelligence.jazzer.api.FuzzedDataProvider;
import com.code_intelligence.jazzer.junit.FuzzTest;

public class ComplexTestCase {
    @FuzzTest
    void myFuzzTest(FuzzedDataProvider data) {
        ExploreMe.exploreComplexChecks(
                data.consumeLong(),
                data.consumeLong(),
                data.consumeRemainingAsBytes()
        );
    }
}
