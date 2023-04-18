package com.example;

import java.util.Base64;

public class ExploreMe {
    private final int a;

    public ExploreMe(int a) {
        this.a = a;
    }

    public void exploreSimpleChecks(int b, String c) {
        if (a >= 20000) {
            if (b >= 2000000) {
                if (b - a < 100000) {
                    if (c.equals("Attacker")) {
                       mustNeverBeCalled();
                    }
                }
            }
        }
    }

    public static void exploreComplexChecks(long n, long m, byte[] a) {
        if (base64(a).equalsIgnoreCase("SGV5LCB3ZWw=")) {
            if (insecureEncrypt(n) == 0xce9e91e6677cfff3L) {
                if (insecureEncrypt(m) == 0xcf8b9fb34431d9d3L) {
                    mustNeverBeCalled();
                }
            }
        }
    }

    private static String base64(byte[] input) {
        return Base64.getEncoder().encodeToString(input);
    }

    private static long insecureEncrypt(long input) {
        long key = 0xefe4eb93215cb6b0L;
        return input ^ key;
    }

    private static void mustNeverBeCalled() {
        throw new RuntimeException("mustNeverBeCalled has been called");
    }
}
