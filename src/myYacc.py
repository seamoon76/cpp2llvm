import re
import ply.yacc as yacc
import cAST as myAST
from lex import *
from utils import handle_decl_change

# 开始
def p_translation_unit_or_empty(p):
    """ translation_unit_or_empty   : translation_unit
                                    | empty
    """
    p[0] = myAST.TopAST(p[1]) if p[1] is not None else myAST.TopAST([])

def p_translation_unit(p):
    """ translation_unit    : translation_unit external_declaration
                            | external_declaration
    """
    if len(p) > 2:
        if p[2] is not None:
            p[1].extend(p[2])
    p[0] = p[1]


def p_initializer_ass(p):
    """ initializer : assignment_expression
    """
    p[0] = p[1]

def p_initializer_in(p):
    """ initializer : '{' initializer_list_orempty '}'
                    | '{' initializer_list ',' '}'
    """
    if p[2] is None:
        p[0] = myAST.ContentList(listType='InitList',elements=[])
    else:
        p[0] = p[2]

def p_initializer_list(p):
    """ initializer_list    : initializer
                            | initializer_list ',' initializer
    """
    if len(p) == 2:
        init = p[1]
        p[0] = myAST.ContentList(listType='InitList', elements=[init])
    else:
        init = p[3]
        p[1].elements.append(init)
        p[0] = p[1]

def p_init_declarator(p):
    """ init_declarator : declarator
                        | declarator '=' initializer
    """
    init_ = None
    if len(p) > 2:
        init_ = p[3]
    p[0] = dict(type=p[1], init=init_)

def p_init_declarator_list_idec(p):
    """ init_declarator_list    : init_declarator
                                | init_declarator_list ',' init_declarator
    """
    if len(p) == 4:
        p[0] = p[1] + [p[3]]
    else:
        p[0] = [p[1]]

# 表达式
def p_declaration_specifiers_orempty(p):
    """declaration_specifiers_orempty   : empty
                                    | declaration_specifiers
    """
    p[0] = p[1]


def p_empty(p):
    """ empty :
    """
    p[0] = None


def p_declaration_specifiers_td(p):
    """ declaration_specifiers  : type_specifier declaration_specifiers_orempty
    """
    if p[2]:
        p[2]['spec'].insert(0, p[1])
        p[0] = p[2]
    else:
        p[0] = dict(qual=[], spec=[p[1]])


def p_type_specifier(p):
    ''' type_specifier : VOID
                       | CHAR
                       | SHORT
                       | INT
                       | LONG
                       | FLOAT
                       | DOUBLE
                       | SIGNED
                       | UNSIGNED
                       | BOOL
                       | struct_specifier
    '''
    p[0] = p[1]

def p_declaration_list_orempty(p):
    """declaration_list_orempty : empty
                            | declaration_list
    """
    p[0] = p[1]

def p_declaration(p):
    """ declaration : declaration_specifiers init_declarator_list_orempty ';'
    """
    decl_spec = p[1]
    struct = None
    if isinstance(decl_spec['spec'][0], myAST.Struct):
        struct = decl_spec['spec'][0]
    init_decl_list = p[2]

    p[0] = []

    for init_decl in init_decl_list:
        type = init_decl['type']
        if struct is not None:
            if isinstance(type, myAST.Identifier):
                kws = {'name': type.name, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'], 'type': struct,
                       'init': init_decl['init']}
                declaration = myAST.DeclarationNode(**kws)

            else:
                while not isinstance(type.type, myAST.Identifier):
                    type = type.type
                declname = type.type.name
                type.type = struct
                kws = {'name': declname, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'], 'type': init_decl['type'],
                       'init': None}
                declaration = myAST.DeclarationNode(**kws)
        else:
            while not isinstance(type, myAST.Identifier):
                type = type.type
            type.spec = decl_spec['spec']
            kws = {'name': type.name, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'], 'type': init_decl['type'],
                   'init': init_decl['init']}
            declaration = myAST.DeclarationNode(**kws)
        p[0].insert(0, declaration)

def p_declaration_list(p):
    """ declaration_list    : declaration
                            | declaration_list declaration
    """
    if len(p) == 3:
        p[0] = p[1] + p[2]
    else:
        p[0] = p[1]


def p_identifier_list_orempty(p):
    """identifier_list_orempty  : empty
                            | identifier_list
    """
    p[0] = p[1]

def p_identifier_list(p):
    """ identifier_list : identifier
                        | identifier_list ',' identifier
    """
    if len(p) == 2:
        p[0] = myAST.ContentList(listType='ParamList', elements=[p[1]])
    else:
        p[1].elements.append(p[3])
        p[0] = p[1]

