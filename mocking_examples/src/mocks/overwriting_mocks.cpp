#include "Foo.hpp"
#include <dlfcn.h>

using Foo = bar::Foo;

// Mocks

// Mocks for C functions
extern "C" {
   
    int c_global_function(int a) {
        std::cout << "Overwritten c_global_function()" << std::endl;
        return a;
    }

    int c_function_called_by_other_function_in_same_file(int a) 
    {
        std::cout << "Overwritten c_function_called_by_other_function_in_same_file()" << std::endl;
        return a;
    }
}

// Mocks for C++ functions

int cpp_global_function(int a) {
    std::cout << "Overwritten cpp_global_function()" << std::endl;
    return a;
}

int bar::Foo::cpp_public_member_function(int a)
{
   std::cout << "Overwritten bar::Foo:cpp_public_member_function(): this = " << (void*)this << std::endl;
   return a;
}

int bar::Foo::cpp_public_const_member_function(int a) const
{
   std::cout << "Overwritten bar::Foo:cpp_public_const_member_function(): this = " << (void*)this << std::endl;
   return a;
}

int bar::Foo::cpp_public_member_function_called_by_other_function_in_same_file(int a)
{
   std::cout << "Overwritten bar::Foo:cpp_public_member_function_called_by_other_function_in_same_file(): this = " << (void*)this << std::endl;
   return a;
}

int bar::Foo::cpp_private_member_function(int a)
{
   std::cout << "Overwritten bar::Foo:cpp_private_member_function(): this = " << (void*)this << std::endl;
   return a;
}

int bar::Foo::cpp_public_static_member_function(int a)
{
   std::cout << "Overwritten bar::Foo:cpp_public_static_member_function()" << std::endl;
   return a;
}