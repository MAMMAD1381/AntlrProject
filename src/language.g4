grammar language;
mainBlock: impurt?
           class
           ;
impurt: 'import' ':' ':'
        'from' '(' LIBRARY_NAME  ((','CLASS_NAME)+ | (',' '*')) ')'
        '.' ';' ';';
class:  ACCESSTYPE? DEFINING_CLASS_NAME CLASS_KEYWORD inheritance? implementation?
        BEGIN_KEYWORD
        classBody*
        END_KEYWORD
        (';')?
        ;

classBody: function | proc;
inheritance: INHERITED_KEYWORD FROM_KEYWORD CLASS_NAME (',' CLASS_NAME)*;
implementation: IMPLEMENTS_KEYWORD CLASS_NAME (',' CLASS_NAME)*;
function: ACCESSTYPE? STATIC_KEYWORD? FUNC_KEYWORD CLASS_NAME
          '(' variable_initializing (';' variable_initializing)* ')'
          RETURNS_KEYWORD DATATYPE
          '{'
          statement*
          (RETURN_KEYWORD '(' VALUE ')' ';')?
          '}' (';')?;
proc: ACCESSTYPE? STATIC_KEYWORD? PROC_KEYWORD CLASS_NAME
      '(' statement* ')' ';';
variable_initializing: ACCESSTYPE? CONSTANT_KEYWORD? VAR_KEYWORD
                      VARIABLE_NAME ':' DATATYPE ('=' VALUE)?(';')?; //TODO MORE THAN ONE VARIABLE
array_initializing: ACCESSTYPE? CONSTANT_KEYWORD? VAR_KEYWORD
                    '[' ('0' ':' INTEGER_VALUE)? ']' CLASS_NAME ':' DATATYPE
                    ('=' '{[' VALUE (',' VALUE)* ']}')?
                    (';')?;
refrence_initializing: ACCESSTYPE? CLASS_NAME VARIABLE_NAME '->'
                       '(' ('new' CLASS_NAME '(' (VARIABLE_NAME (',' VARIABLE_NAME)*)? ')' | NULL_KEYWORD) ')'
                       ;
for: (
         FOR_KEYWORD '(' (variable_initializing? ';' condition? ';' increment?)? ')'
       ('{[' statement? ']}')? ';'
       | FOR_KEYWORD '(' (variable_initializing? ';' condition? ';' increment?)? ')'
       '{' statement+ '}' (';')?
       | FOR_KEYWORD EVREY_KEYWORD ACCESSTYPE? VAR_KEYWORD VARIABLE_NAME IN_KEYWORD
       VARIABLE_NAME DO_KEYWORD statement* UNTIL_KEYWORD END_KEYWORD
        );
while: WHILE_KEYWORD '(' (condition*)? ')' BEGIN_KEYWORD (statement*)? END_KEYWORD;
doWhile: DO_KEYWORD (statement*)? AS_LONG_AS_KEYWORD condition* ';';
if: IF_KEYWORD '{' condition* '}' THEN_KEYWORD (statement*)? ';'
    (ELIF_KEYWORD '(' condition* ')' DO_KEYWORD (statement*)? END_KEYWORD)?
    (ELSE_DO_AS_FOLLOWS_KEYWORD (statement*)? STOP_KEYWORD )?;
conditionionalOperator: condition '?' statement* ':' statement* (';')?;
switch: SWITCH_KEYWORD STRING_VALUE MATCH_KEYWORD
        CASE_KEYWORD STRING_VALUE ':' (statement*)? (BREAK_KEYWORD)?
        (CASE_KEYWORD STRING_VALUE ':' (statement*)? (BREAK_KEYWORD)?)*
        (DEFAULT_KEYWORD STRING_VALUE ':' (statement*)? END_KEYWORD)?
        ;
exception: TRY_KEYWORD '{{' (statement*)? '}}' CATCH_KEYWORD
           '(' CLASS_NAME (',' CLASS_NAME)* ')' BEGIN_KEYWORD (statement*)? END_KEYWORD;

increment: (VARIABLE_NAME INCREMENT_OPERATORS)|(INCREMENT_OPERATORS VARIABLE_NAME);

condition: (TRUE_KEYWORD
           | FALSE_KEYWORD
           | (VARIABLE_NAME | VALUE) CONDITIONAL_OPERATORS (VARIABLE_NAME | VALUE))
           ;
