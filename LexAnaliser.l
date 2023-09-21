%{ 
#include <stdio.h>
FILE* salida;
int id = 1;
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

{entero} {fprintf(salida, "ENTERO = %s",yytext);};
{cadena} {fprintf(salida, "CADENA = %s",yytext);};
{identificador} {
    fprintf(salida, "id%i = %s",id,yytext);
    id+=1;
};
{decimal} {fprintf(salida, "decimal = %s",yytext);};
{CREATE} {fprintf(salida, "CREATE");};
{DROP} {fprintf(salida, "DROP");};


"\n"    {fprintf(salida, "\n\n");};
"\t"

.   {fprintf(salida, "ERROR = %s", yytext);};
%%

/*Código*/

int main(char *args[]){
    yyin = fopen(args[1], "r");
    if(yyin == NULL){
        printf("El archivo no existe");
        return 1;
    }
    else{
        yylex();
    }
    printf("Archivo analizado exitosamente");
    fclose(yyin);
    fclose(salida);
    return 0;
return 0;
}
