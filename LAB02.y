%{
    #include <stdio.h>
    #include <string.h>

    int yylex();
    extern int yylineno;
    void yyerror (char *s);
    void showError (char *s);
    bool correct = true;
%}
 

 %define parse.error verbose

%token CREATE DROP TABLE

%token INSERT DELETE UPDATE

%token ENTERO FLOAT CADENA ID ESP OTHER

%token VARCHAR DECIMAL INTEGER

%token SELECT WHERE GROUP ORDER BY OR AND

%token INTO VALUES SET FROM ASC DESC

%token MAX MIN AVG COUNT

%start CODE

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
     |error_state ';' {showError();}

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


%%
void showError () {
    printf("Error en la línea %d\n", yylineno);
}

void yyerror (char *s) {
    if(correct){
        printf("Incorrecto\n\n");
        correct = false;
    };
    /*printf("%s \n", s);*/
    /*printf("Error en linea %d\n", yylineno);*/
} 

int main(int argc, char **argv){
    extern FILE *yyin, *yyout;

    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[3], "w");
    yyparse();

    if(Correcto){
        printf("Correcto\n");
    };

    return 0;
};

