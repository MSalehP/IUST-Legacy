from default_codes.ast import AST
from default_codes.make_ast_subtree import make_ast_subtree
from gen.ArithmeticExpressionListener import ArithmeticExpressionListener
from gen.ArithmeticExpressionParser import ArithmeticExpressionParser


class CalculatorListener(ArithmeticExpressionListener):
    def __init__(self, rule_names):
        self.overridden_rules = ['factor', 'sign']
        self.binary_operator_list = ['term', 'expr', 'assign']
        self.rule_names = rule_names
        self.ast = AST()

    def exitEveryRule(self, ctx):
        rule_name = self.rule_names[ctx.getRuleIndex()]
        if rule_name not in self.overridden_rules:
            if rule_name in self.binary_operator_list and ctx.getChildCount() > 1:
                make_ast_subtree(self.ast, ctx, ctx.getChild(1).getText())
            else:
                make_ast_subtree(self.ast, ctx, rule_name)

    def exitFactor_is_numeric(self, ctx: ArithmeticExpressionParser.FactorContext):
        make_ast_subtree(self.ast, ctx, ctx.getText(), True)

    def exitFunction_definition(self, ctx: ArithmeticExpressionParser.FactorContext):
        make_ast_subtree(self.ast, ctx, ctx.getText(), True)
