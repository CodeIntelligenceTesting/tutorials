#include <assert.h>

#include <cifuzz/cifuzz.h>
#include <fuzzer/FuzzedDataProvider.h>

FUZZ_TEST(const uint8_t *data, size_t size) {
  // FuzzedDataProvider provides convenience methods that turn the raw fuzzer
  // data into common types. Use it to generate parameters for the function you
  // want to fuzz:

  // Make sure we have enough data
  if (size <= sizeof(uint32_t)) return;

  FuzzedDataProvider fuzzed_data(data, size);
  uint32_t my_int = fuzzed_data.ConsumeIntegral<uint32_t>();
  std::string my_string = fuzzed_data.ConsumeRandomLengthString();

  if (my_string.compare("Guess this String!") == 0) {
    if (my_int == 0xE26DB107) {
      assert(false);
    }
  }
}
