grammar ArithmeticExpression;

start: function_definitions? assigns  EOF;

function_definitions: function_definition+;

function_definition: func_type func_name LPAREN parameters RPAREN NEWLINE 'begin' NEWLINE func_body (NEWLINE 'return' expr)? NEWLINE 'end';

parameters:;
func_name: ;
func_body: assigns;
func_type: 'int' | 'float' | 'string';


assigns: assign NEWLINE assigns | assign;
assign: id '=' expr;

id: ID;
expr returns[rule_type= str()]:
    expr ADD expr |
    expr SUB expr |
    term
    ;
term returns[rule_type= str()]:
    term MUL term |
    term DIV term |
    factor
        ;
factor returns[rule_type = str()]:
    sign? NUMERICALVALUE #factor_is_numeric|
    LPAREN expr RPAREN #factor_is_expression|
    ID #factor_is_id |
    STRING #factor_is_string
    ;

//add returns[rule_type= str()]: 'Add('parametr parametr parametr parametr')';
//
//parametr : (factor',')?;

sign: ('+'|'-');

ADD: '+';
SUB: '-';
MUL: '*';
DIV: '/';
LPAREN: '(';
RPAREN: ')';
NUMERICALVALUE: FLOAT | INTEGER;
STRING: '"'.*?'"';
fragment FLOAT:[0-9]*'.'[0-9]+;
fragment INTEGER:[0-9]+;
WS: [ \t\r]+ -> skip;
NEWLINE : '\n';
ID : [a-z,A-Z]([a-z,A-Z] | [0-9])*;