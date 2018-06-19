int array1_size = 100;
int array1[100] = {0};
int array2[25600] = {0};

int foo(int x)
{
  int y = 0;
  if (x < array1_size)
  {
    y = array2[array1[x] * 256];
  }
  return y;
}  
   
