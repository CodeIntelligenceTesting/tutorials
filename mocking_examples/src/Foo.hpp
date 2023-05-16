#include <memory>
#include <iostream>

namespace bar {
    class Foo
    {
    public:
        Foo() {};
        ~Foo() {};
        int cpp_public_member_function(int a);
        int cpp_public_const_member_function(int a) const;
        static int cpp_public_static_member_function(int a);
        int cpp_public_member_function_called_by_other_function_in_same_file(int a);
        void function_calling_other_function();
        void function_being_called();
        int call_cpp_private_member_function(int a);
    private:
        int cpp_private_member_function(int a);
    };
}

int cpp_global_function(int a);
extern "C" int c_global_function(int a);
extern "C" int c_function_called_by_other_function_in_same_file(int a);

int call_static_cpp_function(int a);
int call_static_c_function(int a);
int call_c_function(int a);