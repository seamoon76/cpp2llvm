import sys
class Node(object):

    def sons(self):
        pass

    def build_tree(self):

        r={}
        r['name'] = self.__class__.__name__

        r['children'] = []
        for (child_name, child) in self.sons():
             r['children'].append(child.build_tree())

        return r


class TopAST(Node):
    def __init__(self, unitList):
        self.unitList = unitList

    def sons(self):
        child_list = []
        for id, u in enumerate(self.unitList or []):
            child_list.append(("unit[%d]" % id, u))
        return tuple(child_list)


class Constant(Node):
    def __init__(self, kind, content):
        self.kind = kind
        self.content = content

    def sons(self):
        return tuple([])


class Identifier(Node):
    def __init__(self, **kwargs):
        self.name = kwargs['name']
        self.spec = kwargs['spec']

    def sons(self):
        return tuple([])

class Struct(Node):
    def __init__(self, name, decls):
        self.name = name
        self.decls = decls

    def sons(self):
        child_list = []
        for i, child in enumerate(self.decls or []):
            child_list.append(("declarations[%d]" % i, child))
        return tuple(child_list)

class MultiBlock(Node):
    def __init__(self, block_items):
        self.block_items = block_items

    def sons(self):
        child_list = []
        for i, child in enumerate(self.block_items or []):
            child_list.append(("block_items[%d]" % i, child))
        return tuple(child_list)


class FuncDef(Node):
    def __init__(self, **kwargs):
        self.decl = kwargs['decl']
        self.param_decls = kwargs['param_decls']
        self.body = kwargs['body']

    def sons(self):
        child_list = []
        if self.decl is not None: child_list.append(("decl", self.decl))
        if self.body is not None: child_list.append(("body", self.body))
        for i, child in enumerate(self.param_decls or []):
            child_list.append(("params[%d]" % i, child))
        return tuple(child_list)

class FuncCall(Node):
    def __init__(self, **kwargs):
        self.name = kwargs['name']
        self.args = kwargs['args']

    def sons(self):
        child_list = []
        if self.name is not None: child_list.append(("name", self.name))
        if self.args is not None: child_list.append(("args", self.args))
        return tuple(child_list)


class ControlLogic(Node):
    def __init__(self,logicType,**kwargs):
        r"""
        logicType: If,While,Continue,Break
        """
        self.logicType=logicType
        if logicType=='If':
            self.judge = kwargs['judge']
            self.action1 = kwargs['action1']
            self.action2 = kwargs['action2']
        elif logicType == 'While':
            self.judge = kwargs['judge']
            self.action = kwargs['action']
        elif logicType == 'Return':
            self.return_result = kwargs['return_result']
        elif logicType in ['Continue','Break','EmptyStatement']:
            pass

    def sons(self):
        child_list = []
        if self.logicType == 'If':
            if self.judge is not None: child_list.append(("condition", self.judge))
            if self.action1 is not None: child_list.append(("true_do", self.action1))
            if self.action2 is not None: child_list.append(("false_do", self.action2))
        elif self.logicType == 'While':
            if self.judge is not None: child_list.append(("condition", self.judge))
            if self.action is not None: child_list.append(("statement", self.action))
        elif self.logicType in ['Continue','Break','EmptyStatement']:
            return ()
        elif self.logicType == 'Return':
            if self.return_result != None: child_list.append(("return_result", self.return_result))
        return tuple(child_list)

class ContentList(Node):
    def __init__(self,listType,elements):
        self.listType=listType # InitList,ParamList,ExprList
        self.elements=elements

    def sons(self):
        child_list = []
        prefix_str='None'
        if self.listType == 'InitList':
            prefix_str='expressions'
        elif self.listType == 'ParamList':
            prefix_str='parameters'
        elif self.listType == 'ExprList':
            prefix_str='expressions'
        for i, son in enumerate(self.elements or []):
            child_list.append((prefix_str+"[%d]" % i, son))
        return tuple(child_list)

class Operation(Node):

    def __init__(self, OpType, OpName,**kwargs):
        self.OpType = OpType  # Binary,Unary
        self.OpName = OpName
        if OpType == 'BinaryOp':
            self.left = kwargs['left']
            self.right = kwargs['right']
        elif OpType == 'UnaryOp':
            self.expression = kwargs['expression']
        elif OpType == 'Assignment':
            self.left = kwargs['left']
            self.right = kwargs['right']

    def sons(self):
        child_list = []
        if self.OpType == 'BinaryOp':
            if self.left != None: child_list.append(("left", self.left))
            if self.right != None: child_list.append(("right", self.right))
        elif self.OpType == 'UnaryOp':
            if self.expression != None: child_list.append(("expression", self.expression))
        elif self.OpType == 'Assignment':
            if self.left != None: child_list.append(("left", self.left))
            if self.right != None: child_list.append(("right", self.right))

        return tuple(child_list)

class Ref(Node):
    """
    ArrayRef,StructRef
    """
    def __init__(self, refType,name, **kwargs):
        self.name=name
        self.refType=refType
        if refType=='ArrayRef':
            self.sub = kwargs['subscript']
        elif refType == 'StructRef':
            self.type = kwargs['type']
            self.field = kwargs['field']
            self.attr_names = ('type',)

    def sons(self):
        child_list = []
        if self.name is not None: child_list.append(("name", self.name))
        if self.refType == 'ArrayRef':
            if self.sub is not None: child_list.append(("subscript", self.sub))
        elif self.refType == 'StructRef':
            if self.field is not None: child_list.append(("field", self.field))
        return tuple(child_list)

class ArrayRef(Node):
    def __init__(self, name, subscript):
        self.name = name
        self.subscript = subscript

    def sons(self):
        child_list = []
        if self.name is not None: child_list.append(("name", self.name))
        if self.subscript is not None: child_list.append(("subscript", self.subscript))
        return tuple(child_list)


class DeclPointer(Node):
    def __init__(self, **kwargs):
        self.quals = kwargs['quals']
        self.type=None

    def sons(self):
        return tuple([])


class DeclFunction(Node):
    def __init__(self, **kwargs):
        self.args = kwargs['args']
        self.type = None

    def sons(self):
        child_list = []
        if self.args is not None: child_list.append(("args", self.args))
        return tuple(child_list)

class DeclArray(Node):
    def __init__(self, **kwargs):
        self.dim = kwargs['dim']
        self.type = None

    def sons(self):
        sonsList = []
        if self.dim is not None: sonsList.append(("dim", self.dim))
        return tuple(sonsList)



class DeclarationNode(Node):
    def __init__(self, **kwargs):
        self.name = kwargs['name']
        self.quals = kwargs['quals']
        self.spec = kwargs['spec']
        self.type = kwargs['type']
        self.init = kwargs['init']

    def sons(self):
        child_list = []
        if self.type is not None: child_list.append(("type", self.type))
        if self.init is not None: child_list.append(("init", self.init))
        return tuple(child_list)