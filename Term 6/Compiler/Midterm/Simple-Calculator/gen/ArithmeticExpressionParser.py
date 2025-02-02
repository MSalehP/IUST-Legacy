# Generated from D:/University documents/Term 6/Compiler/Midterm/Simple-Calculator/grammar/ArithmeticExpression.g4 by ANTLR 4.13.1
# encoding: utf-8
from antlr4 import *
from io import StringIO
import sys
if sys.version_info[1] > 5:
	from typing import TextIO
else:
	from typing.io import TextIO

def serializedATN():
    return [
        4,1,18,120,2,0,7,0,2,1,7,1,2,2,7,2,2,3,7,3,2,4,7,4,2,5,7,5,2,6,7,
        6,2,7,7,7,2,8,7,8,2,9,7,9,2,10,7,10,2,11,7,11,2,12,7,12,2,13,7,13,
        1,0,3,0,30,8,0,1,0,1,0,1,0,1,1,4,1,36,8,1,11,1,12,1,37,1,2,1,2,1,
        2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,3,2,52,8,2,1,2,1,2,1,2,1,3,
        1,3,1,4,1,4,1,5,1,5,1,6,1,6,1,7,1,7,1,7,1,7,1,7,3,7,70,8,7,1,8,1,
        8,1,8,1,8,1,9,1,9,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,1,10,5,
        10,87,8,10,10,10,12,10,90,9,10,1,11,1,11,1,11,1,11,1,11,1,11,1,11,
        1,11,1,11,5,11,101,8,11,10,11,12,11,104,9,11,1,12,3,12,107,8,12,
        1,12,1,12,1,12,1,12,1,12,1,12,1,12,3,12,116,8,12,1,13,1,13,1,13,
        0,2,20,22,14,0,2,4,6,8,10,12,14,16,18,20,22,24,26,0,2,1,0,4,6,1,
        0,8,9,117,0,29,1,0,0,0,2,35,1,0,0,0,4,39,1,0,0,0,6,56,1,0,0,0,8,
        58,1,0,0,0,10,60,1,0,0,0,12,62,1,0,0,0,14,69,1,0,0,0,16,71,1,0,0,
        0,18,75,1,0,0,0,20,77,1,0,0,0,22,91,1,0,0,0,24,115,1,0,0,0,26,117,
        1,0,0,0,28,30,3,2,1,0,29,28,1,0,0,0,29,30,1,0,0,0,30,31,1,0,0,0,
        31,32,3,14,7,0,32,33,5,0,0,1,33,1,1,0,0,0,34,36,3,4,2,0,35,34,1,
        0,0,0,36,37,1,0,0,0,37,35,1,0,0,0,37,38,1,0,0,0,38,3,1,0,0,0,39,
        40,3,12,6,0,40,41,3,8,4,0,41,42,5,12,0,0,42,43,3,6,3,0,43,44,5,13,
        0,0,44,45,5,17,0,0,45,46,5,1,0,0,46,47,5,17,0,0,47,51,3,10,5,0,48,
        49,5,17,0,0,49,50,5,2,0,0,50,52,3,20,10,0,51,48,1,0,0,0,51,52,1,
        0,0,0,52,53,1,0,0,0,53,54,5,17,0,0,54,55,5,3,0,0,55,5,1,0,0,0,56,
        57,5,15,0,0,57,7,1,0,0,0,58,59,5,15,0,0,59,9,1,0,0,0,60,61,3,14,
        7,0,61,11,1,0,0,0,62,63,7,0,0,0,63,13,1,0,0,0,64,65,3,16,8,0,65,
        66,5,17,0,0,66,67,3,14,7,0,67,70,1,0,0,0,68,70,3,16,8,0,69,64,1,
        0,0,0,69,68,1,0,0,0,70,15,1,0,0,0,71,72,3,18,9,0,72,73,5,7,0,0,73,
        74,3,20,10,0,74,17,1,0,0,0,75,76,5,18,0,0,76,19,1,0,0,0,77,78,6,
        10,-1,0,78,79,3,22,11,0,79,88,1,0,0,0,80,81,10,3,0,0,81,82,5,8,0,
        0,82,87,3,20,10,4,83,84,10,2,0,0,84,85,5,9,0,0,85,87,3,20,10,3,86,
        80,1,0,0,0,86,83,1,0,0,0,87,90,1,0,0,0,88,86,1,0,0,0,88,89,1,0,0,
        0,89,21,1,0,0,0,90,88,1,0,0,0,91,92,6,11,-1,0,92,93,3,24,12,0,93,
        102,1,0,0,0,94,95,10,3,0,0,95,96,5,10,0,0,96,101,3,22,11,4,97,98,
        10,2,0,0,98,99,5,11,0,0,99,101,3,22,11,3,100,94,1,0,0,0,100,97,1,
        0,0,0,101,104,1,0,0,0,102,100,1,0,0,0,102,103,1,0,0,0,103,23,1,0,
        0,0,104,102,1,0,0,0,105,107,3,26,13,0,106,105,1,0,0,0,106,107,1,
        0,0,0,107,108,1,0,0,0,108,116,5,14,0,0,109,110,5,12,0,0,110,111,
        3,20,10,0,111,112,5,13,0,0,112,116,1,0,0,0,113,116,5,18,0,0,114,
        116,5,15,0,0,115,106,1,0,0,0,115,109,1,0,0,0,115,113,1,0,0,0,115,
        114,1,0,0,0,116,25,1,0,0,0,117,118,7,1,0,0,118,27,1,0,0,0,10,29,
        37,51,69,86,88,100,102,106,115
    ]

