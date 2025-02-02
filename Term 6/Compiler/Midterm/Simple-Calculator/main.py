import argparse
from antlr4 import *

from CalculatorListener import CalculatorListener
from default_codes.ast_to_networkx_graph import show_ast
from default_codes.post_order_ast_traverser import PostOrderASTTraverser
from gen.ArithmeticExpressionLexer import ArithmeticExpressionLexer
from gen.ArithmeticExpressionParser import ArithmeticExpressionParser


def main(args):
    stream = FileStream(args.file, encoding='utf8')
    lexer = ArithmeticExpressionLexer(stream)
    token_stream = CommonTokenStream(lexer)
    parser = ArithmeticExpressionParser(token_stream)
    parse_tree = parser.start()
    listener = CalculatorListener(parser.ruleNames)
    walker = ParseTreeWalker()
    walker.walk(listener, parse_tree)
    normal_ast = listener.ast
    show_ast(normal_ast.root)
    post_order_ast_traverser = PostOrderASTTraverser()
    post_order_ast_traverser.node_attributes = ['label']
    traversal_dict = post_order_ast_traverser.traverse_ast(normal_ast.root)
    traversal = [item['label'] for item in traversal_dict]
    print(traversal)


if __name__ == '__main__':
    argparser = argparse.ArgumentParser()
    argparser.add_argument(
        '-n', '--file',
        help='Input source', default=r'input.txt')
    args = argparser.parse_args()
    main(args)
