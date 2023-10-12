%{
#include <stdio.h>
#include "y.tab.h"
%}

%option case-insensitive 
%option noyywrap

%%

"CREATE"            {yylval.reserved = yytext; return(CREATE);}
"DROP"              {yylval.reserved = yytext; return(DROP);}
"TABLE"             {yylval.reserved = yytext; return(TABLE);}
"INSERT INTO"       {yylval.reserved = yytext; return(INSERT);}
"DELETE"            {yylval.reserved = yytext; return(DELETE);}
"UPDATE"            {yylval.reserved = yytext; return(UPDATE);}
"SELECT"            {yylval.reserved = yytext; return(SELECT);}
"FROM"              {yylval.reserved = yytext; return(FROM);}
"WHERE"             {yylval.reserved = yytext; return(WHERE);}
"VALUES"            {yylval.reserved = yytext; return(VALUES);}
"SET"               {yylval.reserved = yytext; return(SET);}

" "                 {yylval.reserved = yytext; return(ESP);}

"MAX"               {yylval.reserved = yytext; return(MAX);}
"MIN"               {yylval.reserved = yytext; return(MIN);}
"AVG"               {yylval.reserved = yytext; return(AVG);}
"COUNT"             {yylval.reserved = yytext; return(COUNT);}
"AND"             {yylval.reserved = yytext; return(AND);}
"OR"             {yylval.reserved = yytext; return(OR);}


"VARCHAR"           {yylval.reserved = yytext; return(VARCHAR);}
"INTEGER"           {yylval.reserved = yytext; return(INTEGER);}
"DECIMAL"           {yylval.reserved = yytext; return(DECIMAL);}



[a-zA-ZáéíóúÁÉÍÓÚÑüÜ][a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]* {yylval.reserved = yytext; return(ID);}
[0-9]+              {yylval.number = atoi(yytext); return(ENTERO); }
[0-9]+\.[0-9]+      {yylval.number = atoi(yytext); return(FLOAT); }
\'[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\'          {yylval.reserved = yytext; return(CADENA);}
\"[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\"          {yylval.reserved = yytext; return(CADENA);}


[=()<>*;,'"] { return *yytext; }

[ \n]+      {} 
[ \t\r]+    {}
['.']+      {fprintf(stderr, "Error sintáctico en la línea %d: Carácter inesperado: %s\n", yylineno, yytext);}
%%