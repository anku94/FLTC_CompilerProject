%{
#include <stdio.h>
#include "fltc.tab.h"
#define ZERO 0
#define ONE 1
int count;
int gotoCame = 0;
%}

digit	[0-9]
letter	[A-Za-z]
int_lit {digit}+
bool_lit "True"|"False"
char_lit \'.\'
str_lit \".*\"
whitespace [ \t]
ID [a-zA_Z_][a-zA-Z0-9_]*

%%

{whitespace}		{  }
"\n"			{}

"class"			{ return CLASS; }
"main"			{ return MAIN; }
"int"|"boolean"|"char"	{ return TYPE; }
"if"			{ return IF; }
"then"			{ return THEN; }
"goto"			{ gotoCame = ONE; return GOTO; }
"print"			{ return PRINT; }
"read"			{ return READ; }

{ID}:			{ return STMT_LABEL; }
{ID}			{
				if(gotoCame){
					gotoCame = ZERO;
					return LABEL;
				}
				else return ID; 
			}

{bool_lit}		{ return BOOL_LIT; }
{int_lit}		{ return INT_LIT; }
{char_lit}		{ return CHAR_LIT; }
{str_lit}		{ return STR_LIT; }

"+" |
"-" |
"*" |
"/" |
"<" |
">" |
"=" |
"!" |
";" |
"," |
"(" |
")" |
"[" |
"]" |
"{" |
"}" 		{ return yytext[0]; }
"<="		{ return LT; }
">="		{ return GT; }
"=="		{ return EQ; }
"!="		{ return NE; }
"&&"		{ return AND; }
"||"		{ return OR; }
.		{ printf("Unmatched text: %s\nInvalid input\n", yytext); }

%%

int yywrap(void){
	return 1;
}
