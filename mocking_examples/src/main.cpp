#include "Foo.hpp"

using Foo = bar::Foo;

int main()
{
    // Call C functions
    std::cout << "Calling C functions" << std::endl;
    c_global_function(1);
    call_c_function(2);
    call_static_c_function(3);

    // Call C++ functions
    std::cout << "Calling C++ functions" << std::endl;
    cpp_global_function(1);
    call_static_cpp_function(2);

    Foo foo;
    std::cout << "Address of foo: " << (void*)&foo << std::endl;
    // Member functions
    foo.cpp_public_member_function(3);
    foo.cpp_public_const_member_function(4);
    foo.cpp_public_member_function_called_by_other_function_in_same_file(5);
    foo.call_cpp_private_member_function(6);
    foo.cpp_public_static_member_function(7);
    
    std::cout << "Done!" << std::endl;
}