def p_identifier(p):
    """ identifier  : IDENTIFIER """
    kws = {'name': p[1], 'spec': None}
    p[0] = myAST.Identifier(**kws)

# 跳转
def p_jump_statement_b(p):
    """ jump_statement  : BREAK ';' """
    p[0] = myAST.ControlLogic(logicType='Break')

def p_jump_statement_c(p):
    """ jump_statement  : CONTINUE ';' """
    p[0] = myAST.ControlLogic(logicType='Continue')

def p_jump_statement_r(p):
    """ jump_statement  : RETURN ';'
                        | RETURN expression ';'
    """
    if len(p)==3:
        kws = {"return_result": None}
        p[0] = myAST.ControlLogic(logicType='Return',**kws)
    else:
        kws={"return_result":p[2]}
        p[0] = myAST.ControlLogic(logicType='Return',**kws)


def p_init_declarator_list_orempty(p):
    """init_declarator_list_orempty  : empty
                            | init_declarator_list
    """
    p[0] = p[1]

def p_assignment_expression_orempty(p):
    """assignment_expression_orempty    : empty
                                    | assignment_expression
    """
    p[0] = p[1]


def p_assignment_operator(p):
    ''' assignment_operator : '='
                            | MUL_ASSIGN
                            | DIV_ASSIGN
                            | MOD_ASSIGN
                            | ADD_ASSIGN
                            | SUB_ASSIGN
                            | LEFT_ASSIGN
                            | RIGHT_ASSIGN
                            | AND_ASSIGN
                            | XOR_ASSIGN
                            | OR_ASSIGN '''
    p[0] = p[1]

def p_argument_expression_list(p):
    """ argument_expression_list    : assignment_expression
                                    | argument_expression_list ',' assignment_expression
    """
    if len(p) == 2:
        p[0] = myAST.ContentList(listType='ExprList', elements=[p[1]])
    else:
        p[1].elements.append(p[3])
        p[0] = p[1]

def p_assignment_expression(p):
    """ assignment_expression   : conditional_expression
                                | unary_expression assignment_operator assignment_expression
    """
    if len(p) == 2:
        p[0] = p[1]
    else:
        kws={'left':p[1],'right':p[3]}
        p[0] = myAST.Operation(OpType='Assignment',OpName=p[2],**kws)

def p_block_item_list_orempty(p):
    """block_item_list_orempty  : empty
                            | block_item_list
    """
    p[0] = p[1]

def p_constant_expression_orempty(p):
    """constant_expression_orempty  : empty
                            | constant_expression
    """
    p[0] = p[1]

def p_specifier_qualifier_list_orempty(p):
    """specifier_qualifier_list_orempty  : empty
                            | specifier_qualifier_list
    """
    p[0] = p[1]

# block
def p_block_item(p):
    """ block_item  : declaration
                    | statement
    """
    p[0] = p[1] if isinstance(p[1], list) else [p[1]]


def p_block_item_list(p):
    """ block_item_list : block_item
                        | block_item_list block_item
    """
    if len(p) == 2:
        p[0] = p[1]
    elif len(p) == 3:
        if p[2] == [None]:
            p[0] = p[1]
        else:
            p[0] = p[1] + p[2]


def p_expression_orempty(p):
    """expression_orempty    : empty
                        | expression
    """
    p[0] = p[1]

def p_compound_statement(p):
    """ compound_statement : '{' block_item_list_orempty '}' """
    p[0] = myAST.MultiBlock(
        block_items=p[2])

def p_conditional_expression(p):
    """ conditional_expression  : binary_expression
    """
    if len(p) == 2:
        p[0] = p[1]

def p_constant_int(p):
    """ constant    : INTEGER_CONSTANT
    """
    p[0] = myAST.Constant(
        'int', p[1], )

def p_constant_char(p):
    """ constant    : CHAR_CONSTANT
    """
    p[0] = myAST.Constant(
        'char', p[1], )

def p_constant_float(p):
    """ constant    : FLOAT_CONSTANT
    """
    p[0] = myAST.Constant(
        'float', p[1], )

def p_constant_bool(p):
    """ constant    : BOOL_CONSTANT
    """
    p[0] = myAST.Constant(
        'bool', p[1], )

def p_constant_expression(p):
    """ constant_expression : conditional_expression """
    p[0] = p[1]

def p_declarator_direct(p):
    """ declarator  : direct_declarator
    """
    p[0] = p[1]

def p_declarator_pd(p):
    """ declarator  : pointer direct_declarator
    """
    p[0] = handle_decl_change(p[2], p[1])

