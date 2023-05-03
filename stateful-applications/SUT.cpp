#include <assert.h>
#include <stdint.h>
#include <cstddef>

bool precondition = false;

void function_under_test(uint8_t mode, const uint8_t *data, size_t size) {
    switch (mode)
    {
    case 0:
        precondition = true;
        break;
    case 1:
        if (precondition) {
            // process input
            if (size >= 6) {
                if (data[0] == 'c') {
                    if (data[1] == 'i') {   
                        if (data[2] == 'f') {   
                            if (data[3] == 'u') {   
                                if (data[4] == 'z') {   
                                    if (data[5] == 'z') {
                                        assert(0);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        break;
    case 2:
        /* code */
        precondition = false;
        break;
    
    default:
        return;
    }
}