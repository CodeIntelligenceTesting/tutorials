// Run with:
// LD_PRELOAD=libld_preload_mocks.so ./ld_preload_example
#include "Foo.hpp"
#include <dlfcn.h>

using Foo = bar::Foo;

// Helper typedefs
typedef int (*global_function)(int);
typedef int (*member_function)(Foo* This, int);
typedef int (*const_member_function)(Foo const * This, int);

// Mocks

// Mocks for C functions
extern "C" {
   
    int c_global_function(int a) {
        std::cout << "Pre-loaded c_global_function()" << std::endl;
        global_function original_c_global_function = (global_function)dlsym(RTLD_NEXT, "c_global_function");
        return original_c_global_function(a);
    }

    int c_function_called_by_other_function_in_same_file(int a) 
    {
        std::cout << "Pre-loaded c_function_called_by_other_function_in_same_file()" << std::endl;
        global_function original_c_function_called_by_other_function_in_same_file = (global_function)dlsym(RTLD_NEXT, "c_function_called_by_other_function_in_same_file");
        return original_c_function_called_by_other_function_in_same_file(a);
    }
}

// Mocks for C++ functions

int cpp_global_function(int a) {
    std::cout << "Pre-loaded cpp_global_function()" << std::endl;
    global_function original_cpp_global_function = (global_function)dlsym(RTLD_NEXT, "_Z19cpp_global_functioni");
    return original_cpp_global_function(a);
}

int bar::Foo::cpp_public_member_function(int a)
{
   std::cout << "Pre-loaded bar::Foo:cpp_public_member_function(): this = " << (void*)this << std::endl;
   member_function original_bar_foo_cpp_public_member_function = (member_function)dlsym(RTLD_NEXT, "_ZN3bar3Foo26cpp_public_member_functionEi");
   return original_bar_foo_cpp_public_member_function(this, a);
}

int bar::Foo::cpp_public_const_member_function(int a) const
{
   std::cout << "Pre-loaded bar::Foo:cpp_public_const_member_function(): this = " << (void*)this << std::endl;
   const_member_function original_bar_foo_cpp_public_const_member_function = (const_member_function)dlsym(RTLD_NEXT, "_ZNK3bar3Foo32cpp_public_const_member_functionEi");
   return original_bar_foo_cpp_public_const_member_function(this, a);
}

int bar::Foo::cpp_public_member_function_called_by_other_function_in_same_file(int a)
{
   std::cout << "Pre-loaded bar::Foo:cpp_public_member_function_called_by_other_function_in_same_file(): this = " << (void*)this << std::endl;
   member_function original_bar_foo_cpp_public_member_function_called_by_other_function_in_same_file = (member_function)dlsym(RTLD_NEXT, "_ZN3bar3Foo64cpp_public_member_function_called_by_other_function_in_same_fileEi");
   return original_bar_foo_cpp_public_member_function_called_by_other_function_in_same_file(this, a);
}

int bar::Foo::call_cpp_private_member_function(int a)
{
   std::cout << "Pre-loaded bar::Foo:cpp_private_member_function(): this = " << (void*)this << std::endl;
   member_function original_bar_foo_private_member_function = (member_function)dlsym(RTLD_NEXT, "_ZN3bar3Foo27cpp_private_member_functionEi");
   return original_bar_foo_private_member_function(this, a);
}

int bar::Foo::cpp_public_static_member_function(int a)
{
   std::cout << "Pre-loaded bar::Foo:cpp_public_static_member_function()" << std::endl;
   global_function original_bar_foo_public_static_member_function = (global_function)dlsym(RTLD_NEXT, "_ZN3bar3Foo33cpp_public_static_member_functionEi");
   return original_bar_foo_public_static_member_function(a);
}