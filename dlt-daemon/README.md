# DLT Daemon

**WORK IN PROGRESS**

This example is a C++ project that illustrates usage of `max_len` to improve coverage.

Version of dlt-daemon used: 2.18.5.

This version contains a heap-based buffer overflow in dlt_common.c that can only be triggered by a larger payload (> than the default 4096 bytes).

Tested with CI Fuzz 0.27

## How to Run

`cifuzz run dlt_push_buffer --engine-arg "-max_len=20000"`
