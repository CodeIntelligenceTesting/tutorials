#include <zlib.h>
#include <assert.h>
#include <stdint.h>

void function_under_test(const uint8_t *data, size_t size) {
    // Check if size is big enough to at least contain the crc32 sum and 6 bytes
    if (size <= (sizeof(unsigned long) + 6)) return;

    // First bytes of input are regarded as crc32 sum
    unsigned long crc_from_input = *((unsigned long*) data);

    // Calculate crc32 over rest of input:
    unsigned long crc_calculated = crc32(0L, Z_NULL, 0);
    crc_calculated = crc32(crc_calculated, (const unsigned char*)(data+sizeof(unsigned long)), size-sizeof(unsigned long));

    // Check if crc32 sum matches
    if (crc_calculated == crc_from_input) {
        // process input
        if (data[sizeof(unsigned long)] == 'c') {
            if (data[sizeof(unsigned long)+1] == 'i') {   
                if (data[sizeof(unsigned long)+2] == 'f') {   
                    if (data[sizeof(unsigned long)+3] == 'u') {   
                        if (data[sizeof(unsigned long)+4] == 'z') {   
                            if (data[sizeof(unsigned long)+5] == 'z') {
                                assert(0);
                            }
                        }
                    }
                }
            }
        }
    }
}