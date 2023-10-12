%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

int identificador_count = 0; // Para contar identificadores
int error_count = 0; // Para contar errores léxicos

#define MAX_IDENTIFIERS 100 // Tamaño máximo del arreglo de nombres de identificadores
char* identifier_names[MAX_IDENTIFIERS]; // Arreglo para almacenar los nombres de los identificadores únicos

// Estructura para almacenar información sobre errores léxicos
struct LexicalError {
    char* lexeme; // Lexema que causó el error
    int line;     // Número de línea donde ocurrió el error
};

struct LexicalError lexical_errors[MAX_IDENTIFIERS]; // Arreglo para almacenar errores léxicos

%}

%option case-insensitive 
%option noyywrap

%%

"CREATE TABLE"      { printf("CREATE TABLE "); }
"DROP TABLE"        { printf("DROP TABLE "); }
"VARCHAR"           { printf("VARCHAR "); }
"INTEGER"           { printf("INTEGER "); }
"DROP"              { printf("DROP "); }
"INSERT INTO"            { printf("INSERT INTO"); }
"DELETE"            { printf("DELETE "); }
"UPDATE"            { printf("UPDATE "); }
"SELECT"            { printf("SELECT "); }
"FROM"              { printf("FROM "); }
"WHERE"             { printf("WHERE "); }
"AND"               { printf("AND "); }
"OR"                { printf("OR "); }
"SET"               { printf("SET "); }
"VALUES"            { printf("VALUES "); }
"GROUP BY"          { printf("GROUP BY "); }
"ORDER BY"          { printf("ORDER BY "); }
"ASC"               { printf("ASC "); }
"DESC"              { printf("DESC "); }
"MAX"               { printf("MAX "); }
"MIN"               { printf("MIN "); }
"AVG"               { printf("AVG "); }
"COUNT"             { printf("COUNT "); }
"DECIMAL"           { printf("DECIMAL "); }

[a-zA-ZáéíóúÁÉÍÓÚÑüÜ][a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]* {
    char* name = yytext;
    int duplicate = 0;
    for (int i = 0; i < identificador_count; i++) {
        // Convertir ambas cadenas a minúsculas antes de comparar
        char* lowercase_name = strdup(name);
        for (int j = 0; lowercase_name[j]; j++) {
            lowercase_name[j] = tolower(lowercase_name[j]);
        }
        char* lowercase_existing_name = strdup(identifier_names[i]);
        for (int j = 0; lowercase_existing_name[j]; j++) {
            lowercase_existing_name[j] = tolower(lowercase_existing_name[j]);
        }

        if (strcmp(lowercase_existing_name, lowercase_name) == 0) {
            duplicate = 1;
            free(lowercase_name);
            free(lowercase_existing_name);
            break;
        }
        free(lowercase_name);
        free(lowercase_existing_name);
    }

    if (!duplicate) {
        printf("ID%d=%s ", ++identificador_count, name);
        if (identificador_count <= MAX_IDENTIFIERS) {
            identifier_names[identificador_count - 1] = strdup(name);
        } else {
            printf("Error: Se ha alcanzado el límite máximo de identificadores.\n");
            exit(1);
        }
    }
}
[0-9]+\[a-zA-ZáéíóúÁÉÍÓÚÑüÜ]+        { printf("ERROR: %s ", yytext); }
[0-9]+              { printf("ENTERO: %s ", yytext); }
[0-9]+\.[0-9]+      { printf("DECIMAL: %s ", yytext); }
\'[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\'          {printf("cadena: %s ", yytext);}
[+]		    { printf("suma: %s ", yytext); }
[-]       { printf("resta: %s ", yytext); }
[*]		    { printf("asterisco: %s ", yytext); }
[/]		    { printf("div: %s ", yytext); }
[=]		    { printf("igual: %s ", yytext); }
[<]		    { printf("mayorque: %s ", yytext); }
[>]		    { printf("menorque: %s ", yytext); }
[,]		    { printf("coma: %s ", yytext); }
[;]		    { printf("puntocoma: %s ", yytext); }
[(]		    { printf("parar: %s ", yytext); }
[)]       { printf("parcier: %s ", yytext); }
[ \n]+                 ; // Ignorar saltos de línea
[ \t]+              ; // Ignorar espacios en blanco
.                   {
    // Almacenar errores léxicos
    struct LexicalError error;
    error.lexeme = strdup(yytext);
    error.line = yylineno;
    lexical_errors[error_count++] = error;
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

    // Imprimir la cantidad de identificadores y sus nombres
    printf("\nCantidad de identificadores encontrados: %d\n", identificador_count);
    for (int i = 0; i < identificador_count; i++) {
        printf("ID%d: %s\n", i + 1, identifier_names[i]);
        free(identifier_names[i]); // Liberar la memoria asignada
    }

    // Imprimir los errores léxicos encontrados
    printf("\nCantidad de errores léxicos encontrados: %d\n", error_count);
    for (int i = 0; i < error_count; i++) {
        printf("Error léxico en la línea %d: '%s'\n", lexical_errors[i].line, lexical_errors[i].lexeme);
        free(lexical_errors[i].lexeme); // Liberar la memoria asignada para el lexema del error
    }

    return 0;
}