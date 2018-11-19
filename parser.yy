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
#include "miniwin.h"
#include <vector>
class calculadora_driver;
void positio(float x, float y);
void saveNum(std::string a, float x);
float searchNum();
void setColor();
std::string searchColor();
void up(float dir);
void down(float dir);
void left(float dir);
void right(float dir);
void paintRed();
void paintBlue();
void paintGreen();
void paintYellow();
void paintWhite();
}
%param { calculadora_driver& driver }
%locations
%define parse.trace
%define parse.error verbose
%code
{
#include "driver.h"
#include <iostream>
int px,py;
std::vector<std::pair<std::string, float>> myVec;
std::vector<std::pair<std::string,std::string>> myVec2;
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
%type <float> INICIO;
%type <float> DATO;
%type <float> inst;
%type <float> inst_color;
%type <float> inst_pos_xy;
%type <float> inst_abj;
%type <float> inst_arr;
%type <float> inst_der;
%type <float> inst_izq;
%type <float> inst_dvalor;
%type <float> finish;
%type <float> COL;
%type <float> X;

%printer { yyoutput << $$; } <*>;
%%

INICIO : editar inst finish;

finish : termino{exit(0);}

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

inst_pos_xy : pos parabier X coma X paracer {positio($3,$3);}

inst_der : der parabier X paracer {right($3);}

inst_izq : izq parabier X paracer {left($3);}

inst_arr : arr parabier X paracer {up($3);}

inst_abj : aba parabier X paracer {down($3);}

inst_dvalor : davalor ID igual DATO;

DATO : COL
      | NUM;

COL : rojo {paintRed();}
      | azul {paintBlue();}
      | verde {paintGreen();}
      | amarillo {paintYellow();}
      | blanco {paintWhite();}

X : ID
   |NUM{$$=$1;};

%%
void positio(float x, float y)
{
      px = x;
      py = y;
}
void saveNum(std::string a, float x)
{     
      std::pair<std::string,float> p;
	p.first=a;
	p.second=x;
	myVec.push_back(p);
}
float searchNum(std::string a)
{
      int limit = myVec.size();
      for(int i = 0; i < limit; ++i)
      {
            if(myVec[i].first == a) return myVec[i].second;
      }
      return -1;
}
void setColor(std::string Com, std::string Com2)
{
      std::pair<std::string, std::string> Com3;
      Com3.first=Com;
      Com3.second=Com2;
      myVec2.push_back(Com3);
}
std::string searchColor(std::string Com)
{
      int large=myVec.size();
      for (int i = 0; i<large; i++){
      	if(myVec2[i].first == Com){
                  std::cout<<myVec2[i].second<<std::endl;
                  if(myVec2[i].second == "ROJO"){
                        std::cout<<"rojo"<<std::endl;
                        paintRed();
                  }
                  else if(myVec2[i].second == "VERDE"){
                        std::cout<<"verde"<<std::endl;
                        paintGreen();
                  }
                  else if(myVec2[i].second == "AMARILLO"){
                        std::cout<<"amarillo"<<std::endl;
                        paintYellow();   
                  }
                  else if(myVec2[i].second == "AZUL"){
                        std::cout<<"azul"<<std::endl;
                        paintBlue();
                  }
                  else if(myVec2[i].second == "BLANCO"){
                        std::cout<<"blanco"<<std::endl;
                        paintWhite();
                  }
                  return(myVec2[i].second);
            }
      }
}

void up(float dir){
  dir=dir*30;
	miniwin::linea(px,py,px,py-dir);
	miniwin::refresca();
	py=py-dir;
}
void right(float dir){
  dir=dir*30;
  miniwin::linea(px,py,px+dir,py);
  miniwin::refresca();
  px=px+dir;
}
void left(float dir){
  dir=dir*30;
  miniwin::linea(px,py,px-dir,py);
  miniwin::refresca();
  px=px-dir;  
}
void down(float dir){
  dir=dir*30;
  miniwin::linea(px,py,px,py+dir);
  miniwin::refresca();
  py=py+dir;
    
}

void paintRed(){
	miniwin::color(miniwin::ROJO);
      miniwin::refresca();
}
void paintGreen(){
	miniwin::color(miniwin::VERDE);
      miniwin::refresca();
}
void paintBlue(){
	miniwin::color(miniwin::AZUL);
      miniwin::refresca();
}
void paintYellow(){
	miniwin::color(miniwin::AMARILLO);
      miniwin::refresca();
}
void paintWhite(){
      miniwin::color(miniwin::BLANCO);
      miniwin::refresca();
}

void yy::calculadora_parser::error(const location_type& lugar, const std::string& lexema)
{
  std::cout << "Error Sintactico " << lexema << std::endl;
}