%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "zeki.karamuk-hw3.h"

extern int yylineno;
int yylex();

ExprNode **expressions;
int expressionsSize = 100;
int exprIndex = 0;

char **errors;
int errorSize = 100;
int errorIndex = 0;
int semanticErrors = 0;

#define MAX_DECLARED 100
InputNode *inputs[MAX_DECLARED];
OutputNode *outputs[MAX_DECLARED];
Node *nodes[MAX_DECLARED];
int inputCount = 0, outputCount = 0, nodeCount = 0;

char current_decl_type[10];

ExprNode *makeExpressionNodeFromIdent(IdentNode ident);
ExprNode *makeExpressionNodeFromNumber(NumberNode number);
void processAssignment(ExprNode *lhs, ExprNode *rhs);
void reportError(const char *name, const char *msg, int lineNum);
void yyerror(const char *msg);
int isDeclared(const char *name, char type);
void addDeclaration(const char *name, char *current_decl_type, InputNode *inputs[], int *inputCount, OutputNode *outputs[], int *outputCount, Node *nodes[], int *nodeCount);
%}

%union {
    IdentNode identNode;
    NumberNode numberNode;
    ExprNode *exprNodePtr;
    int lineNum;
    char *name;
}

%token <identNode> tIDENTIFIER
%token tINPUT tOUTPUT tNODE tEVALUATE
%token tASSIGNMENT tAND tOR tXOR tNOT tCOMMA tLPR tRPR tTRUE tFALSE

%type <exprNodePtr> expression
%type <identNode> identifierList

%left tOR tXOR
%left tAND
%precedence tNOT

%start program

%%

program:
    declarations circuitDesign evaluations {
        for(int i = 0; i < inputCount; i++) {
            if(inputs[i] != NULL && inputs[i]->assigned == 0) {
                reportError(inputs[i]->name, "is not assigned", inputs[i]->lineNum);
            }
        }
        for(int i = 0; i < nodeCount; i++) {
            if(nodes[i] != NULL) {
                if(nodes[i]->used == 0) {
                    reportError(nodes[i]->name, "is not used", nodes[i]->lineNum);
                }
                if(nodes[i]->assigned == 0) {
                    reportError(nodes[i]->name, "is not assigned", nodes[i]->lineNum);
                }
            }
        }
        for(int i = 0; i < outputCount; i++) {
            if(outputs[i] != NULL && outputs[i]->assigned == 0) {
                reportError(outputs[i]->name, "is not assigned", outputs[i]->lineNum);
            }
        }
        if(semanticErrors > 0) {
            for(int i = 0; i < errorIndex; i++) {
                printf("%s\n", errors[i]);
            }
        } else {
            printf("OK\n");
        }
    }
    | /* empty */
    ;

declarations:
    declaration
    | declarations declaration
    ;

declaration:
    tINPUT { strcpy(current_decl_type, "input"); } identifierList
    | tOUTPUT { strcpy(current_decl_type, "output"); } identifierList
    | tNODE { strcpy(current_decl_type, "node"); } identifierList
    ;

