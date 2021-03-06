%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno=1;
%}
BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
EOL	(\r\n|\r|\n)
WHILTESPACE [[:blank:]]

INTEGER [0-9]+

CHAR \'.?\'
STRING \".+\"

IDENTIFIER [[:alpha:]_][[:alpha:][:digit:]_]*
%%

{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */


"int" return T_INT;
"bool" return T_BOOL;
"char" return T_CHAR;
"void" return T_VOID;

"if" return IF;
"else" return ELSE;
"while" return WHILE;
"for" return FOR;
"return" return RETURN;

"main" return MAIN;
"printf" return PRINTF;
"scanf" return SCANF;

"=" return ASSIGN;
"&" return SPACE;

">" return BIGGER;
">=" return BIGGEROREQUAL;
"<" return LESS;
"<=" return LESSOREQUAL;
"==" return EQUAL;
"!=" return NOTEQUAL;

"*" return MUL;
"/" return DIV;
"%" return MOD;
"+" return ADD;
"-" return SUB;
"++" return ADDADD;
"--" return SUBSUB;
"+=" return ADDASS;
"-=" return SUBASS;
"*=" return MULASS;
"/=" return DIVASS;
"%=" return MODASS;

"!" return NOT;
"&&" return AND;
"||" return OR;

";" return  SEMICOLON;
"(" return LBRACKET;
")" return RBRACKET;
"{" return LBRACE;
"}" return RBRACE;
"," return COMMA;

{INTEGER} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}

{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->int_val = yytext[1];
    yylval = node;
    return CHAR;
}

{STRING} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_STRING;
    node->str_val = yytext;
    yylval = node;
    return STRING;
}
{IDENTIFIER} {
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    return IDENTIFIER;
}

{WHILTESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}
%%
