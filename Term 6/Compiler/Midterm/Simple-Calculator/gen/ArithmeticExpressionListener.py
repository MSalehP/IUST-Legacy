# Generated from D:/University documents/Term 6/Compiler/Midterm/Simple-Calculator/grammar/ArithmeticExpression.g4 by ANTLR 4.13.1
from antlr4 import *
if "." in __name__:
    from .ArithmeticExpressionParser import ArithmeticExpressionParser
else:
    from ArithmeticExpressionParser import ArithmeticExpressionParser

# This class defines a complete listener for a parse tree produced by ArithmeticExpressionParser.
class ArithmeticExpressionListener(ParseTreeListener):

    # Enter a parse tree produced by ArithmeticExpressionParser#start.
    def enterStart(self, ctx:ArithmeticExpressionParser.StartContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#start.
    def exitStart(self, ctx:ArithmeticExpressionParser.StartContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#function_definitions.
    def enterFunction_definitions(self, ctx:ArithmeticExpressionParser.Function_definitionsContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#function_definitions.
    def exitFunction_definitions(self, ctx:ArithmeticExpressionParser.Function_definitionsContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#function_definition.
    def enterFunction_definition(self, ctx:ArithmeticExpressionParser.Function_definitionContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#function_definition.
    def exitFunction_definition(self, ctx:ArithmeticExpressionParser.Function_definitionContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#parameters.
    def enterParameters(self, ctx:ArithmeticExpressionParser.ParametersContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#parameters.
    def exitParameters(self, ctx:ArithmeticExpressionParser.ParametersContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#func_name.
    def enterFunc_name(self, ctx:ArithmeticExpressionParser.Func_nameContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#func_name.
    def exitFunc_name(self, ctx:ArithmeticExpressionParser.Func_nameContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#func_body.
    def enterFunc_body(self, ctx:ArithmeticExpressionParser.Func_bodyContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#func_body.
    def exitFunc_body(self, ctx:ArithmeticExpressionParser.Func_bodyContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#func_type.
    def enterFunc_type(self, ctx:ArithmeticExpressionParser.Func_typeContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#func_type.
    def exitFunc_type(self, ctx:ArithmeticExpressionParser.Func_typeContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#assigns.
    def enterAssigns(self, ctx:ArithmeticExpressionParser.AssignsContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#assigns.
    def exitAssigns(self, ctx:ArithmeticExpressionParser.AssignsContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#assign.
    def enterAssign(self, ctx:ArithmeticExpressionParser.AssignContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#assign.
    def exitAssign(self, ctx:ArithmeticExpressionParser.AssignContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#id.
    def enterId(self, ctx:ArithmeticExpressionParser.IdContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#id.
    def exitId(self, ctx:ArithmeticExpressionParser.IdContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#expr.
    def enterExpr(self, ctx:ArithmeticExpressionParser.ExprContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#expr.
    def exitExpr(self, ctx:ArithmeticExpressionParser.ExprContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#term.
    def enterTerm(self, ctx:ArithmeticExpressionParser.TermContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#term.
    def exitTerm(self, ctx:ArithmeticExpressionParser.TermContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#factor_is_numeric.
    def enterFactor_is_numeric(self, ctx:ArithmeticExpressionParser.Factor_is_numericContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#factor_is_numeric.
    def exitFactor_is_numeric(self, ctx:ArithmeticExpressionParser.Factor_is_numericContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#factor_is_expression.
    def enterFactor_is_expression(self, ctx:ArithmeticExpressionParser.Factor_is_expressionContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#factor_is_expression.
    def exitFactor_is_expression(self, ctx:ArithmeticExpressionParser.Factor_is_expressionContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#factor_is_id.
    def enterFactor_is_id(self, ctx:ArithmeticExpressionParser.Factor_is_idContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#factor_is_id.
    def exitFactor_is_id(self, ctx:ArithmeticExpressionParser.Factor_is_idContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#factor_is_string.
    def enterFactor_is_string(self, ctx:ArithmeticExpressionParser.Factor_is_stringContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#factor_is_string.
    def exitFactor_is_string(self, ctx:ArithmeticExpressionParser.Factor_is_stringContext):
        pass


    # Enter a parse tree produced by ArithmeticExpressionParser#sign.
    def enterSign(self, ctx:ArithmeticExpressionParser.SignContext):
        pass

    # Exit a parse tree produced by ArithmeticExpressionParser#sign.
    def exitSign(self, ctx:ArithmeticExpressionParser.SignContext):
        pass



del ArithmeticExpressionParser