identifierList:
    tIDENTIFIER {
        if (isDeclared($1.value, 'i') || isDeclared($1.value, 'o') || isDeclared($1.value, 'n')) {
            char *decl_type = NULL;
            for(int i = 0; i < nodeCount; i++) {
                if(strcmp(nodes[i]->name, $1.value) == 0) {
                    decl_type = "is already declared as a node";
                    break;
                }
            }
            if(decl_type == NULL) {
                for(int i = 0; i < outputCount; i++) {
                    if(strcmp(outputs[i]->name, $1.value) == 0) {
                        decl_type = "is already declared as an output";
                        break;
                    }
                }
            }
            if(decl_type == NULL) {
                for(int i = 0; i < inputCount; i++) {
                    if(strcmp(inputs[i]->name, $1.value) == 0) {
                        decl_type = "is already declared as an input";
                        break;
                    }
                }
            }
            reportError($1.value, decl_type, yylineno);
        } else {
            addDeclaration($1.value, current_decl_type, inputs, &inputCount, outputs, &outputCount, nodes, &nodeCount);
        }
    }
    | identifierList tCOMMA tIDENTIFIER {
        if (isDeclared($3.value, 'i') || isDeclared($3.value, 'o') || isDeclared($3.value, 'n')) {
            char *decl_type = NULL;
            for(int i = 0; i < nodeCount; i++) {
                if(strcmp(nodes[i]->name, $3.value) == 0) {
                    decl_type = "is already declared as a node";
                    break;
                }
            }
            if(decl_type == NULL) {
                for(int i = 0; i < outputCount; i++) {
                    if(strcmp(outputs[i]->name, $3.value) == 0) {
                        decl_type = "is already declared as an output";
                        break;
                    }
                }
            }
            if(decl_type == NULL) {
                for(int i = 0; i < inputCount; i++) {
                    if(strcmp(inputs[i]->name, $3.value) == 0) {
                        decl_type = "is already declared as an input";
                        break;
                    }
                }
            }
            reportError($3.value, decl_type, yylineno);
        } else {
            addDeclaration($3.value, current_decl_type, inputs, &inputCount, outputs, &outputCount, nodes, &nodeCount);
        }
    }
    ;

circuitDesign:
    assignment
    | circuitDesign assignment
    ;

assignment:
    tIDENTIFIER tASSIGNMENT expression {
        int is_input = isDeclared($1.value, 'i');
        int is_output = isDeclared($1.value, 'o');
        int is_node = isDeclared($1.value, 'n');

        if (is_input) {
            reportError($1.value, "is already declared as an input", yylineno);
        }
        else if (is_output) {
            for(int i = 0; i < outputCount; i++) {
                if(strcmp(outputs[i]->name, $1.value) == 0) {
                    if(outputs[i]->assigned == 1) {
                        reportError($1.value, "is already assigned", yylineno);
                    } else {
                        outputs[i]->assigned = 1;
                        ExprNode *lhs = makeExpressionNodeFromIdent($1);
                        processAssignment(lhs, $3);
                    }
                    break;
                }
            }
        }
        else if (is_node) {
            for(int i = 0; i < nodeCount; i++) {
                if(strcmp(nodes[i]->name, $1.value) == 0) {
                    if(nodes[i]->assigned == 1) {
                        reportError($1.value, "is already assigned", yylineno);
                    } else {
                        nodes[i]->assigned = 1;
                        ExprNode *lhs = makeExpressionNodeFromIdent($1);
                        processAssignment(lhs, $3);
                    }
                    break;
                }
            }
        }
        else {
            reportError($1.value, "is undeclared", yylineno);
        }
    }
    ;

expression:
    tNOT expression %prec tNOT {
        if ($2 == NULL) {
            $$ = NULL;
        } else {
            $$ = makeExpressionNodeFromNumber((NumberNode){NULL, yylineno});
            $$->value = !$2->value;
        }
    }
    | tIDENTIFIER {
        if (!isDeclared($1.value, 'i') && !isDeclared($1.value, 'n')) {
            reportError($1.value, "is undeclared", yylineno);
        }
        else {
            for(int i = 0; i < nodeCount; i++) {
                if(strcmp(nodes[i]->name, $1.value) == 0) {
                    nodes[i]->used = 1;
                    break;
                }
            }
        }
        $$ = makeExpressionNodeFromIdent($1);
    }
    | tTRUE {
        $$ = makeExpressionNodeFromNumber((NumberNode){NULL, yylineno});
        $$->value = 1;
    }
    | tFALSE {
        $$ = makeExpressionNodeFromNumber((NumberNode){NULL, yylineno});
        $$->value = 0;
    }
    | expression tAND expression {
        if (!$1 || !$3) {
            $$ = NULL;
        } else {
            $$ = makeExpressionNodeFromNumber((NumberNode){NULL, yylineno});
            $$->value = $1->value && $3->value;
        }
    }
    | expression tOR expression {
        if (!$1 || !$3) {
            $$ = NULL;
        } else {
            $$ = makeExpressionNodeFromNumber((NumberNode){NULL, yylineno});
            $$->value = $1->value || $3->value;
        }
    }
    | expression tXOR expression {
        if (!$1 || !$3) {
            $$ = NULL;
        } else {
            $$ = makeExpressionNodeFromNumber((NumberNode){NULL, yylineno});
            $$->value = $1->value ^ $3->value;
        }
    }
    | tLPR expression tRPR {
        $$ = $2;
    }
    ;

