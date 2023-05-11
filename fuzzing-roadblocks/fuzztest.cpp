#include <assert.h>
#include <stdio.h>

#include <cifuzz/cifuzz.h>
#include <fuzzer/FuzzedDataProvider.h>

// Declaration of the function we want to fuzz from pngcheck.c
extern "C" int pngcheck(FILE *fp, const char *fname, int searching, FILE *fpOut);


FUZZ_TEST(const uint8_t *data, size_t size) {
  if(size == 0) return;

  FILE *fp = fmemopen((void *) data, size, "rb");
  int err = pngcheck(fp, "in-memory-dummy-file", 0, NULL);
  fclose(fp);
}
