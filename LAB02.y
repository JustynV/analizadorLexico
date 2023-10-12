%{
#include <stdio.h>
#include <string.h>
int yylex();
void yyerror(const char *s);

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
    |error ';' { yyerrok; }

CRUD:|CREATE ESP TABLE ESP ID '(' ARGS ')' {printf("CREATE VALIDO");}
     |DROP ESP TABLE ESP ID {printf("DROP VALIDO");}
     |INSERT ESP INTO ESP ID ESP VALUES '('VALS')' {printf("INSERT VALIDO");}
     |DELETE ESP FROM ESP ID WHERE ESP CONDITIONS {printf("DELETE VALIDO");}
     |UPDATE ESP ID ESP SET ESP ID '=' VAL ESP WHERE CONDITIONS {printf("UPDATE VALIDO");}
     |SELECT ESP IDS ESP FROM ESP ID {printf("SELECT VALIDO");}
     |SELECT ESP FUNCTION ESP FROM ESP ID {printf("SELECT VALIDO");}
     |SELECT ESP SELECTIONS FROM ESP ID {printf("SELECT VALIDO");}
     |SELECT ESP IDS ESP FROM ESP ID ESP WHERE ESP CONDITIONS {printf("SELECT VALIDO");}
     |SELECT ESP IDS ESP FROM ESP ID ESP GROUP ESP BY ESP ID {printf("SELECT VALIDO");}
     |SELECT ESP IDS ESP FROM ESP ID ESP ORDER ESP BY ESP IDS ESP ORDERS {printf("SELECT VALIDO");}
     |SELECT ESP IDS FROM ESP ID ESP WHERE ESP CONDITIONS ESP GROUP ESP BY ESP ID ESP ORDER ESP BY ESP IDS ESP ORDERS {printf("SELECT VALIDO");}

ORDERS:ASC
      |DESC

SELECTION:FUNCTION
         |ID

SELECTIONS:SELECTION
          |SELECTION ',' SELECTIONS

VAL: CADENA
    |ENTERO
    |FLOAT

VALS:VAL
    |VAL ','VALS

IDS:ID
   |ID ',' IDS
   |'*'

ARGS: ARG
     |ARG ',' ARGS

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
           |CONDITION ESP AND ESP CONDITIONS
           |CONDITION ESP OR ESP CONDITIONS

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

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error sintáctico en la línea: %s\n", s);
}

int main(){
    yyparse();
    return 0;
}
