%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
int yyeror(char *s);
%}

%token CREATE DROP TABLE

%token INSERT DELETE UPDATE

%token ENTERO FLOAT CADENA ID ESP OTHER

%token VARCHAR DECIMAL INTEGER

%token SELECT WHERE GROUP ORDER BY 

%token INTO VALUES SET FROM ASC DESC

%token MAX MIN AVG COUNT


%union{
int num;
char id;
char *reserved;
}

%%

CODE:
    LINE
;

LINE:
    |CRUD ";" LINE

CRUD:|CREATE ESP TABLE ESP ID '(' ARGS ')' {}
     |DROP ESP TABLE ESP ID {}
     |INSERT ESP INTO ESP ID ESP VALUES '('ARGS')'
     |DELETE ESP FROM ESP ID WHERE CONDITIONS{}
     |UPDATE ESP ID ESP SET ESP ID "=" (ID|ENTERO|FLOAT) {}
     |SELECT
     |SELECT
     |SELECT
     |SELECT
     |SELECT
     |SELECT
     |SELECT


CONDITIONS:CONDITION
           |CONDITION AND CONDITIONS
           |CONDITION OR CONDITIONS

CONDITION: ID '=' CADENA
          |ID '<>' CADENA
          |ID '=' ENTERO
          |ID '<>' ENTERO
          |ID '>' ENTERO
          |ID '<' ENTERO
          |ID '>=' ENTERO
          |ID '<=' ENTERO
          |ID '=' DECIMAL
          |ID '<>' DECIMAL
          |ID '>' DECIMAL
          |ID '<' DECIMAL
          |ID '>=' DECIMAL
          |ID '<=' DECIMAL


ARGS: ARG
     |ARG ', ' ARGS

ARG: ID ESP VARCHAR '('ENTERO')'
    |ID ESP VARCHAR
    |ID ESP INTEGER
    |ID ESP DECIMAL
    |ID ESP DECIMAL '('ENTERO')'

%%

int yyeror(char *s){
    printf("Error en la linea $s\n",s);
}


int manin(int argc, char **argv){
    yyparse();
    return 0;
}