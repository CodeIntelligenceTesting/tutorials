#include <stdarg.h>
#include <stdio.h>

// This file is used to stub print statements
// from the fuzzed project, which can slow down
// the fuzzing speed considerably if the system
// under test is noisy.

extern int __real_printf(const char*, ...);
extern int __real_fprintf(FILE *stream, const char *format, ...);

int __wrap_printf(const char* format, ...) {
    va_list args;
    va_start(args, format);
    //__real_printf("[!] ");
    //int result = vprintf(format, args);
    va_end(args);

    // Invalid return value, should return the number of bytes written, but this probably doesn't matter.
    return 0;
}

int __wrap_fprintf(FILE *stream, const char *format, ...) {
    va_list args;
    va_start(args, format);
    //__real_printf("[!] ");
    //int result = vprintf(format, args);
    va_end(args);

    // Invalid return value, should return the number of bytes written, but this probably doesn't matter.
    return 0;
}