class ArithmeticExpressionParser ( Parser ):

    grammarFileName = "ArithmeticExpression.g4"

    atn = ATNDeserializer().deserialize(serializedATN())

    decisionsToDFA = [ DFA(ds, i) for i, ds in enumerate(atn.decisionToState) ]

    sharedContextCache = PredictionContextCache()

    literalNames = [ "<INVALID>", "'begin'", "'return'", "'end'", "'int'", 
                     "'float'", "'string'", "'='", "'+'", "'-'", "'*'", 
                     "'/'", "'('", "')'", "<INVALID>", "<INVALID>", "<INVALID>", 
                     "'\\n'" ]

    symbolicNames = [ "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "<INVALID>", "<INVALID>", "<INVALID>", "<INVALID>", 
                      "ADD", "SUB", "MUL", "DIV", "LPAREN", "RPAREN", "NUMERICALVALUE", 
                      "STRING", "WS", "NEWLINE", "ID" ]

    RULE_start = 0
    RULE_function_definitions = 1
    RULE_function_definition = 2
    RULE_parameters = 3
    RULE_func_name = 4
    RULE_func_body = 5
    RULE_func_type = 6
    RULE_assigns = 7
    RULE_assign = 8
    RULE_id = 9
    RULE_expr = 10
    RULE_term = 11
    RULE_factor = 12
    RULE_sign = 13

    ruleNames =  [ "start", "function_definitions", "function_definition", 
                   "parameters", "func_name", "func_body", "func_type", 
                   "assigns", "assign", "id", "expr", "term", "factor", 
                   "sign" ]

    EOF = Token.EOF
    T__0=1
    T__1=2
    T__2=3
    T__3=4
    T__4=5
    T__5=6
    T__6=7
    ADD=8
    SUB=9
    MUL=10
    DIV=11
    LPAREN=12
    RPAREN=13
    NUMERICALVALUE=14
    STRING=15
    WS=16
    NEWLINE=17
    ID=18

    def __init__(self, input:TokenStream, output:TextIO = sys.stdout):
        super().__init__(input, output)
        self.checkVersion("4.13.1")
        self._interp = ParserATNSimulator(self, self.atn, self.decisionsToDFA, self.sharedContextCache)
        self._predicates = None




    class StartContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def assigns(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.AssignsContext,0)


        def EOF(self):
            return self.getToken(ArithmeticExpressionParser.EOF, 0)

        def function_definitions(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.Function_definitionsContext,0)


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_start

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterStart" ):
                listener.enterStart(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitStart" ):
                listener.exitStart(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitStart" ):
                return visitor.visitStart(self)
            else:
                return visitor.visitChildren(self)




    def start(self):

        localctx = ArithmeticExpressionParser.StartContext(self, self._ctx, self.state)
        self.enterRule(localctx, 0, self.RULE_start)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 29
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            if (((_la) & ~0x3f) == 0 and ((1 << _la) & 112) != 0):
                self.state = 28
                self.function_definitions()


            self.state = 31
            self.assigns()
            self.state = 32
            self.match(ArithmeticExpressionParser.EOF)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Function_definitionsContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def function_definition(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(ArithmeticExpressionParser.Function_definitionContext)
            else:
                return self.getTypedRuleContext(ArithmeticExpressionParser.Function_definitionContext,i)


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_function_definitions

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunction_definitions" ):
                listener.enterFunction_definitions(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunction_definitions" ):
                listener.exitFunction_definitions(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunction_definitions" ):
                return visitor.visitFunction_definitions(self)
            else:
                return visitor.visitChildren(self)




    def function_definitions(self):

        localctx = ArithmeticExpressionParser.Function_definitionsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 2, self.RULE_function_definitions)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 35 
            self._errHandler.sync(self)
            _la = self._input.LA(1)
            while True:
                self.state = 34
                self.function_definition()
                self.state = 37 
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if not ((((_la) & ~0x3f) == 0 and ((1 << _la) & 112) != 0)):
                    break

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Function_definitionContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def func_type(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.Func_typeContext,0)


        def func_name(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.Func_nameContext,0)


        def LPAREN(self):
            return self.getToken(ArithmeticExpressionParser.LPAREN, 0)

        def parameters(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.ParametersContext,0)


        def RPAREN(self):
            return self.getToken(ArithmeticExpressionParser.RPAREN, 0)

        def NEWLINE(self, i:int=None):
            if i is None:
                return self.getTokens(ArithmeticExpressionParser.NEWLINE)
            else:
                return self.getToken(ArithmeticExpressionParser.NEWLINE, i)

        def func_body(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.Func_bodyContext,0)


        def expr(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.ExprContext,0)


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_function_definition

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunction_definition" ):
                listener.enterFunction_definition(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunction_definition" ):
                listener.exitFunction_definition(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunction_definition" ):
                return visitor.visitFunction_definition(self)
            else:
                return visitor.visitChildren(self)




    def function_definition(self):

        localctx = ArithmeticExpressionParser.Function_definitionContext(self, self._ctx, self.state)
        self.enterRule(localctx, 4, self.RULE_function_definition)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 39
            self.func_type()
            self.state = 40
            self.func_name()
            self.state = 41
            self.match(ArithmeticExpressionParser.LPAREN)
            self.state = 42
            self.parameters()
            self.state = 43
            self.match(ArithmeticExpressionParser.RPAREN)
            self.state = 44
            self.match(ArithmeticExpressionParser.NEWLINE)
            self.state = 45
            self.match(ArithmeticExpressionParser.T__0)
            self.state = 46
            self.match(ArithmeticExpressionParser.NEWLINE)
            self.state = 47
            self.func_body()
            self.state = 51
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,2,self._ctx)
            if la_ == 1:
                self.state = 48
                self.match(ArithmeticExpressionParser.NEWLINE)
                self.state = 49
                self.match(ArithmeticExpressionParser.T__1)
                self.state = 50
                self.expr(0)


            self.state = 53
            self.match(ArithmeticExpressionParser.NEWLINE)
            self.state = 54
            self.match(ArithmeticExpressionParser.T__2)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ParametersContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def STRING(self):
            return self.getToken(ArithmeticExpressionParser.STRING, 0)

        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_parameters

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterParameters" ):
                listener.enterParameters(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitParameters" ):
                listener.exitParameters(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitParameters" ):
                return visitor.visitParameters(self)
            else:
                return visitor.visitChildren(self)




    def parameters(self):

        localctx = ArithmeticExpressionParser.ParametersContext(self, self._ctx, self.state)
        self.enterRule(localctx, 6, self.RULE_parameters)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 56
            self.match(ArithmeticExpressionParser.STRING)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Func_nameContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def STRING(self):
            return self.getToken(ArithmeticExpressionParser.STRING, 0)

        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_func_name

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunc_name" ):
                listener.enterFunc_name(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunc_name" ):
                listener.exitFunc_name(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunc_name" ):
                return visitor.visitFunc_name(self)
            else:
                return visitor.visitChildren(self)




    def func_name(self):

        localctx = ArithmeticExpressionParser.Func_nameContext(self, self._ctx, self.state)
        self.enterRule(localctx, 8, self.RULE_func_name)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 58
            self.match(ArithmeticExpressionParser.STRING)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Func_bodyContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def assigns(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.AssignsContext,0)


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_func_body

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunc_body" ):
                listener.enterFunc_body(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunc_body" ):
                listener.exitFunc_body(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunc_body" ):
                return visitor.visitFunc_body(self)
            else:
                return visitor.visitChildren(self)




    def func_body(self):

        localctx = ArithmeticExpressionParser.Func_bodyContext(self, self._ctx, self.state)
        self.enterRule(localctx, 10, self.RULE_func_body)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 60
            self.assigns()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class Func_typeContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_func_type

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFunc_type" ):
                listener.enterFunc_type(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFunc_type" ):
                listener.exitFunc_type(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFunc_type" ):
                return visitor.visitFunc_type(self)
            else:
                return visitor.visitChildren(self)




    def func_type(self):

        localctx = ArithmeticExpressionParser.Func_typeContext(self, self._ctx, self.state)
        self.enterRule(localctx, 12, self.RULE_func_type)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 62
            _la = self._input.LA(1)
            if not((((_la) & ~0x3f) == 0 and ((1 << _la) & 112) != 0)):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class AssignsContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def assign(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.AssignContext,0)


        def NEWLINE(self):
            return self.getToken(ArithmeticExpressionParser.NEWLINE, 0)

        def assigns(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.AssignsContext,0)


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_assigns

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAssigns" ):
                listener.enterAssigns(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAssigns" ):
                listener.exitAssigns(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAssigns" ):
                return visitor.visitAssigns(self)
            else:
                return visitor.visitChildren(self)




    def assigns(self):

        localctx = ArithmeticExpressionParser.AssignsContext(self, self._ctx, self.state)
        self.enterRule(localctx, 14, self.RULE_assigns)
        try:
            self.state = 69
            self._errHandler.sync(self)
            la_ = self._interp.adaptivePredict(self._input,3,self._ctx)
            if la_ == 1:
                self.enterOuterAlt(localctx, 1)
                self.state = 64
                self.assign()
                self.state = 65
                self.match(ArithmeticExpressionParser.NEWLINE)
                self.state = 66
                self.assigns()
                pass

            elif la_ == 2:
                self.enterOuterAlt(localctx, 2)
                self.state = 68
                self.assign()
                pass


        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class AssignContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def id_(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.IdContext,0)


        def expr(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.ExprContext,0)


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_assign

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterAssign" ):
                listener.enterAssign(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitAssign" ):
                listener.exitAssign(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitAssign" ):
                return visitor.visitAssign(self)
            else:
                return visitor.visitChildren(self)




    def assign(self):

        localctx = ArithmeticExpressionParser.AssignContext(self, self._ctx, self.state)
        self.enterRule(localctx, 16, self.RULE_assign)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 71
            self.id_()
            self.state = 72
            self.match(ArithmeticExpressionParser.T__6)
            self.state = 73
            self.expr(0)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class IdContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def ID(self):
            return self.getToken(ArithmeticExpressionParser.ID, 0)

        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_id

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterId" ):
                listener.enterId(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitId" ):
                listener.exitId(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitId" ):
                return visitor.visitId(self)
            else:
                return visitor.visitChildren(self)




    def id_(self):

        localctx = ArithmeticExpressionParser.IdContext(self, self._ctx, self.state)
        self.enterRule(localctx, 18, self.RULE_id)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 75
            self.match(ArithmeticExpressionParser.ID)
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class ExprContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser
            self.rule_type = str()

        def term(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.TermContext,0)


        def expr(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(ArithmeticExpressionParser.ExprContext)
            else:
                return self.getTypedRuleContext(ArithmeticExpressionParser.ExprContext,i)


        def ADD(self):
            return self.getToken(ArithmeticExpressionParser.ADD, 0)

        def SUB(self):
            return self.getToken(ArithmeticExpressionParser.SUB, 0)

        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_expr

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterExpr" ):
                listener.enterExpr(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitExpr" ):
                listener.exitExpr(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitExpr" ):
                return visitor.visitExpr(self)
            else:
                return visitor.visitChildren(self)



    def expr(self, _p:int=0):
        _parentctx = self._ctx
        _parentState = self.state
        localctx = ArithmeticExpressionParser.ExprContext(self, self._ctx, _parentState)
        _prevctx = localctx
        _startState = 20
        self.enterRecursionRule(localctx, 20, self.RULE_expr, _p)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 78
            self.term(0)
            self._ctx.stop = self._input.LT(-1)
            self.state = 88
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,5,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 86
                    self._errHandler.sync(self)
                    la_ = self._interp.adaptivePredict(self._input,4,self._ctx)
                    if la_ == 1:
                        localctx = ArithmeticExpressionParser.ExprContext(self, _parentctx, _parentState)
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 80
                        if not self.precpred(self._ctx, 3):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 3)")
                        self.state = 81
                        self.match(ArithmeticExpressionParser.ADD)
                        self.state = 82
                        self.expr(4)
                        pass

                    elif la_ == 2:
                        localctx = ArithmeticExpressionParser.ExprContext(self, _parentctx, _parentState)
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_expr)
                        self.state = 83
                        if not self.precpred(self._ctx, 2):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 2)")
                        self.state = 84
                        self.match(ArithmeticExpressionParser.SUB)
                        self.state = 85
                        self.expr(3)
                        pass

             
                self.state = 90
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,5,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.unrollRecursionContexts(_parentctx)
        return localctx


    class TermContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser
            self.rule_type = str()

        def factor(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.FactorContext,0)


        def term(self, i:int=None):
            if i is None:
                return self.getTypedRuleContexts(ArithmeticExpressionParser.TermContext)
            else:
                return self.getTypedRuleContext(ArithmeticExpressionParser.TermContext,i)


        def MUL(self):
            return self.getToken(ArithmeticExpressionParser.MUL, 0)

        def DIV(self):
            return self.getToken(ArithmeticExpressionParser.DIV, 0)

        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_term

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterTerm" ):
                listener.enterTerm(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitTerm" ):
                listener.exitTerm(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitTerm" ):
                return visitor.visitTerm(self)
            else:
                return visitor.visitChildren(self)



    def term(self, _p:int=0):
        _parentctx = self._ctx
        _parentState = self.state
        localctx = ArithmeticExpressionParser.TermContext(self, self._ctx, _parentState)
        _prevctx = localctx
        _startState = 22
        self.enterRecursionRule(localctx, 22, self.RULE_term, _p)
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 92
            self.factor()
            self._ctx.stop = self._input.LT(-1)
            self.state = 102
            self._errHandler.sync(self)
            _alt = self._interp.adaptivePredict(self._input,7,self._ctx)
            while _alt!=2 and _alt!=ATN.INVALID_ALT_NUMBER:
                if _alt==1:
                    if self._parseListeners is not None:
                        self.triggerExitRuleEvent()
                    _prevctx = localctx
                    self.state = 100
                    self._errHandler.sync(self)
                    la_ = self._interp.adaptivePredict(self._input,6,self._ctx)
                    if la_ == 1:
                        localctx = ArithmeticExpressionParser.TermContext(self, _parentctx, _parentState)
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_term)
                        self.state = 94
                        if not self.precpred(self._ctx, 3):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 3)")
                        self.state = 95
                        self.match(ArithmeticExpressionParser.MUL)
                        self.state = 96
                        self.term(4)
                        pass

                    elif la_ == 2:
                        localctx = ArithmeticExpressionParser.TermContext(self, _parentctx, _parentState)
                        self.pushNewRecursionContext(localctx, _startState, self.RULE_term)
                        self.state = 97
                        if not self.precpred(self._ctx, 2):
                            from antlr4.error.Errors import FailedPredicateException
                            raise FailedPredicateException(self, "self.precpred(self._ctx, 2)")
                        self.state = 98
                        self.match(ArithmeticExpressionParser.DIV)
                        self.state = 99
                        self.term(3)
                        pass

             
                self.state = 104
                self._errHandler.sync(self)
                _alt = self._interp.adaptivePredict(self._input,7,self._ctx)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.unrollRecursionContexts(_parentctx)
        return localctx


    class FactorContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser
            self.rule_type = str()


        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_factor

     
        def copyFrom(self, ctx:ParserRuleContext):
            super().copyFrom(ctx)
            self.rule_type = ctx.rule_type



    class Factor_is_stringContext(FactorContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a ArithmeticExpressionParser.FactorContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def STRING(self):
            return self.getToken(ArithmeticExpressionParser.STRING, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFactor_is_string" ):
                listener.enterFactor_is_string(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFactor_is_string" ):
                listener.exitFactor_is_string(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFactor_is_string" ):
                return visitor.visitFactor_is_string(self)
            else:
                return visitor.visitChildren(self)


    class Factor_is_expressionContext(FactorContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a ArithmeticExpressionParser.FactorContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def LPAREN(self):
            return self.getToken(ArithmeticExpressionParser.LPAREN, 0)
        def expr(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.ExprContext,0)

        def RPAREN(self):
            return self.getToken(ArithmeticExpressionParser.RPAREN, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFactor_is_expression" ):
                listener.enterFactor_is_expression(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFactor_is_expression" ):
                listener.exitFactor_is_expression(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFactor_is_expression" ):
                return visitor.visitFactor_is_expression(self)
            else:
                return visitor.visitChildren(self)


    class Factor_is_idContext(FactorContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a ArithmeticExpressionParser.FactorContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def ID(self):
            return self.getToken(ArithmeticExpressionParser.ID, 0)

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFactor_is_id" ):
                listener.enterFactor_is_id(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFactor_is_id" ):
                listener.exitFactor_is_id(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFactor_is_id" ):
                return visitor.visitFactor_is_id(self)
            else:
                return visitor.visitChildren(self)


    class Factor_is_numericContext(FactorContext):

        def __init__(self, parser, ctx:ParserRuleContext): # actually a ArithmeticExpressionParser.FactorContext
            super().__init__(parser)
            self.copyFrom(ctx)

        def NUMERICALVALUE(self):
            return self.getToken(ArithmeticExpressionParser.NUMERICALVALUE, 0)
        def sign(self):
            return self.getTypedRuleContext(ArithmeticExpressionParser.SignContext,0)


        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterFactor_is_numeric" ):
                listener.enterFactor_is_numeric(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitFactor_is_numeric" ):
                listener.exitFactor_is_numeric(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitFactor_is_numeric" ):
                return visitor.visitFactor_is_numeric(self)
            else:
                return visitor.visitChildren(self)



    def factor(self):

        localctx = ArithmeticExpressionParser.FactorContext(self, self._ctx, self.state)
        self.enterRule(localctx, 24, self.RULE_factor)
        self._la = 0 # Token type
        try:
            self.state = 115
            self._errHandler.sync(self)
            token = self._input.LA(1)
            if token in [8, 9, 14]:
                localctx = ArithmeticExpressionParser.Factor_is_numericContext(self, localctx)
                self.enterOuterAlt(localctx, 1)
                self.state = 106
                self._errHandler.sync(self)
                _la = self._input.LA(1)
                if _la==8 or _la==9:
                    self.state = 105
                    self.sign()


                self.state = 108
                self.match(ArithmeticExpressionParser.NUMERICALVALUE)
                pass
            elif token in [12]:
                localctx = ArithmeticExpressionParser.Factor_is_expressionContext(self, localctx)
                self.enterOuterAlt(localctx, 2)
                self.state = 109
                self.match(ArithmeticExpressionParser.LPAREN)
                self.state = 110
                self.expr(0)
                self.state = 111
                self.match(ArithmeticExpressionParser.RPAREN)
                pass
            elif token in [18]:
                localctx = ArithmeticExpressionParser.Factor_is_idContext(self, localctx)
                self.enterOuterAlt(localctx, 3)
                self.state = 113
                self.match(ArithmeticExpressionParser.ID)
                pass
            elif token in [15]:
                localctx = ArithmeticExpressionParser.Factor_is_stringContext(self, localctx)
                self.enterOuterAlt(localctx, 4)
                self.state = 114
                self.match(ArithmeticExpressionParser.STRING)
                pass
            else:
                raise NoViableAltException(self)

        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx


    class SignContext(ParserRuleContext):
        __slots__ = 'parser'

        def __init__(self, parser, parent:ParserRuleContext=None, invokingState:int=-1):
            super().__init__(parent, invokingState)
            self.parser = parser

        def ADD(self):
            return self.getToken(ArithmeticExpressionParser.ADD, 0)

        def SUB(self):
            return self.getToken(ArithmeticExpressionParser.SUB, 0)

        def getRuleIndex(self):
            return ArithmeticExpressionParser.RULE_sign

        def enterRule(self, listener:ParseTreeListener):
            if hasattr( listener, "enterSign" ):
                listener.enterSign(self)

        def exitRule(self, listener:ParseTreeListener):
            if hasattr( listener, "exitSign" ):
                listener.exitSign(self)

        def accept(self, visitor:ParseTreeVisitor):
            if hasattr( visitor, "visitSign" ):
                return visitor.visitSign(self)
            else:
                return visitor.visitChildren(self)




    def sign(self):

        localctx = ArithmeticExpressionParser.SignContext(self, self._ctx, self.state)
        self.enterRule(localctx, 26, self.RULE_sign)
        self._la = 0 # Token type
        try:
            self.enterOuterAlt(localctx, 1)
            self.state = 117
            _la = self._input.LA(1)
            if not(_la==8 or _la==9):
                self._errHandler.recoverInline(self)
            else:
                self._errHandler.reportMatch(self)
                self.consume()
        except RecognitionException as re:
            localctx.exception = re
            self._errHandler.reportError(self, re)
            self._errHandler.recover(self, re)
        finally:
            self.exitRule()
        return localctx



    def sempred(self, localctx:RuleContext, ruleIndex:int, predIndex:int):
        if self._predicates == None:
            self._predicates = dict()
        self._predicates[10] = self.expr_sempred
        self._predicates[11] = self.term_sempred
        pred = self._predicates.get(ruleIndex, None)
        if pred is None:
            raise Exception("No predicate with index:" + str(ruleIndex))
        else:
            return pred(localctx, predIndex)

    def expr_sempred(self, localctx:ExprContext, predIndex:int):
            if predIndex == 0:
                return self.precpred(self._ctx, 3)
         

            if predIndex == 1:
                return self.precpred(self._ctx, 2)
         

    def term_sempred(self, localctx:TermContext, predIndex:int):
            if predIndex == 2:
                return self.precpred(self._ctx, 3)
         

            if predIndex == 3:
                return self.precpred(self._ctx, 2)
         




