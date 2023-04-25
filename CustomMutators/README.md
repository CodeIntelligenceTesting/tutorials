# README

Custom mutators have proven to be extremely helpful
when fuzzing highly structured input data, such as PNG
(Portable Network Graphics) files. PNG is a widely used
lossless image format known for its compression capabilities
and support for transparency. Due to the complexity of the
format, generic fuzzers often struggle to generate valid
inputs, limiting their efficacy in discovering vulnerabilities.
Custom mutators, on the other hand, can intelligently
manipulate the input data, bypassing common hurdles and
making the fuzzing process more effective.

Staying with the scenario of PNG files, these consist of a
well-defined structure that includes a header, a series of
chunks, and an end marker. Each chunk has a specific purpose
and follows a strict format. A typical PNG file begins with
an 8-byte signature, followed by a series of chunks:

```hex
89 50 4E 47 0D 0A 1A 0A // PNG signature
00 00 00 0D 49 48 44 52 // IHDR chunk header
...
49 45 4E 44 AE 42 60 82 // IEND chunk (end of file)
```

A naive fuzzer or even state of the art ones that rely on random
bitwise mutations might generate random input data, which is likely
to result in an invalid PNG file structure. This would cause the
target application to reject the input before reaching any potentially
vulnerable code paths in most if not all cases. Custom mutators,
however, can understand and manipulate the PNG structure intelligently,
ensuring that the fuzzer generates valid inputs that exercise the target
application more thoroughly.

For instance, a custom mutator may choose to modify specific chunks within
a valid PNG file while preserving the overall structure. This could
include altering the width and height values in the IHDR chunk, changing
the color depth, or modifying the compression method used:

```cpp
// A custom mutator function for IHDR chunk in a PNG file
void mutate_IHDR(png_structp png_ptr, png_infop info_ptr) {
  int width = png_get_image_width(png_ptr, info_ptr);
  int height = png_get_image_height(png_ptr, info_ptr);
  int color_type = png_get_color_type(png_ptr, info_ptr);

  // Mutate the values intelligently
  width = mutate_int(width);
  height = mutate_int(height);
  color_type = mutate_color_type(color_type);

  // Set the mutated values back to the IHDR chunk
  png_set_IHDR(png_ptr, info_ptr, width, height, color_type,
               PNG_INTERLACE_NONE, PNG_COMPRESSION_TYPE_DEFAULT,
               PNG_FILTER_TYPE_DEFAULT);
}
```

Moreover, custom mutators can take advantage of their knowledge of the PNG
format to explore less common or obscure features, such as interlacing,
filters, or even custom chunks. By doing so, they can push the target
application into less frequently exercised code paths, increasing the
likelihood of uncovering vulnerabilities.

In summary, custom mutators are essential when fuzzing highly structured input
formats like PNG files, as they can intelligently manipulate the input data
while maintaining its validity. This enables fuzzers to explore a broader
range of code paths in the target application, increasing the chances of
discovering security vulnerabilities that may otherwise remain hidden.

## Caveats

Custom mutators, while offering significant potential for improving the
effectiveness of fuzzing, come with their own set of caveats that users
should be aware of before investing time and resources into developing one.
One of the most notable drawbacks is the potential decrease in execution speed.
Custom mutators often involve more complex and computationally expensive
operations compared to the default mutators provided by fuzzing engines.
As a result, the overall fuzzing throughput can be negatively impacted,
leading to fewer executions per second and a slower discovery of vulnerabilities
or other metrics such as code coverage. It is essential to balance the
complexity of the custom mutator with the performance impact on the fuzzing
process.

Another concern when developing custom mutators is the time investment required.
Building a custom mutator tailored to a specific target often demands a deep
understanding of the input format and the application's logic, which can be
time-consuming. Additionally, the effectiveness of custom mutators is often
closely tied to the quality of the seed corpus.
A well-crafted seed corpus can significantly enhance the efficiency of custom
mutators by providing a solid foundation of diverse and representative inputs.
On the other hand, a poor seed corpus may limit the custom mutator's ability to
explore the target application's logic effectively, leading to suboptimal results.
This however, applies even more to having no custom mutator and only relying on
random byte mutation for targets with highly structured inputs.
It is crucial to invest time in understanding the target application and building
a comprehensive seed corpus to maximize the benefits of custom mutators while
being aware of the potential trade-offs in terms of performance and time investment.

## Advanced

[cifuzz](https://github.com/CodeIntelligenceTesting/cifuzz) uses [libfuzzer](https://www.llvm.org/docs/LibFuzzer.html) internally. LibFuzzer is a popular in-process,
coverage-guided fuzzing engine that makes it easy to integrate custom mutators
for highly structured input formats like PNG files. When writing a custom mutator
for LibFuzzer, you'll need to define the `LLVMFuzzerCustomMutator` function.
This function takes a pointer to the input data, its size, the maximum size for
the mutated data, and a seed value for randomization. Here's a basic setup
example of how one would write a custom mutator for LibFuzzer, targeting
a PNG parsing library:

```cpp
#include <cstdint>
#include <cstdlib>
#include "png.h" // Include the PNG library header

extern "C" size_t LLVMFuzzerCustomMutator(uint8_t *data, size_t size, size_t max_size, unsigned int seed) {
  // Initialize the PNG structures with custom error handling
  png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, nullptr, nullptr, nullptr);
  png_infop info_ptr = png_create_info_struct(png_ptr);

  // Set up the custom read function to read from the data buffer
  png_set_read_fn(png_ptr, &data, custom_read_function);

  // Read the PNG file header and validate the signature
  if (setjmp(png_jmpbuf(png_ptr))) {
    // Invalid PNG signature, clean up and return
    png_destroy_read_struct(&png_ptr, &info_ptr, nullptr);
    return size;
  }
  png_read_info(png_ptr, info_ptr);

  // Mutate the PNG file intelligently
  mutate_IHDR(png_ptr, info_ptr);
  // Add more mutation functions as needed

  // Write the mutated PNG data to a new buffer
  uint8_t *new_data = new uint8_t[max_size];
  png_set_write_fn(png_ptr, &new_data, custom_write_function, custom_flush_function);
  png_write_png(png_ptr, info_ptr, PNG_TRANSFORM_IDENTITY, nullptr);

  // Clean up
  png_destroy_read_struct(&png_ptr, &info_ptr, nullptr);

  // Copy the mutated data back to the input buffer, respecting the max_size constraint
  size_t new_size = std::min(static_cast<size_t>(max_size), get_new_data_size(new_data));
  memcpy(data, new_data, new_size);
  delete[] new_data;

  return new_size;
}
```

The example in this directory builds on that knowledge.

## Usage

This example houses a PNG fuzzer with 2 modes. One uses no custom mutator while
the other adds a basic custom mutator for the PNG file format. The target is the
most recent version of `libpng`, so we don't necessarily except any (fast) crashes.
However, when using the custom mutator one should quickly notice an increase in
code coverage compared to the version without the mutator enabled.

Simply run:

```sh
# For the default version
./build.sh -m 0

# or for the custom mutator
./build.sh -m 1
```

If you want to inspect the fuzz test you can checkout `BUILD/my_fuzz_test_1.cpp`.
Similarly, the custom mutator is available under `png_mutator.cpp`.
Note, these files are only present after you ran `./build.sh` once.
