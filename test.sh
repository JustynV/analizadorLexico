#!/bin/bash
clear
yacc -d LAB02.y
lex LAB01.l
gcc lex.yy.c y.tab.c -o labs

./labs entrada2.txt > salida.txt

echo "Ejecucion terminada"