evaluations:
    evaluation
    | evaluations evaluation
    ;

evaluation:
    tEVALUATE tIDENTIFIER tLPR identifierList tRPR {
        if (!isDeclared($2.value, 'o')) {
            reportError($2.value, "is undeclared", yylineno);
        }
        else {
            fprintf(stderr, "Evaluating circuit %s at line %d.\n", $2.value, yylineno);
        }
    }
    ;

%%

void addDeclaration(const char *name, char *current_decl_type, InputNode *inputs[], int *inputCount, OutputNode *outputs[], int *outputCount, Node *nodes[], int *nodeCount) {
    if (strcmp(current_decl_type, "input") == 0) {
        if(*inputCount < MAX_DECLARED) {
            inputs[*inputCount] = (InputNode *)malloc(sizeof(InputNode));
            if (inputs[*inputCount] == NULL) {
                perror("Failed to allocate memory for InputNode");
                exit(EXIT_FAILURE);
            }
            inputs[*inputCount]->name = strdup(name);
            if (inputs[*inputCount]->name == NULL) {
                perror("Failed to duplicate input name");
                free(inputs[*inputCount]);
                exit(EXIT_FAILURE);
            }
            inputs[*inputCount]->lineNum = yylineno;
            inputs[*inputCount]->assigned = 0;
            (*inputCount)++;
        } else {
            fprintf(stderr, "Input declarations exceeded maximum limit.\n");
            exit(1);
        }
    }
    else if (strcmp(current_decl_type, "output") == 0) {
        if(*outputCount < MAX_DECLARED) {
            outputs[*outputCount] = (OutputNode *)malloc(sizeof(OutputNode));
            if (outputs[*outputCount] == NULL) {
                perror("Failed to allocate memory for OutputNode");
                exit(EXIT_FAILURE);
            }
            outputs[*outputCount]->name = strdup(name);
            if (outputs[*outputCount]->name == NULL) {
                perror("Failed to duplicate output name");
                free(outputs[*outputCount]);
                exit(EXIT_FAILURE);
            }
            outputs[*outputCount]->lineNum = yylineno;
            outputs[*outputCount]->assigned = 0;
            outputs[*outputCount]->value = 0;
            (*outputCount)++;
        } else {
            fprintf(stderr, "Output declarations exceeded maximum limit.\n");
            exit(1);
        }
    }
    else if (strcmp(current_decl_type, "node") == 0) {
        if(*nodeCount < MAX_DECLARED) {
            nodes[*nodeCount] = (Node *)malloc(sizeof(Node));
            if (nodes[*nodeCount] == NULL) {
                perror("Failed to allocate memory for Node");
                exit(EXIT_FAILURE);
            }
            nodes[*nodeCount]->name = strdup(name);
            if (nodes[*nodeCount]->name == NULL) {
                perror("Failed to duplicate node name");
                free(nodes[*nodeCount]);
                exit(EXIT_FAILURE);
            }
            nodes[*nodeCount]->lineNum = yylineno;
            nodes[*nodeCount]->assigned = 0;
            nodes[*nodeCount]->used = 0;
            (*nodeCount)++;
        } else {
            fprintf(stderr, "Node declarations exceeded maximum limit.\n");
            exit(1);
        }
    }
}

int isDeclared(const char *name, char type) {
    if(type == 'i') {
        for(int i = 0; i < inputCount; i++) {
            if(strcmp(inputs[i]->name, name) == 0)
                return 1;
        }
    }
    else if(type == 'o') {
        for(int i = 0; i < outputCount; i++) {
            if(strcmp(outputs[i]->name, name) == 0)
                return 1;
        }
    }
    else if(type == 'n') {
        for(int i = 0; i < nodeCount; i++) {
            if(strcmp(nodes[i]->name, name) == 0)
                return 1;
        }
    }
    return 0;
}

