%{
#include <stdio.h>
#include "LAB02.tab.h"
%}

%option yylineno 

%%

"CREATE"            {return(CREATE);}
"DROP"              {return(DROP);}
"TABLE"             {return(TABLE);}
"INSERT INTO"       {return(INSERT);}
"DELETE"            {return(DELETE);}
"UPDATE"            {return(UPDATE);}
"SELECT"            {return(SELECT);}
"FROM"              {return(FROM);}
"WHERE"             {return(WHERE);}
"VALUES"            {return(VALUES);}
"SET"               {return(SET);}

" "                 {return(ESP);}

"MAX"               {return(MAX);}
"MIN"               {return(MIN);}
"AVG"               {return(AVG);}
"COUNT"             {return(COUNT);}
"AND"               {return(AND);}
"OR"                {return(OR);}


"VARCHAR"           {return(VARCHAR);}
"INTEGER"           {return(INTEGER);}
"DECIMAL"           {return(DECIMAL);}



[a-zA-ZáéíóúÁÉÍÓÚÑüÜ][a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]* {return(ID);}
[0-9]+              {return(ENTERO); }
[0-9]+\.[0-9]+      {return(FLOAT); }
\'[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\'          {return(CADENA);}
\"[a-zA-Z0-9áéíóúÁÉÍÓÚÑüÜ]+\"          {return(CADENA);}


[=()<>*;,'"] { return *yytext; }

[\n]+      {yylineno++;} 
[ \t\r]+    {}
['.']+      {return OTHER;}
%%