def p_specifier_qualifier_list_ts(p):
    """ specifier_qualifier_list    : type_specifier specifier_qualifier_list_orempty
    """
    if p[2]:
        p[2]['spec'].insert(0, p[1])
        p[0] = p[2]
    else:
        p[0] = dict(qual=[], spec=[p[1]])


# 直接声明
def p_direct_declarator_1(p):
    """ direct_declarator   : identifier
    """
    p[0] = p[1]

def p_direct_declarator_3(p):
    """ direct_declarator   : direct_declarator '[' assignment_expression_orempty ']'
    """
    kws={'dim':p[3]}
    arr = myAST.DeclArray(**kws)

    p[0] = handle_decl_change(p[1], arr)

def p_direct_declarator_6(p):
    """ direct_declarator   : direct_declarator '(' parameter_list ')'
                            | direct_declarator '(' identifier_list_orempty ')'
    """
    kws={'args':p[3]}
    func = myAST.DeclFunction(**kws)

    p[0] = handle_decl_change(p[1], func)

def p_external_declaration_1(p):
    """ external_declaration    : function_definition
    """
    p[0] = [p[1]]

def p_external_declaration_2(p):
    """ external_declaration    : declaration
    """
    p[0] = p[1]


# 表达式
def p_expression(p):
    """ expression  : assignment_expression
                    | expression ',' assignment_expression
    """
    if len(p) == 2:
        p[0] = p[1]
    else:
        if not isinstance(p[1], myAST.ContentList):
            p[1] = myAST.ContentList(listType='ExprList', elements=[p[1]])

        p[1].elements.append(p[3])
        p[0] = p[1]

def p_expression_statement(p):
    """ expression_statement : expression_orempty ';' """
    if p[1] is None:
        p[0] = myAST.ControlLogic(logicType='EmptyStatement')
    else:
        p[0] = p[1]

def p_function_definition_2(p):
    """ function_definition : declaration_specifiers declarator declaration_list_orempty compound_statement
    """
    decl_spec = p[1]
    struct = None
    if isinstance(decl_spec['spec'][0], myAST.Struct):
        struct = decl_spec['spec'][0]
    type = p[2]

    if struct is not None:
        if isinstance(type, myAST.Identifier):
            kws={'name':type.name,'quals':decl_spec['qual'],'spec':decl_spec['spec'],'type':struct,'init':None}
            declaration = myAST.DeclarationNode(**kws)
        else:
            while not isinstance(type.type, myAST.Identifier):
                type = type.type
            declname = type.type.name
            type.type = struct
            kws = {'name': declname, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'], 'type': p[2],
                   'init': None}
            declaration = myAST.DeclarationNode(**kws)

    else:
        while not isinstance(type, myAST.Identifier):
            type = type.type
        type.spec = decl_spec['spec']
        kws = {'name': type.name, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'], 'type': p[2],
               'init': None}
        declaration = myAST.DeclarationNode(**kws)

    fun_kws = {'decl': declaration, 'param_decls': p[3], 'body': p[4]}
    p[0] = myAST.FuncDef(**fun_kws)



def p_parameter_list(p):
    """ parameter_list  : parameter_declaration
                        | parameter_list ',' parameter_declaration
    """
    if len(p) == 2:
        p[0] = myAST.ContentList(listType='ParamList', elements=[p[1]])
    else:
        p[1].elements.append(p[3])
        p[0] = p[1]

def p_parameter_declaration_1(p):
    """ parameter_declaration   : declaration_specifiers declarator
    """
    decl_spec = p[1]
    struct = None
    if isinstance(decl_spec['spec'][0], myAST.Struct):
        struct = decl_spec['spec'][0]
    type = p[2]

    if struct is not None:
        if isinstance(type, myAST.Identifier):
            kws = {'name': type.name, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'],
                   'type': struct,
                   'init': None}
            declaration = myAST.DeclarationNode(**kws)
        else:
            while not isinstance(type.type, myAST.Identifier):
                type = type.type
            declname = type.type.name
            type.type = struct
            kws = {'name': declname, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'],
                   'type': p[2],
                   'init': None}
            declaration = myAST.DeclarationNode(**kws)
    else:
        while not isinstance(type, myAST.Identifier):
            type = type.type
        type.spec = decl_spec['spec']
        kws = {'name': type.name, 'quals': decl_spec['qual'], 'spec': decl_spec['spec'],
               'type': p[2],
               'init': None}
        declaration = myAST.DeclarationNode(**kws)

    p[0] = declaration

def p_postfix_expression_1(p):
    """ postfix_expression  : primary_expression """
    p[0] = p[1]

