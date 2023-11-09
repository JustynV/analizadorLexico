%{
#include <stdio.h>
#include "y.tab.h"
int yylex();
void yyerror (char *s);

%}

%option yylineno 

%%

"CREATE"            {return(CREATE);}
"DROP"              {return(DROP);}
"TABLE"|"Table"|"table"             {return(TABLE);}
"INSERT"            {return(INSERT);}
"INTO"              {return(INTO);}
"DELETE"            {return(DELETE);}
"UPDATE"            {return(UPDATE);}
"SELECT"            {return(SELECT);}
"FROM"              {return(FROM);}
"WHERE"             {return(WHERE);}
"VALUES"            {return(VALUES);}
"SET"               {return(SET);}


"MAX"               {return(MAX);}
"MIN"               {return(MIN);}
"AVG"               {return(AVG);}
"COUNT"             {return(COUNT);}
"AND"               {return(AND);}
"OR"                {return(OR);}

"GROUP BY"          {return(GROUPBY);}                         
"ORDER BY"          {return(ORDERBY);}                      
"ASC"               {return ASC;}
"DESC"              {return DESC;}

"VARCHAR"           {return(VARCHAR);}
"INTEGER"           {return(INTEGER);}
"DECIMAL"           {return(DECIMAL);}



[a-zA-Z][a-zA-Z0-9]* {return(ID);}
[0-9]+              {return(ENTERO); }
[0-9]+\.[0-9]+      {return(FLOAT); }
\'[a-zA-Z0-9]+\'          {return(CADENA);}
\"[a-zA-Z0-9]+\"          {return(CADENA);}


[;]     {return (END);}
[=()<>*,'"] { return *yytext; }

[\n]+      ;
[ \t\r]+    ;
['.']+      {return OTHER;}
%%
int yywrap(void){
    return 1;
}