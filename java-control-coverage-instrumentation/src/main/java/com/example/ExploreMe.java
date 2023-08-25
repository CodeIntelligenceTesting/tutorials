package com.example;
import com.example2.IgnoreMe;

public class ExploreMe {
    private int a;

    public ExploreMe(int a) {
        this.a = a;
    }

    // Function with multiple paths that can be discovered by a fuzzer.
    public void exploreMe(int b, String c) {

        // IgnoreMe could be any third party library that is not interesting to be tested
        IgnoreMe ig = new IgnoreMe(1);
        ig.ignoreMe(b, c);

        if (a >= 20000) {
            if (b >= 2000000) {
                if (b - a < 100000) {
                    // Trigger Remote Code Execution Bug
                    if (c.startsWith("@")) {
                        String className = c.substring(1);
                        try {
                            Class.forName(className).newInstance();
                        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException ignored) {
                        }
                    }
                }
            }
        }
    }
}