def p_postfix_expression_2(p):
    """ postfix_expression  : postfix_expression '[' expression ']' """
    #p[0] = myAST.ArrayRef(p[1], p[3])
    kws = {'subscript': p[3]}
    p[0] = myAST.Ref(refType='ArrayRef', name=p[1], **kws)

def p_postfix_expression_3(p):
    """ postfix_expression  : postfix_expression '(' argument_expression_list ')'
                            | postfix_expression '(' ')'
    """
    if len(p) == 5:
        kws = {'name': p[1], 'args': p[3]}
    else:
        kws = {'name': p[1], 'args': None}
    p[0] = myAST.FuncCall(**kws)

def p_postfix_expression_4(p):
    """ postfix_expression  : postfix_expression PTR_OP identifier
    """
    kws1 = {'name': p[3], 'spec': None}
    field = myAST.Identifier(**kws1)
    kws={'type':p[2],'field':field}
    p[0] = myAST.Ref(refType='StructRef',name=p[1], **kws)

def p_primary_expression_1(p):
    """ primary_expression  : identifier """
    p[0] = p[1]

def p_primary_expression_2(p):
    """ primary_expression  : constant """
    p[0] = p[1]

def p_primary_expression_3(p):
    """ primary_expression  : unified_string_literal
    """
    p[0] = p[1]

def p_primary_expression_4(p):
    """ primary_expression  : '(' expression ')' """
    p[0] = p[2]

def p_selection_statement_1(p):
    """ selection_statement : IF '(' expression ')' statement """
    kws={'judge':p[3], 'action1':p[5], 'action2': None}
    p[0] = myAST.ControlLogic('If',**kws)

def p_selection_statement_2(p):
    """ selection_statement : IF '(' expression ')' statement ELSE statement """
    kws = {'judge': p[3], 'action1': p[5], 'action2': p[7]}
    p[0] = myAST.ControlLogic('If', **kws)


def p_iteration_statement_1(p):
    """ iteration_statement : WHILE '(' expression ')' statement """
    kws={'judge':p[3],'action':p[5]}
    p[0] = myAST.ControlLogic(logicType='While',**kws)

def p_statement(p):
    """ statement   : compound_statement
                    | selection_statement
                    | expression_statement
                    | iteration_statement
                    | jump_statement
    """
    p[0] = p[1]

def p_struct_specifier_1(p):
    """ struct_specifier   : STRUCT identifier
    """
    p[0] = myAST.Struct(
        name=p[2].name,
        decls=None)

def p_struct_specifier_2(p):
    """ struct_specifier : STRUCT '{' struct_declaration_list '}'
    """
    p[0] = myAST.Struct(
        name=None,
        decls=p[3])

def p_initializer_list_orempty(p):
    """initializer_list_orempty : empty
                            | initializer_list
    """
    p[0] = p[1]
def p_struct_specifier_3(p):
    """ struct_specifier   : STRUCT identifier '{' struct_declaration_list '}'
    """
    p[0] = myAST.Struct(
        name=p[2].name,
        decls=p[4])

# Combine all declarations into a single list
#
def p_struct_declaration_list(p):
    """ struct_declaration_list     : struct_declaration
                                    | struct_declaration_list struct_declaration
    """
    if len(p) == 2:
        p[0] = p[1] or []
    else:
        p[0] = p[1] + (p[2] or [])

def p_struct_declaration(p):
    """ struct_declaration : specifier_qualifier_list struct_declarator_list ';'
    """
    p[0] = []
    struct_decl_list = p[2]
    spec_qual = p[1]
    struct = None
    if isinstance(spec_qual['spec'][0], myAST.Struct):
        struct = spec_qual['spec'][0]

    for decl in struct_decl_list:
        type = decl
        while not isinstance(type, myAST.Identifier):
            type = type.type
        if struct is not None:
            type.type = struct
            declname = type.type.name
        else:
            type.spec = spec_qual['spec']
            declname = type.name
        kws = {'name': declname, 'quals': spec_qual['qual'], 'spec': spec_qual['spec'],
               'type': decl,
               'init': None}
        declaration = myAST.DeclarationNode(**kws)
        p[0].insert(0, declaration)


def p_struct_declarator_list(p):
    """ struct_declarator_list  : declarator
                                | struct_declarator_list ',' declarator
    """
    p[0] = p[1] + [p[3]] if len(p) == 4 else [p[1]]


def p_pointer(p):
    """ pointer : '*'
                | '*' pointer
    """
    kws={'quals':p[1]}
    type_ = myAST.DeclPointer(**kws or [])
    if len(p) > 2:
        tail = p[2]
        while tail.type is not None:
            tail = tail.type
        tail.type = type_
        p[0] = p[2]
    else:
        p[0] = type_

