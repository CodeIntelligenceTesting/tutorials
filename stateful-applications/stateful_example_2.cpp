#include <assert.h>
#include <cstddef>

#include <cifuzz/cifuzz.h>
#include <fuzzer/FuzzedDataProvider.h>

void function_under_test(uint8_t mode, const uint8_t *data, size_t size);
extern bool precondition;

FUZZ_TEST(const uint8_t *data, size_t size) {
  FuzzedDataProvider fuzz_data(data, size);
  // Reset global variable
  precondition = false;
  while (fuzz_data.remaining_bytes() >= 2) {
    uint8_t mode = fuzz_data.ConsumeIntegralInRange<uint8_t>(0,2);
    std::vector<uint8_t> input_data = fuzz_data.ConsumeBytes<uint8_t>(fuzz_data.ConsumeIntegralInRange<size_t>(1,50));
    function_under_test(mode, input_data.data(), input_data.size());
  }
}
