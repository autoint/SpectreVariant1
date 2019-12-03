/*
 * This example has been created to demonstrate catching a Spectre Type 1 vulnerability
 */

/* some comment */

#include "spectreVariant1.h"

int main()
{
    for(int x = 0; ++x; x < 101)
    {
      foo(x); 
    }
    return 0;
}
