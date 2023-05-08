#include <assert.h>

#include <cifuzz/cifuzz.h>
#include <fuzzer/FuzzedDataProvider.h>

void function_under_test(const uint8_t *data, size_t size);

FUZZ_TEST(const uint8_t *data, size_t size) {
  function_under_test(data, size);
}
