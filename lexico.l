%{
# include <cerrno>
#include <stdio.h>
#include <string>
#include "driver.h"
#include "parser.tab.hh"
#undef yywrap
#define yywrap() 1
static yy::location loc;
%}
%option noyywrap nounput batch debug noinput
%option outfile="scanner.cpp"
DIGITO [0-9]
LETRA [a-zA-ZñÑ]

NUM {DIGITO}+("."{DIGITO}+)?
ID {LETRA}({LETRA}|{DIGITO}|"_")*

DELIMITADOR [\t\r\f" "]
%%
"editar"    {return yy::calculadora_parser::make_editar(loc);}
"termino"   {return yy::calculadora_parser::make_terminar(loc);}
"davalor"   {return yy::calculadora_parser::make_davalor(loc);}
"color"     {return yy::calculadora_parser::make_COLOR(loc);}
"pos"  	    {return yy::calculadora_parser::make_pos(loc);}
"aba"       {return yy::calculadora_parser::make_aba(loc);}
"arr"       {return yy::calculadora_parser::make_arr(loc);}
"izq"       {return yy::calculadora_parser::make_izq(loc);}
"der"       {return yy::calculadora_parser::make_der(loc);}
"rojo"      {return yy::calculadora_parser::make_rojo(loc);}
"verde"     {return yy::calculadora_parser::make_verde(loc);}
"azul"      {return yy::calculadora_parser::make_azul(loc);}
"amarillo"  {return yy::calculadora_parser::make_amarillo(loc);}
"blanco"    {return yy::calculadora_parser::make_blanco(loc);}
"("        {return yy::calculadora_parser::make_PARABIER(loc);}
")"         {return yy::calculadora_parser::make_PARACER(loc);}
","         {return yy::calculadora_parser::make_COMA(loc);}
"="         {return yy::calculadora_parser::make_IGUAL(loc);}
{NUM}    {return yy::calculadora_parser::make_NUM(strtol(yytext, NULL, 10),loc);}
{ID}        {return yy::calculadora_parser::make_ID(yytext,loc);}
"\n"        {linea++;}

{DELIMITADOR}   {}
.               {printf("ERROR LEXICO %s\n",yytext);}
<<EOF>>		{return yy::calculadora_parser::make_FIN(loc);}
%%
void calculadora_driver::iniciarScanner()
{
  yy_flex_debug = false;
  if(file.empty() || file == "-"){
    printf("No se encuentra el archivo de entrada");
    exit(1);
  }else{
    yyin = fopen (file.c_str (), "r");
  }
}
void calculadora_driver::terminarScanner()
{
  fclose(yyin);
}