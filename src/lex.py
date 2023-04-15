import re

import ply.lex as lex
from ply.lex import TOKEN

# token list
tokens = (
    # assignment
    'IDENTIFIER',

    'COMMENT1',
    'COMMENT2',


    # types
    'FLOAT_CONSTANT',
    'INTEGER_CONSTANT',
    'STRING_CONSTANT',
    'CHAR_CONSTANT',
    'BOOL_CONSTANT',


    # 'CHAR',
    'RIGHT_ASSIGN',
    'LEFT_ASSIGN',
    'ADD_ASSIGN',
    'SUB_ASSIGN',
    'MUL_ASSIGN',
    'DIV_ASSIGN',
    'MOD_ASSIGN',
    'AND_ASSIGN',
    'XOR_ASSIGN',
    'OR_ASSIGN',

    'RIGHT_OP',
    'LEFT_OP',
    'INC_OP',
    'DEC_OP',
    'PTR_OP',
    'AND_OP',
    'OR_OP',
    'EQ_OP',
    'NEQ_OP',
    'LTE',
    'GTE',
    'BUILT_IN_FUNCTION'
    # 'INCLUDE_ORDER'
)

reserved_keywords = {
    # ref to https://blog.csdn.net/keke193991/article/details/17566937
    # ref to https://blog.csdn.net/qq_41687938/article/details/119349135
    'asm': 'ASM',
    'auto': 'AUTO',
    'bool': 'BOOL',
    'break': 'BREAK',
    'case': 'CASE',
    'catch': 'CATCH',
    'char': 'CHAR',
    'class': 'CLASS',
    'const': 'CONST',
    'const_cast': 'CONST_CAST',
    'continue': 'CONTINUE',
    'default': 'DEFAULT',
    'delete': 'DELETE',
    'do': 'DO',
    'double': 'DOUBLE',
    'dynamic_cast': 'DYNAMIC_CAST',
    'else': 'ELSE',
    'enum': 'ENUM',
    'explicit': 'EXPLICIT',
    'export': 'EXPORT',
    'extern': 'EXTERN',
    'float': 'FLOAT',
    'for': 'FOR',
    'friend': 'FRIEND',
    'goto': 'GOTO',
    'if': 'IF',
    'inline': 'INLINE',
    'int': 'INT',
    'long': 'LONG',
    'mutable': 'MUTABLE',
    'namespace': 'NAMESPACE',
    'new': 'NEW',
    'operator': 'OPERATOR',
    'private': 'PRIVATE',
    'protected': 'PROTECTED',
    'public': 'PUBLIC',
    'register': 'REGISTER',
    'reinterpret_cast': 'REINTERPRET_CAST',
    'return': 'RETURN',
    'short': 'SHORT',
    'signed': 'SIGNED',
    'sizeof': 'SIZEOF',
    'static': 'STATIC',
    'static_cast': 'STATIC_CAST',
    'struct': 'STRUCT',
    'switch': 'SWITCH',
    'template': 'TEMPLATE',
    'this': 'THIS',
    'throw': 'THROW',
    'try': 'TRY',
    'typedef': 'TYPEDEF',
    'typeid': 'TYPEID',
    'typename': 'TYPENAME',
    'union': 'UNION',
    'unsigned': 'UNSIGNED',
    'using': 'USING',
    'virtual': 'VIRTUAL',
    'void': 'VOID',
    'volatile': 'VOLATILE',
    'restrict':'RESTRICT',
    'while': 'WHILE',
}

tokens = tokens + tuple(reserved_keywords.values())


t_RIGHT_ASSIGN = r'>>='
t_LEFT_ASSIGN = r'<<='
t_ADD_ASSIGN = r'\+='
t_SUB_ASSIGN = r'-='
t_MUL_ASSIGN = r'\*='
t_DIV_ASSIGN = r'/='
t_MOD_ASSIGN = r'%='
t_AND_ASSIGN = r'&='
t_XOR_ASSIGN = r'\^='
t_OR_ASSIGN = r'\|='

t_RIGHT_OP = r'>>'
t_LEFT_OP = r'<<'
t_INC_OP = r'\+\+'
t_DEC_OP = r'--'
t_PTR_OP = r'->'
t_AND_OP = r'&&'
t_OR_OP = r'\|\|'
t_EQ_OP = r"=="
t_NEQ_OP = r"!="

t_LTE = r"\<\="
t_GTE = r"\>\="

t_ignore  = ' \t\v\f'


literals = "+-*/%|&~^<>=!?()[]{}.,;:\\\'\""


def t_INTEGER_CONSTANT(t):
    r'(((((0x)|(0X))[0-9a-fA-F]+)|(\d+))([uU][lL]|[lL][uU]|[uU]|[lL])?)'
    return t

def t_FLOAT_CONSTANT(t):
    r'((\d+)(\.\d+)(e(\+|-)?(\d+))? | (\d+)e(\+|-)?(\d+))([lL]|[fF])?'
    return t

def t_CHAR_CONSTANT(t):
    r'(L)?\'([^\\\n]|(\\(.|\n)))*?\''
    return t

def t_BOOL_CONSTANT(t):
    r'(true|false)'
    return t

def t_STRING_CONSTANT(t):
    r'"(\\.|[^\\"])*"'
    return t

# def t_BUILT_IN_FUNCTION(t):
#     r'(scanf|printf|getchar|strlen|cin|cout|endl)'
#     return t

# C++ IDENTIFIER
def t_IDENTIFIER(t):
    r"[_a-zA-Z][_a-zA-Z0-9]*"
    if t.value.lower() in reserved_keywords:
        t.type = reserved_keywords[t.value.lower()]
    return t

def t_newline(t):
    r'\n+'
    t.lexer.lineno += len(t.value)


# error handle
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)

# comment
def t_COMMENT2(t):
    r'(//.*?(\n|$))'
    pass

def t_COMMENT1(t):
    r'(/\*(.|\n)*?\*/)'
    pass

# create lexer
lexer = lex.lex()


if __name__ == '__main__':
    import sys
    from preprocess import preprocess

    if len(sys.argv) > 1:  # specify file
        try:
            file_data, ok = preprocess(sys.argv[1])
            if ok is not True:
                print('preprocess error:', file_data)
            else:
                lexer.input(file_data)
                while 1:
                    token = lexer.token()
                    if not token:
                        break  # not input
                    print(token)
        except Exception as e:
            print(e)
    else:
        print("please input c++ file path")


