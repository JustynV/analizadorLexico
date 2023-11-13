%{
    #include <stdio.h>
    #include <string.h>

    int yylex();
    extern int yylineno;
    void yyerror (char *s);
    void showError ();
    int correct = 0;
%}
 
%define parse.error verbose

%token CREATE DROP TABLE

%token INSERT DELETE UPDATE

%token ENTERO FLOAT CADENA ID OTHER

%token VARCHAR DECIMAL INTEGER

%token SELECT WHERE GROUPBY ORDERBY OR AND

%token INTO VALUES SET FROM ASC DESC

%token MAX MIN AVG COUNT

%token END
%start CODE

%%

CODE:
    CRUD CODE 
    |CRUD;

CRUD:
     CREATE TABLE ID '(' ARGS ')' END
     |DROP TABLE ID END
     |INSERT INTO ID VALUES '('VALS')' END
     |DELETE FROM ID WHERE CONDITIONS END
     |UPDATE ID  SET ID '=' VAL WHERE CONDITIONS END
     |SELECT '*' FROM ID GROUPING END 
     |SELECT '*' FROM ID WHERE CONDITIONS GROUPING END
     |SELECT MIX FROM ID GROUPING END
     |SELECT MIX FROM ID WHERE CONDITIONS GROUPING END
     |error END{showError();}
     ;

ORDERS:ASC
      |DESC
      ;



GROUPING: GROUPBY ID 
    |ORDERBY IDS ORDERS 
    |GROUPBY ID ORDERBY IDS ORDERS 
    |ORDERBY IDS ORDERS GROUPBY ID
    |

VAL: CADENA
    |ENTERO
    |FLOAT
    ;

VALS:VAL
    |VAL ',' VALS
    ;

IDS: ID
    |ID ',' IDS
    ;

ARGS: ARG
     |ARG ','  ARGS
     ;

ARG: ID  VARCHAR '('ENTERO')'
    |ID  VARCHAR
    |ID  INTEGER
    |ID  DECIMAL
    |ID  DECIMAL '('ENTERO')'
    ;

FUNCTION:MAX '('ID')'
        |MIN '('ID')'
        |AVG '('ID')'
        |COUNT '('ID')'
        ;

MIX: ID
    |FUNCTION
    |ID ',' MIX
    |FUNCTION ',' MIX

CONDITIONS:CONDITION
           |AND CONDITION  CONDITIONS
           |OR CONDITION  CONDITIONS
           ;

CONDITION: ID '=' CADENA
          |ID '<''>' CADENA
          |ID '=' ENTERO
          |ID '<''>'  ENTERO
          |ID '>' ENTERO
          |ID '<' ENTERO
          |ID '>''=' ENTERO
          |ID '<''=' ENTERO
          |ID '='  FLOAT
          |ID '<''>'  FLOAT
          |ID '>' FLOAT
          |ID '<' FLOAT
          |ID '>''=' FLOAT
          |ID '<''=' FLOAT
          ;

%%
void showError () {
    printf("Error en la línea %d\n", yylineno);
}

void yyerror (char *s) {
    if(correct == 0){
        printf("Incorrecto\n\n");
        correct = 1;
    };
    printf("%s \n", s);
} 

int main(int argc, char **argv){
    extern FILE *yyin, *yyout;

    yyin = fopen(argv[1], "r");
    yyout = fopen(argv[3], "w");
    yyparse();

    if(correct == 0){
        printf("Correcto\n");
    };

    return 0;
};

