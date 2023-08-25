package com.example2;

public class IgnoreMe {
    private int a;

    public IgnoreMe(int a) {
        this.a = a;
    }

    // Function with multiple paths that can be discovered by a fuzzer.
    public void ignoreMe(int b, String c) {
        if (a >= 10000) {
            if (b >= 5000) {
                if (a + b < 20000) {
                    // Trigger Remote Code Execution Bug
                    if (c.startsWith("@")) {
                        if (a == 11000) {
                            if (b == 5500) {
                                // Nothing Interesting
                            }
                        } 
                    }
                }
            }
        }
    }
}