#include "Foo.hpp"
#include <cstdio>

int bar::Foo::cpp_public_member_function(int a)
{
   printf("Original bar::Foo:cpp_public_member_function(): this = %p\n", (void*)this);
   cpp_public_member_function_called_by_other_function_in_same_file(a);
   return a;
}

int bar::Foo::cpp_public_const_member_function(int a) const
{
   printf("Original bar::Foo:cpp_public_const_member_function(): this = %p\n", (void*)this);
   return a;
}

int bar::Foo::cpp_public_member_function_called_by_other_function_in_same_file(int a) 
{
   printf("Original bar::Foo:cpp_public_member_function_called_by_other_function_in_same_file(): this = %p\n", (void*)this);
   return a;
}

int bar::Foo::cpp_private_member_function(int a) 
{
   printf("Original bar::Foo:cpp_private_member_function(): this = %p\n", (void*)this);
   return a;
}

int bar::Foo::cpp_public_static_member_function(int a) {
   printf("Original bar::Foo:cpp_public_static_member_function()\n");
   return a;
}

int cpp_global_function(int a) {
   printf("Original cpp_global_function()\n");
   return a;
}

static int cpp_static_function(int a) {
   printf("Original cpp_static_function()\n");
   return a;
}

extern "C" {
   
   int c_global_function(int a) {
      printf("Original c_global_function()\n");
      return a;
   }

   static int c_static_function(int a) {
      printf("Original c_static_function()\n");
      return a;
   }

   int c_function_called_by_other_function_in_same_file(int a) 
   {
      printf("Original c_function_called_by_other_function_in_same_file()\n");
      return a;
   }
}


int call_static_cpp_function(int a) {
   return cpp_static_function(a);
}

int call_static_c_function(int a) {
   return c_static_function(a);
}

int call_c_function(int a) {
   return c_function_called_by_other_function_in_same_file(a);
}

int bar::Foo::call_cpp_private_member_function(int a) 
{
   return cpp_private_member_function(a);
}