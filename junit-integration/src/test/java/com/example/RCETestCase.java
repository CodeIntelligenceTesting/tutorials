package com.example;

import com.code_intelligence.jazzer.api.FuzzedDataProvider;
import com.code_intelligence.jazzer.junit.FuzzTest;

public class RCETestCase {
    @FuzzTest
    void myFuzzTest(FuzzedDataProvider data) {
        int a = data.consumeInt();
        int b = data.consumeInt();
        String c = data.consumeString(8);
        String d = data.consumeRemainingAsString();

        ExploreMe ex = new ExploreMe(a);
        ex.exploreRCE(b, c, d);
    }
}
