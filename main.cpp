#include <stdio.h>
#include "driver.h"

int main()
{
  float resultado = 0.0;
  calculadora_driver driver;
  if(driver.parse("entrada.txt")){
    printf("La entrada es incorrecta\n");
  }else{
    printf("La entrada es correcta\n");
    //printf("Resultado = %f\n",driver.resultado);
  }
  return 0;
}