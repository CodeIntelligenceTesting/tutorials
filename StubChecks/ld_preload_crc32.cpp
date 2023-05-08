#include "zlib.h"

extern "C" {
    uLong crc32(uLong crc, const Bytef *buf, uInt len) {
        // return static value
        return 0;
    }
}