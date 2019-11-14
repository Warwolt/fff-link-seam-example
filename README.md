# Fake Function Framework Link Seam Example
An example of how system calls can be mocked out using link seams, where fake implementations are linked in place of the real ones, for use in unit testing. Fake implementations provided by the Fake Function Framework.

## Structure
The file `use_malloc.c` allocates space for an integer, prints the address of
the allocation returned by malloc, and then frees the pointer. In `main.c` two
fake buffers `buff_0` and `buff_1` are created, and used as the return values
of a fake implementation of malloc, which `use_malloc.c` then uses.

A link seam is introduced in the `makefile`, so that the fake implementation of
malloc is used over the real implementation, by utilizing that the gcc linker
will prefer using the symbol definition provided in an input `.o` file over
those in any `.a` files. 

The fake implementation of malloc is done in `fake_malloc.c`, and made simple
by utilizing the macros in FFF to automatically generate the storage for the 
prepared `void *` return value from malloc.

All production code is compiled into a library `prod.a`, and the fake
implementation of malloc is compiled into `fake_malloc.o`. When the binary is
then linked, the fake implementation will be used.

**Output**:
![](https://i.ibb.co/6J5zFyT/im.png)
