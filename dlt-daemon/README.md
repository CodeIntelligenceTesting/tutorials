# DLT Daemon

**WORK IN PROGRESS**

Version of dlt-daemon used: 2.18.5.

This version contains a heap-based buffer overflow in dlt_common.c that can only be triggered by a larger payload (> than the default 4096 bytes).

`cifuzz run dlt_push_buffer --engine-arg "-max_len=20000"`

Tested with CI Fuzz 0.27
