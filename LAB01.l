%{
#include <stdio.h>
#include "y.tab.h"

int saltos_count = 1;
int error_count = 0;
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
\'[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\'          {yylval.id = yytext; return(CADENA);}
\"[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\"          {yylval.id = yytext; return(CADENA);}


[=()<>*;,'"] { return *yytext; }

[ \n]+      {saltos_count++;} // Contar saltos de línea para saber la línea actual
[ \t\r]+      {}; // Ignorar espacios en blanco
['.']+      { 
    
    if(error_count == 0){
        printf("Incorrecto\n\n");
        error_count++;
    }
    printf("Error en la línea %i\n", saltos_count);return (OTHER); 
    }




%%

int main(int argc, char* argv[]) {
    if (argc != 2) {
        printf("Uso: %s archivo_de_entrada\n", argv[0]);
        return 1;
    }

    FILE* archivo = fopen(argv[1], "r");
    if (archivo == NULL) {
        printf("No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }

    yyin = archivo;

    while (yylex() != 0) {}

    fclose(archivo);
    
    if(error_count == 0){
        printf("Correcto");
    }

  return 0;
}