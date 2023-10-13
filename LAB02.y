%{
#include <stdio.h>
int yylex();
int yyerror(char *s);
extern int yylineno;
%}
 
%token CREATE DROP TABLE

%token INSERT DELETE UPDATE

%token ENTERO FLOAT CADENA ID ESP OTHER

%token VARCHAR DECIMAL INTEGER

%token SELECT WHERE GROUP ORDER BY OR AND

%token INTO VALUES SET FROM ASC DESC

%token MAX MIN AVG COUNT


%union{
int number;
char id;
char *reserved;
}

%%

CODE:
    LINE
;

LINE:
    |CRUD ';' LINE

CRUD:
     |CREATE ESP TABLE ESP ID '(' ARGS ')' 
     |DROP ESP TABLE ESP ID 
     |INSERT ESP INTO ESP ID ESP VALUES '('VALS')'
     |DELETE ESP FROM ESP ID WHERE ESP CONDITIONS 
     |UPDATE ESP ID ESP SET ESP ID '=' VAL ESP WHERE CONDITIONS 
     |SELECT ESP IDS ESP FROM ESP ID 
     |SELECT ESP FUNCTION ESP FROM ESP ID
     |SELECT ESP IDS ESP FROM ESP ID ESP WHERE ESP CONDITIONS 
     |SELECT ESP IDS ESP FROM ESP ID ESP GROUP ESP BY ESP ID 
     |SELECT ESP IDS ESP FROM ESP ID ESP ORDER ESP BY ESP IDS ESP ORDERS 
     |SELECT ESP IDS FROM ESP ID ESP WHERE ESP CONDITIONS ESP GROUP ESP BY ESP ID ESP ORDER ESP BY ESP IDS ESP ORDERS {printf("SELECT VALIDO");}
     |error_state

ORDERS:ASC
      |DESC

VAL: CADENA
    |ENTERO
    |FLOAT

VALS:VAL
    |VAL ',' VALS

IDS: ID
    |ID ',' IDS
    |'*'

ARGS: ARG
     |ARG ',' ESP ARGS

ARG: ID ESP VARCHAR '('ENTERO')'
    |ID ESP VARCHAR
    |ID ESP INTEGER
    |ID ESP DECIMAL
    |ID ESP DECIMAL '('ENTERO')'

FUNCTION:MAX '('ID')'
        |MIN '('ID')'
        |AVG '('ID')'
        |COUNT '('ID')'

CONDITIONS:CONDITION
           |AND CONDITION ESP CONDITIONS
           |OR CONDITION ESP CONDITIONS

CONDITION: ID '=' CADENA
          |ID '<''>' CADENA
          |ID '=' ENTERO
          |ID '<''>'  ENTERO
          |ID '>' ENTERO
          |ID '<' ENTERO
          |ID '>''=' ENTERO
          |ID '<''=' ENTERO
          |ID '=' DECIMAL
          |ID '<''>'  DECIMAL
          |ID '>' DECIMAL
          |ID '<' DECIMAL
          |ID '>''=' DECIMAL
          |ID '<''=' DECIMAL

error_state: error{}

%%

int yyerror(char *s) {
    printf("Error en la línea %d\n", yylineno);
}

int main(){
    yyparse();
    return 0;
}
