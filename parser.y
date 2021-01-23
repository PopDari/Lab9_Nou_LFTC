%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define YYDEBUG 1
%}

%token MAIN
%token INT
%token WRITE
%token READ
%token BOOL
%token WHILE
%token STRING
%token IF
%token ELSE
%token CONSTANT
%token IDENTIFIER
%token PLUS
%token MINUS
%token MULTIPLY
%token DIVISION
%token ASSIGNMENT
%token LESS
%token GREATER
%token EQUAL
%token NOT_EQUAL
%token LEFT_SQUARE_BRACKET
%token RIGHT_SQUARE_BRACKET
%token LEFT_ROUND_BRACKET
%token RIGHT_ROUND_BRACKET
%token LEFT_CURLY_BRACKET
%token RIGHT_CURLY_BRACKET
%token SEMICOLON

%start program

%%

program : MAIN LEFT_CURLY_BRACKET declarationList stmtList RIGHT_CURLY_BRACKET ;

type : INT | BOOL | STRING ;
declaration : type IDENTIFIER SEMICOLON ;
declarationList : declaration | declaration declarationList ;
relation : LESS | GREATER | EQUAL | NOT_EQUAL ;
operator : PLUS | MINUS | MULTIPLY | DIVISION ;
item : IDENTIFIER | CONSTANT ;
expression : item operator expression | item operator item | item | LEFT_ROUND_BRACKET item operator expression RIGHT_ROUND_BRACKET | LEFT_ROUND_BRACKET item operator item RIGHT_ROUND_BRACKET ;
condition : expression relation expression ;

stmtList : stmt | stmt stmtList ;
stmt : assignStmt | readStmt | writeStmt | ifStmt | whileStmt ;
assignStmt : IDENTIFIER ASSIGNMENT expression SEMICOLON ;
readStmt : READ IDENTIFIER SEMICOLON ; 
writeStmt : WRITE IDENTIFIER SEMICOLON ; 
ifStmt : IF LEFT_ROUND_BRACKET condition RIGHT_ROUND_BRACKET LEFT_CURLY_BRACKET stmtList RIGHT_CURLY_BRACKET | IF LEFT_ROUND_BRACKET condition RIGHT_ROUND_BRACKET LEFT_CURLY_BRACKET stmtList RIGHT_CURLY_BRACKET ELSE LEFT_CURLY_BRACKET stmtList RIGHT_CURLY_BRACKET ;
whileStmt : WHILE LEFT_ROUND_BRACKET condition RIGHT_ROUND_BRACKET LEFT_CURLY_BRACKET stmtList RIGHT_CURLY_BRACKET ;

%%

yyerror(char *s)
{
  printf("%s\n", s);
}

extern FILE *yyin;

main(int argc, char **argv)
{
  if (argc > 1) 
    yyin = fopen(argv[1], "r");
  if ( (argc > 2) && ( !strcmp(argv[2], "-d") ) ) 
    yydebug = 1;
  if ( !yyparse() ) 
    fprintf(stderr,"\t Good !!!\n");
}