statement: (variable_initializing|array_initializing|refrence_initializing|for|while
            |doWhile|if|conditionionalOperator|switch|exception|increment|assignment);
assignment: VARIABLE_NAME '<-' VALUE (';')?;
ACCESSTYPE:'(?i)directAccess'|'(?i)indirectAccess'|'(?i)restricted';
DEFINING_CLASS_NAME: '^[A-Z][A-Za-z]*';
CLASS_NAME: '^[a-zA-Z_$][a-zA-Z_$0-9]*$';
LIBRARY_NAME: '^[a-zA-Z_$][a-zA-Z_$0-9]*$';
VARIABLE_NAME: '^[a-zA-Z_$][a-zA-Z_$0-9]*$';
CLASS_KEYWORD: '(?i)class';
BEGIN_KEYWORD: '(?i)begin';
END_KEYWORD: '(?i)end';
INHERITED_KEYWORD: '(?i)Inherited';
FROM_KEYWORD: '(?i)from';
IMPLEMENTS_KEYWORD: '(?i)implements';
STATIC_KEYWORD: '(?i)static';
FUNC_KEYWORD: '(?i)func';
VAR_KEYWORD: '(?i)var';
RETURNS_KEYWORD: '(?i)returns';
DATATYPE: (INTEGER_KEYWORD|FLOAT_KEYWORD|CHAR_KEYWORD|BOOLEAN_KEYWORD|STRING_KEYWORD|NULL_KEYWORD);
RETURN_KEYWORD: '(?i)return';
VALUE: (INTEGER_VALUE|FLOAT_VALUE|CHAR_VALUE|BOOLEAN_VALUE|STRING_VALUE|NULL_VALUE);
PROC_KEYWORD: '(?i)proc';
CONSTANT_KEYWORD: '(?i)constant';
FOR_KEYWORD: '(?i)for';
EVREY_KEYWORD: '(?i)evrey';
DO_KEYWORD: '(?i)do';
UNTIL_KEYWORD: '(?i)until';
IN_KEYWORD: '(?i)in';
WHILE_KEYWORD: '(?i)while';
AS_LONG_AS_KEYWORD: '(?i)as_long_as';
IF_KEYWORD: '(?i)if';
THEN_KEYWORD: '(?i)then';
ELIF_KEYWORD: '(?i)elif';
ELSE_DO_AS_FOLLOWS_KEYWORD: '(?i)else_do_as_follows';
STOP_KEYWORD: '(?i)stop';
SWITCH_KEYWORD: '(?i)switch';
MATCH_KEYWORD: '(?i)match';
CASE_KEYWORD: '(?i)case';
BREAK_KEYWORD: '(?i)break';
DEFAULT_KEYWORD: '(?i)default';
TRY_KEYWORD: '(?i)try';
CATCH_KEYWORD: '(?i)catch';
INCREMENT_OPERATORS: ('++'|'--'|'+='|'-='|'*='|'/=');
CONDITIONAL_OPERATORS: ('>'|'<'|'=='|'!='|'>='|'<=');
OPERATORS: ('+'|'-'|'*'|'/');
COMMENTING: (SINGLE_LINE_COMMENT|MULTI_LINE_COMMENT);
fragment SINGLE_LINE_COMMENT: '^[/][/].*'; //TODO CHECK /
fragment MULTI_LINE_COMMENT: '^[!][#](?s).*[!][#]$';
fragment TRUE_KEYWORD: '(?i)true';
fragment FALSE_KEYWORD: '(?i)false';
fragment INTEGER_KEYWORD: '(?i)integer';
fragment FLOAT_KEYWORD: '(?i)float';
fragment CHAR_KEYWORD: '(?i)char';
fragment BOOLEAN_KEYWORD: '(?i)boolean';
fragment STRING_KEYWORD: '(?i)string';
fragment NULL_KEYWORD: '(?i)null';
fragment INTEGER_VALUE: '\b[0-9]+\b'; //todo add binary and hex value
fragment FLOAT_VALUE: '[+-]?([0-9]*[.])?[0-9]+';
fragment CHAR_VALUE: '^[0-9A-Za-z]'; //todo add special charecters
fragment BOOLEAN_VALUE: (TRUE_KEYWORD|FALSE_KEYWORD);
fragment STRING_VALUE: '^["].*["]$';
fragment NULL_VALUE: NULL_KEYWORD;
WHITE_SPACE: '\\s' -> skip;