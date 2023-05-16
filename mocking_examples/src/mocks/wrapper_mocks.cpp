#include "Foo.hpp"
#include <cstdio>
#include <dlfcn.h>

using Foo = bar::Foo;

// Mocks
// Make sure all mocks are linked the "C" way
extern "C" {

    // Mocks for C functions

    int __real_c_global_function(int a);
    int __wrap_c_global_function(int a) {
        std::cout << "Wrapped c_global_function()" << std::endl;
        return __real_c_global_function(a);
    }

    // Mocks for C++ functions

    int __real__Z19cpp_global_functioni(int a);
    int __wrap__Z19cpp_global_functioni(int a) {
        std::cout << "Wrapped cpp_global_function()" << std::endl;
        return __real__Z19cpp_global_functioni(a);
    }
        
    int __real__ZN3bar3Foo26cpp_public_member_functionEi(Foo* This, int a);
    int __wrap__ZN3bar3Foo26cpp_public_member_functionEi(Foo* This, int a)
    {
        std::cout << "Wrapped bar::Foo:cpp_public_member_function(): this = " << (void*)This << std::endl;
        return __real__ZN3bar3Foo26cpp_public_member_functionEi(This, a);
    }

    int __real__ZNK3bar3Foo32cpp_public_const_member_functionEi(const Foo* This, int a);
    int __wrap__ZNK3bar3Foo32cpp_public_const_member_functionEi(const Foo* This, int a)
    {
        std::cout << "Wrapped bar::Foo:cpp_public_const_member_function(): this = " << (void*)This << std::endl;
        return __real__ZNK3bar3Foo32cpp_public_const_member_functionEi(This, a);
    }

    int __real__ZN3bar3Foo33cpp_public_static_member_functionEi(int a);
    int __wrap__ZN3bar3Foo33cpp_public_static_member_functionEi(int a)
    {
        std::cout << "Wrapped bar::Foo:cpp_public_static_member_function()" << std::endl;
        return __real__ZN3bar3Foo33cpp_public_static_member_functionEi(a);
    }
}