# 一元运算
def p_unary_operator(p):
    ''' unary_operator : '&'
                       | '*'
                       | '+'
                       | '-'
                       | '~'
                       | '!' '''
    p[0] = p[1]

def p_unary_expression_1(p):
    """ unary_expression    : postfix_expression """
    p[0] = p[1]

def p_unary_expression_2(p):
    """ unary_expression    : unary_operator cast_expression
    """
    kws={'expression':p[2]}
    p[0] = myAST.Operation(OpType='UnaryOp',OpName=p[1],**kws)

def p_unified_string_literal(p):
    """ unified_string_literal  : STRING_CONSTANT
                                | unified_string_literal STRING_CONSTANT
    """
    if len(p) == 2:
        p[0] = myAST.Constant(
            'string', p[1])
    else:
        p[1].content = p[1].content[:-1] + p[2][1:]
        p[0] = p[1]

def p_binary_expression(p):
    """ binary_expression   : cast_expression
                            | binary_expression '*' binary_expression
                            | binary_expression '/' binary_expression
                            | binary_expression '%' binary_expression
                            | binary_expression '+' binary_expression
                            | binary_expression '-' binary_expression
                            | binary_expression RIGHT_OP binary_expression
                            | binary_expression LEFT_OP binary_expression
                            | binary_expression '<' binary_expression
                            | binary_expression LTE binary_expression
                            | binary_expression GTE binary_expression
                            | binary_expression '>' binary_expression
                            | binary_expression EQ_OP binary_expression
                            | binary_expression NEQ_OP binary_expression
                            | binary_expression '&' binary_expression
                            | binary_expression '|' binary_expression
                            | binary_expression '^' binary_expression
                            | binary_expression AND_OP binary_expression
                            | binary_expression OR_OP binary_expression
    """
    if len(p) == 2:
        p[0] = p[1]
    else:
        kws={'left':p[1],'right':p[3]}
        p[0] = myAST.Operation(OpType='BinaryOp',OpName=p[2],**kws)

def p_cast_expression_1(p):
    """ cast_expression : unary_expression """
    p[0] = p[1]




# C++相比C多出的特性，因为没有用到，暂时没有处理
def p_cpp_advanced(p):
    """ cpp_advanced : ASM
    | BUILT_IN_FUNCTION
    | CATCH
    | CLASS
    | COMMENT1
    | COMMENT2
    | CONST_CAST
    | DELETE
    | DYNAMIC_CAST
    | EXPLICIT
    | EXPORT
    | FRIEND
    | MUTABLE
    | NAMESPACE
    | NEW
    | OPERATOR
    | PRIVATE
    | PROTECTED
    | PUBLIC
    | REINTERPRET_CAST
    | STATIC_CAST
    | TEMPLATE
    | THIS
    | THROW
    | TRY
    | TYPEID
    | TYPENAME
    | USING
    | VIRTUAL
    | AUTO
    | CONST
    | DO
    | ENUM
    | EXTERN
    | FOR
    | STATIC
    | SIZEOF
    | UNION
    | VOLATILE
    | RESTRICT
    | REGISTER
    | INLINE
    | GOTO
    | TYPEDEF
    | SWITCH
    | CASE
    | INC_OP
    | DEC_OP
    | DEFAULT
    """
    #p[0]=MidNode('cpp_advanced',p[1:])
    pass



def p_error(p):
    #print('Syntax error of %s type in line %d, lexpos - %d: %s' % (p.type, p.lineno, p.lexpos, p.value))
    if p:
        print('Syntax error of token %s in line %d' % (p.type, p.lineno))
        # Just discard the token and tell the parser it's okay.
        parser.errok()
    else:
        print("Syntax error at EOF")


parser = yacc.yacc()

if __name__ == '__main__':
    import sys
    import io
    from preprocess import preprocess
    import json

    if len(sys.argv) > 1:  # specify file

        file_data, ok = preprocess(sys.argv[1])
        if not ok:
            print('preprocess error')
        else:
            result = parser.parse(file_data)


            ast_dict = result.build_tree()
            tree = json.dumps(ast_dict, indent=4)
            save_path = sys.argv[1][:-len('.cpp')]+'_ast.json'
            if len(sys.argv) > 2:
                save_path = sys.argv[2]
            with open(save_path, 'w+',encoding='utf-8') as f:
                #f.write(buf)
                f.write(str(tree))
            # print(tree)
            print("results is saved at {}.".format(save_path))

    else:
        print("please input c++ file path")

