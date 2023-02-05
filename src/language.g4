grammar language;
mainBlock: impurt
           class
           ;
impurt: 'import' ':' ':'
        'from' '(' LIBRARY_NAME  ((','CLASS_NAME)+ | (',' '*')) ')'
        '.' ';' ';';
class:  ACCESSTYPE? CLASS_NAME CLASS_KEYWORD inheritance? implementation?
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
                      VARIABLE_NAME ':' VARIABLETYPE ('=' VALUE)?(';')?; //TODO MORE THAN ONE VARIABLE
array_initializing: ACCESSTYPE? CONSTANT_KEYWORD? VAR_KEYWORD
                    '[' ('0' ':' INTEGER)? ']' CLASS_NAME ':' VARIABLETYPE
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
switch: SWITCH_KEYWORD EXPRESSION MATCH_KEYWORD
        CASE_KEYWORD EXPRESSION ':' (statement*)? (BREAK_KEYWORD)?
        (CASE_KEYWORD EXPRESSION ':' (statement*)? (BREAK_KEYWORD)?)*
        (DEFAULT_KEYWORD EXPRESSION ':' (statement*)? END_KEYWORD)?
        ;
exception: TRY_KEYWORD '{{' (statement*)? '}}' CATCH_KEYWORD
           '(' CLASS_NAME (',' CLASS_NAME)* ')' BEGIN_KEYWORD (statement*)? END_KEYWORD;

increment: ' ';

condition: ' ';
statement: ' ';

ACCESSTYPE:'directAccess'|'indirectAccess'|'restricted';
CLASS_NAME:;
LIBRARY_NAME:;
CLASS_KEYWORD:;
BEGIN_KEYWORD:;
END_KEYWORD:;
INHERITED_KEYWORD:;
FROM_KEYWORD:;
IMPLEMENTS_KEYWORD:;
STATIC_KEYWORD:;
FUNC_KEYWORD:;
VAR_KEYWORD:;
RETURNS_KEYWORD:;
DATATYPE:;
RETURN_KEYWORD:;
VALUE:;
PROC_KEYWORD:;
VARIABLE_NAME:;
VARIABLETYPE:;
CONSTANT_KEYWORD:;
INTEGER:;
NULL_KEYWORD:;
FOR_KEYWORD:;
EVREY_KEYWORD:;
DO_KEYWORD:;
UNTIL_KEYWORD:;
IN_KEYWORD:;
WHILE_KEYWORD:;
AS_LONG_AS_KEYWORD:;
IF_KEYWORD:;
THEN_KEYWORD:;
ELIF_KEYWORD:;
ELSE_DO_AS_FOLLOWS_KEYWORD:;
STOP_KEYWORD:;
SWITCH_KEYWORD:;
MATCH_KEYWORD:;
CASE_KEYWORD:;
BREAK_KEYWORD:;
DEFAULT_KEYWORD:;
EXPRESSION:;
TRY_KEYWORD:;
CATCH_KEYWORD:;