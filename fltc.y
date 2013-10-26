%{

#include<stdio.h>
#include<stdlib.h>

%}

%token LT GT EQ NE AND OR WS OP ID LIT CLASS MAIN IF THEN GOTO PRINT READ LABEL STMT_LABEL TYPE INT_LIT STR_LIT BOOL_LIT CHAR_LIT

%right '='
%left OR
%left AND
%left EQ NE
%left '>' '<' GT LT
%left '+' '-'
%left '*' '/'
%right '!'

%%

PROGRAM: CLASS MAIN '{' MULTIFIELD MULTISTATE '}' { printf("No errors\n"); }
       ;
MULTIFIELD:
	  | FIELD_DECL MULTIFIELD
	  ;
MULTISTATE: 
	  | STMT MULTISTATE
	  ;

FIELD_DECL: TYPE CST
	  ;
CST: ID ',' CST
   | ID '[' INT_LIT ']' ',' CST
   | ID ';'
   | ID '[' INT_LIT ']' ';'
   ;

STMT: LABELLED_STMT
    | LOCATION '=' EXPR ';'
    | IF EXPR THEN GOTO LABEL ';'
    | GOTO LABEL ';'
    | METHOD_CALL ';'
    ;
LABELLED_STMT: STMT_LABEL STMT

EXPR: LITERAL 
    | LOCATION
    | EXPR '+' EXPR
    | EXPR '-' EXPR
    | EXPR '*' EXPR
    | EXPR '/' EXPR
    | EXPR '<' EXPR
    | EXPR '>' EXPR
    | EXPR LT EXPR
    | EXPR GT EXPR
    | EXPR EQ EXPR
    | EXPR NE EXPR
    | EXPR OR EXPR
    | EXPR AND EXPR
    | '-' EXPR
    | '!' EXPR
    | '(' EXPR ')'
    ;

LOCATION: ID 
	| ID '[' EXPR ']'

METHOD_CALL: PRINT '(' MTHD_REC ')' 
	   | READ '(' LOCATION ')'
	   ;
MTHD_REC: EXPR ',' MTHD_REC
	| EXPR
	;

LITERAL: BOOL_LIT
       | INT_LIT
       | STR_LIT
       | CHAR_LIT
       ;

%%
extern int count;
int main(void){
	//yy_flex_debug = 1;
	//yydebug = 1;
	count = 1;
	yyparse();
	return 0;
}
int yyerror(const char *s){
	printf("Error encountered at line %d: %s\n", count, s);
	return 0;
}
