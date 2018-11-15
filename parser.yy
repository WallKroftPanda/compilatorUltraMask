%skeleton "lalr1.cc" /* -*- C++ -*- */
%require "3.0.2"
%defines
%define parser_class_name {calculadora_parser}
%define api.token.constructor
%define api.namespace {yy}
%define api.value.type variant
%define parse.assert
%code requires
{
#include <string>
#include <stdio.h>
class calculadora_driver;
}
%param { calculadora_driver& driver }
%locations
%define parse.trace
%define parse.error verbose
%code
{
#include "driver.h"
#include <iostream>
}
%define api.token.prefix {TOK_}

//Listadode Terminales
%token editar "EDITAR"
%token termino "TERMINO"
%token davalor "DAVALOR"
%token color "COLOR"
%token pos "POS"
%token arr "ARR"
%token aba "ABA"
%token izq "IZQ"
%token der "DER"
%token rojo "ROJO"
%token verde "VERDE"
%token azul "AZUL"
%token amarillo "AMARILLO"
%token blanco "BLANCO"
%token parabier "PARABIER"
%token paracer "PARACER"
%token coma "COMA"
%token igual "IGUAL"
%token <std::string> ID "ID"
%token <float> NUM "NUM"
%token FIN 0 "eof"

//Listado de No Terminales
%type <float> S

%printer { yyoutput << $$; } <*>;
%%
%start INICIO;

INICIO : S;

S : editar inst termino;

inst : inst_color
      |inst_pos_xy
      |inst_der
      |inst_izq
      |inst_arr
      |inst_abj
      |inst_dvalor
      |inst inst;

inst_color : color parabier ID paracer
            |color parabier COL paracer;

inst_pos_xy : pos parabier X coma X paracer;

inst_der : der parabier X paracer;

inst_izq : izq parabier X paracer;

inst_arr : arr parabier X paracer;

inst_abj : aba parabier X paracer;

inst_dvalor : davalor ID igual DATO;

DATO : COL
      | NUM;

COL : rojo
      | azul
      | verde
      | amarillo
      | rojo
      | blanco

X : ID
   |NUM;

%%
void yy::calculadora_parser::error(const location_type& lugar, const std::string& lexema)
{
  std::cout << "Error Sintactico " << lexema << std::endl;
}