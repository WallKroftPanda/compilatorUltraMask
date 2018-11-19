#include <stdio.h>
#include "driver.h"
#include <iostream>
#include <string.h>

int main()
{
  calculadora_driver driver;
  if(driver.parse("start"))
  {
    printf("La entrada es incorrecta\n");
  }
  else{
    printf("La entrada es correcta\n");
    //printf("Resultado = %f\n",driver.resultado);
  }
  
  return 0;
}
