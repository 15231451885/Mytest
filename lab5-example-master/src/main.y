%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}
%token T_CHAR T_INT T_STRING T_BOOL
%token IDENTIFIER CHAR STRING INTEGER
%token WHILE RETURN IF ELSE FOR MAIN SCANF PRINTF T_VOID
%token BIGER BIGGEROREQUAL LESS LESSOREQUAL EQUAL NOTEQUAL
%token ADD SUB MUL DIV MOD 
%token ASSIGN ADDASS SUBASS MULASS DIVASS MODASS ADDADD SUBSUB
%token SEMICOLON
%token LBRACE RBRACE LBRACKET RBRACKET COMMA
%token AND OR NOT

%left ADD SUB 
%left MUL DIV MOD
%left EQUAL NOTEQUAL BIGGER LESS BIGGEROREQUAL LESSOREQUAL
%left OR 
%left AND
%left ASSIGN ADDASS SUBASS MULASS DIVASS MODASS
%right NOT UMINUS SPACE
  
%%

program
: T_VOID MAIN LBRACKET RBRACKET statements{root = new TreeNode(0, NODE_PROG); root->addChild($5);};

statements
:  statement {$$=$1;}
|  statements statement {$$=$1; $$->addSibling($2);}
;

statement
: SEMICOLON {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| declaration SEMICOLON {$$ = $1;}
| LBRACE statements RBRACE{$$=new TreeNode($2->lineno, NODE_BLOCK); $$->addChild($2);}
| LBRACE RBRACE {$$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| WHILE LBRACKET expr RBRACKET statement {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($3);
    node->addChild($5);
    $$ =node;
}
| IF LBRACKET expr RBRACKET statement {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($3);
    node->addChild($5);
    $$ =node;
}
| ELSE LBRACKET expr RBRACKET statement {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($3);
    node->addChild($5);
    $$ =node;
}
| FOR LBRACKET declaration SEMICOLON declaration SEMICOLON declaration RBRACKET statement{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($3);
    node->addChild($5);
    node->addChild($7);
    node->addChild($9);
    $$ =node;
}
;

declaration
: T IDENTIFIER ASSIGN expr{  // declare and init
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    node->addChild($4);
    $$ = node;   
} 
| T IDENTIFIER {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    $$ = node;   
}
| T IDENTIFIER COMMA IDENTIFIER{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    node->addChild($4);
    $$ = node;
}
| SCANF LBRACKET expr COMMA expr RBRACKET{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($3);
    node->addChild($5);
    $$ =node;
}
| PRINTF LBRACKET expr COMMA expr RBRACKET{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($3);
    node->addChild($5);
    $$ =node;
}
| IDENTIFIER ASSIGN expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| RETURN expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($2);
    $$ = node;   
}
| RETURN {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    $$ = node;
}
| expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    $$ = node;
}
;

expr
: IDENTIFIER {
    $$ = $1;
}
| INTEGER {
    $$ = $1;
}
| CHAR {
    $$ = $1;
}
| STRING {
    $$ = $1;
}
| expr ADD expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr SUB expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr MUL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr DIV expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr MOD expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr ADDASS expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr SUBASS expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr MULASS expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr DIVASS expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| ADD expr %prec UMINUS{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($2);
    $$ = node;
}
| SUB expr %prec UMINUS{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($2);
    $$ = node;
}
| NOT expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($2);
    $$ = node;
}
| SPACE expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_CAL;
    node->addChild($2);
    $$ = node;
}
| expr AND expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr OR expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr BIGGER expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr LESS expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr BIGGEROREQUAL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr LESSOREQUAL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr EQUAL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
| expr NOTEQUAL expr{
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_COMP;
    node->addChild($1);
    node->addChild($3);
    $$ = node;
}
;

T: T_INT {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_INT;} 
| T_CHAR {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_CHAR;}
| T_BOOL {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_BOOL;}
;

%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}