ExprNode *makeExpressionNodeFromIdent(IdentNode ident) {
    ExprNode *node = (ExprNode *)malloc(sizeof(ExprNode));
    if (node == NULL) {
        perror("Failed to allocate memory for ExprNode");
        exit(EXIT_FAILURE);
    }
    if (ident.value != NULL) {
        node->identifier = strdup(ident.value);
        if (node->identifier == NULL) {
            perror("Failed to duplicate identifier string");
            free(node);
            exit(EXIT_FAILURE);
        }
    } else {
        node->identifier = NULL;
    }
    node->lineNum = ident.lineNum;
    node->value = -1;
    return node;
}

ExprNode *makeExpressionNodeFromNumber(NumberNode number) {
    ExprNode *node = (ExprNode *)malloc(sizeof(ExprNode));
    if (node == NULL) {
        perror("Failed to allocate memory for ExprNode");
        exit(EXIT_FAILURE);
    }
    node->identifier = NULL;
    if (number.value != NULL) {
        node->value = atoi(number.value);
    } else {
        node->value = -1;
    }
    node->lineNum = number.lineNum;
    return node;
}

void processAssignment(ExprNode *lhs, ExprNode *rhs) {
    if (lhs && rhs) {
        lhs->value = rhs->value;
    } else {
        reportError(lhs ? lhs->identifier : "unknown", "is undeclared", lhs ? lhs->lineNum : 0);
    }
}

void reportError(const char *name, const char *msg, int lineNum) {
    char *error_msg = (char *)malloc(256);
    if (error_msg == NULL) {
        perror("Failed to allocate memory for error message");
        exit(EXIT_FAILURE);
    }
    sprintf(error_msg, "ERROR at line %d: %s %s.", lineNum, name, msg);
    errors[errorIndex++] = error_msg;
    semanticErrors++;
}

void yyerror(const char *msg) {
    char *error_msg = (char *)malloc(256);
    if (error_msg == NULL) {
        perror("Failed to allocate memory for error message");
        exit(EXIT_FAILURE);
    }
    sprintf(error_msg, "ERROR at line %d: %s.", yylineno, msg);
    errors[errorIndex++] = error_msg;
    semanticErrors++;
}

void freeMemory() {
    for(int i = 0; i < inputCount; i++) {
        if(inputs[i]) {
            free(inputs[i]->name);
            free(inputs[i]);
        }
    }
    for(int i = 0; i < outputCount; i++) {
        if(outputs[i]) {
            free(outputs[i]->name);
            free(outputs[i]);
        }
    }
    for(int i = 0; i < nodeCount; i++) {
        if(nodes[i]) {
            free(nodes[i]->name);
            free(nodes[i]);
        }
    }
    for(int i = 0; i < exprIndex; i++) {
        if(expressions[i]) {
            if(expressions[i]->identifier)
                free(expressions[i]->identifier);
            free(expressions[i]);
        }
    }
    for(int i = 0; i < errorIndex; i++) {
        if(errors[i])
            free(errors[i]);
    }
    free(expressions);
    free(errors);
}

int main(int argc, char **argv) {
    expressions = (ExprNode **)malloc(expressionsSize * sizeof(ExprNode *));
    if (expressions == NULL) {
        perror("Failed to allocate memory for expressions");
        exit(EXIT_FAILURE);
    }
    errors = (char **)malloc(errorSize * sizeof(char *));
    if (errors == NULL) {
        perror("Failed to allocate memory for errors");
        free(expressions);
        exit(EXIT_FAILURE);
    }

    if (yyparse()) {
        printf("ERROR\n");
        for(int i = 0; i < errorIndex; i++) {
            printf("%s\n", errors[i]);
        }
        freeMemory();
        return 1;
    } else {
        if(semanticErrors > 0){
        } else {
            printf("OK\n");
        }
        freeMemory();
        return 0;
    }
}

