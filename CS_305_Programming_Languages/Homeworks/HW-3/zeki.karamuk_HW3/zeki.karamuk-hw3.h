#ifndef __ZEKI_KARAMUK_HW3_H
#define __ZEKI_KARAMUK_HW3_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Struct for Input
typedef struct InputNode {
    char *name;
    int lineNum;
    int assigned;
} InputNode;

// Struct for Output
typedef struct OutputNode {
    char *name;
    int lineNum;
    int assigned;
   int value;
} OutputNode;

// Struct for Node
typedef struct Node {
    char *name;
    int lineNum;
    int assigned;
    int used;
} Node;

// Struct for Expressions
typedef struct ExprNode {
    char *identifier;
    int lineNum;
    int value;
} ExprNode;

// Struct for Numbers (used for true/false values)
typedef struct NumberNode {
    char *value;
    int lineNum;
} NumberNode;

// Struct for Identifiers
typedef struct IdentNode {
    char *value;
    int lineNum;
} IdentNode;

void reportError(const char *msg, const char *name, int lineNum);

#endif

