#include <assert.h>

#include <cifuzz/cifuzz.h>


#include <stdint.h>
#include <stddef.h>

//extern "C" {
#include <stdio.h>
#include <stdlib.h>   /* for malloc(), free() */
#include <string.h>   /* for strlen(), memcmp(), memmove() */
#include <time.h>     /* for localtime_r(), strftime() */
#include <limits.h>   /* for NAME_MAX */
#include <inttypes.h> /* for PRI formatting macro */
#include <stdarg.h>
#include <errno.h>
#include <sys/stat.h> /* for mkdir() */
#include "dlt_user_shared.h"
#include "dlt_common.h"
#include "dlt_common_cfg.h"
#include "dlt_version.h"
#include "dlt_user_cfg.h"
//}

DltReturnValue dlt_buffer_push(DltBuffer *buf, const unsigned char *data, unsigned int size);

FUZZ_TEST_SETUP() {
  // Perform any one-time setup required by the FUZZ_TEST function.
}

FUZZ_TEST(const uint8_t *data, size_t size) {

  DltBuffer buf;
  dlt_buffer_init_dynamic(&buf, DLT_USER_RINGBUFFER_MIN_SIZE, DLT_USER_RINGBUFFER_MAX_SIZE,DLT_USER_RINGBUFFER_STEP_SIZE);
  dlt_buffer_push(&buf, (unsigned char*) data, size);
  dlt_buffer_free_dynamic(&buf);

  // Call the functions you want to test with the provided data and optionally
  // assert that the results are as expected.
  // int res = DoSomething(data, size);
  // assert(res != -1);

  // If you want to know more about writing fuzz tests you can checkout the
  // example projects at https://github.com/CodeIntelligenceTesting/cifuzz/tree/main/examples
  // or have a look at our tutorial: 
  // https://github.com/CodeIntelligenceTesting/cifuzz/blob/main/docs/How-To-Write-A-Fuzz-Test.md 
}
