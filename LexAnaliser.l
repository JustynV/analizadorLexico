%{ 
#include <stdio.h>
#include <stdlib.h>
int id = 1;
char * salida;
%}

/*Definiciones*/
TABLE ["TABLE" | "Table"]
CREATE ["CREATE"]
DROP ["DROP"]

SELECT ["SELECT"]
WHERE ["WHERE"]
GROUPBY ["GROUP BY"]
ORDERBY ["ORDER BY"]

INSERT ["INSERT"]
DELETE ["DELETE"]
UPDATE ["UPDATE"]

MAX ["MAX"]
MIN ["MIN"]
AVG ["AVG"]
COUNT ["COUNT"]

INTO ["INTO"]
VALUES ["VALUES"]
FROM ["FROM"]
SET ["SET"]
ASC ["ASC"]
DESC ["DESC"]

numero [0-9]
caracter [a-zA-z|0-9]

identificador [a-zA-Z]{caracter}*
cadena \"{caracter}*\"
entero {numero}+
decimal {numero}+\.{numero}+
suma ["+"]
resta ["-"]
multiplicacion ["*"]
division ["/"]
igualdad ["=="]
diferencia ["<>"]
mayorque [">"]
menorque ["<"]
mayorigual [">="]
menorigual ["<="]
conjuncion ["AND"]
disyuncion ["OR"]

Asignar ["="]
puntcoma [";"]
Parabre ["("]
Parcierra [")"] 
Coma [","]
Asterisco ["*"]

INTEGER ["INTEGER"]
DECIMAL ["DECIMAL"]
VARCHAR ["VARCHAR"]
%%

{entero} {strcat(salida, strcat("ENTERO = ",yytext));};
{cadena} {strcat(salida, strcat("CADENA = ",yytext));};
{decimal} {strcat(salida, strcat("decimal = ",yytext));};
{CREATE} {strcat(salida, "CREATE");};
{DROP} {strcat(salida, "DROP");};


"\n"    {strcat(salida, "\n\n");};
"\t"

.   {strcat(salida, strcat("ERROR = ",yytext));};
%%

/*Código*/

char * main(char *args[]){
    yyin = fopen(args[0], "r");
    if(yyin == NULL){
        return "El archivo no existe";
    }
    yylex();
    printf("Archivo analizado exitosamente");
    fclose(yyin);
    return salida;
}

int yywrap() {
    return 1;
}


