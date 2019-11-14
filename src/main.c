/* main.c */
#include <stdio.h>
#include <stdint.h>
#include <assert.h>
#include "fff.h"
#include "fake_malloc.h"
#include "use_malloc.h"

DEFINE_FFF_GLOBALS;

int main()
{
    /* Buffers for fake malloc */
    uint8_t buff_0[sizeof(int)];
    uint8_t buff_1[sizeof(int)];

    /* Call function that will use linked fake malloc */
    printf("buff_0 = %p\n", buff_0);
    malloc_fake.return_val = buff_0;
    use_malloc();

    printf("buff_1 = %p\n", buff_1);
    malloc_fake.return_val = buff_1;
    use_malloc();

    return 0;
}
