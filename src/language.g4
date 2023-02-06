grammar language;
mainBlock: impurt?
           class
           ;
impurt: IMPORT_KEYWORD ':' ':'
        FROM_KEYWORD '(' LIBRARY_NAME  ((','LIBRARY_NAME)+ | (',' '*')) ')'
        '.' ';' ';';
class:  ACCESSTYPE? LIBRARY_NAME CLASS_KEYWORD inheritance? implementation?
        BEGIN_KEYWORD
        classBody*
        END_KEYWORD
        (';')?
        ;

classBody: function | proc;
inheritance: INHERITED_KEYWORD FROM_KEYWORD LIBRARY_NAME (',' LIBRARY_NAME)*;
implementation: IMPLEMENTS_KEYWORD LIBRARY_NAME (',' LIBRARY_NAME)*;
function: ACCESSTYPE? STATIC_KEYWORD? FUNC_KEYWORD LIBRARY_NAME
          '(' variable_initializing (';' variable_initializing)* ')'
          RETURNS_KEYWORD DATATYPE
          '{'
          statement*
          (RETURN_KEYWORD '(' VALUE ')' ';')?
          '}' (';')?;
proc: ACCESSTYPE? STATIC_KEYWORD? PROC_KEYWORD LIBRARY_NAME
      '(' statement* ')' ';';
variable_initializing: ACCESSTYPE? CONSTANT_KEYWORD? VAR_KEYWORD
                      VARIABLE_NAME ':' DATATYPE ('=' VALUE)?(';')?; //TODO MORE THAN ONE VARIABLE
array_initializing: ACCESSTYPE? CONSTANT_KEYWORD? VAR_KEYWORD
                    '[' ('0' ':' INTEGER_VALUE)? ']' LIBRARY_NAME ':' DATATYPE
                    ('=' '{[' VALUE (',' VALUE)* ']}')?
                    (';')?;
refrence_initializing: ACCESSTYPE? LIBRARY_NAME VARIABLE_NAME '->'
                       '(' ('new' LIBRARY_NAME '(' (VARIABLE_NAME (',' VARIABLE_NAME)*)? ')' | NULL_KEYWORD) ')'
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
           '(' LIBRARY_NAME (',' LIBRARY_NAME)* ')' BEGIN_KEYWORD (statement*)? END_KEYWORD;

increment: (VARIABLE_NAME INCREMENT_OPERATORS)|(INCREMENT_OPERATORS VARIABLE_NAME);

condition: (TRUE_KEYWORD
           | FALSE_KEYWORD
           | (VARIABLE_NAME | VALUE) CONDITIONAL_OPERATORS (VARIABLE_NAME | VALUE))
           ;
statement: (variable_initializing|array_initializing|refrence_initializing|for|while
            |doWhile|if|conditionionalOperator|switch|exception|increment|assignment);
assignment: VARIABLE_NAME '<-' VALUE (';')?;
ACCESSTYPE: D I R E C T A C C E S S|I N D I R E C T A C C E S S|R E S T R I C T E D;
LIBRARY_NAME: [A-Z_$][a-zA-Z_$0-9]*;
VARIABLE_NAME: [a-zA-Z_$][a-zA-Z_$0-9]*;
INCREMENT_OPERATORS: ('++'|'--'|'+='|'-='|'*='|'/=');
CONDITIONAL_OPERATORS: ('>'|'<'|'=='|'!='|'>='|'<=');
OPERATORS: ('+'|'-'|'*'|'/');
COMMENTING: (SINGLE_LINE_COMMENT|MULTI_LINE_COMMENT);
DATATYPE: (INTEGER_KEYWORD|FLOAT_KEYWORD|CHAR_KEYWORD|BOOLEAN_KEYWORD|STRING_KEYWORD|NULL_KEYWORD);
VALUE: (INTEGER_VALUE|FLOAT_VALUE|CHAR_VALUE|BOOLEAN_VALUE|STRING_VALUE|NULL_VALUE);
CLASS_KEYWORD: C L A S S;
BEGIN_KEYWORD: B E G I N;
END_KEYWORD: E N D;
INHERITED_KEYWORD: I N H E R I T E D;
FROM_KEYWORD: F R O M;
IMPLEMENTS_KEYWORD: I M P L E M E N T S;
STATIC_KEYWORD: S T A T I C;
FUNC_KEYWORD: F U N C;
VAR_KEYWORD: V A R;
RETURNS_KEYWORD: R E T U R N S;
RETURN_KEYWORD: R E T U R N;
PROC_KEYWORD: P R O C;
CONSTANT_KEYWORD: C O N S T A N T;
FOR_KEYWORD: F O R;
EVREY_KEYWORD: E V R E Y;
DO_KEYWORD: D O;
UNTIL_KEYWORD: U N T I L;
IN_KEYWORD: I N;
WHILE_KEYWORD: W H I L E;
AS_LONG_AS_KEYWORD: A S '_' L O N G '_' A S;
IF_KEYWORD: I F;
THEN_KEYWORD: T H E N;
ELIF_KEYWORD: E L I F;
ELSE_DO_AS_FOLLOWS_KEYWORD: E L S E '_' D O  '_' A S '_' F O L L O W S;
STOP_KEYWORD: S T O P;
SWITCH_KEYWORD: S W I T C H;
MATCH_KEYWORD: M A T C H;
CASE_KEYWORD: C A S E;
BREAK_KEYWORD: B R E A K;
DEFAULT_KEYWORD: D E F A U L T;
TRY_KEYWORD: T R Y;
CATCH_KEYWORD: C A T C H;
IMPORT_KEYWORD: I M P O R T;
fragment SINGLE_LINE_COMMENT: '^[/][/].*'; //TODO CHECK /
fragment MULTI_LINE_COMMENT: '^[!][#](?s).*[!][#]$';
fragment INTEGER_VALUE: '\b[0-9]+\b'; //todo add binary and hex value
fragment FLOAT_VALUE: '[+-]?([0-9]*[.])?[0-9]+';
fragment CHAR_VALUE: '^[0-9A-Za-z]'; //todo add special charecters
fragment BOOLEAN_VALUE: (TRUE_KEYWORD|FALSE_KEYWORD);
fragment STRING_VALUE: '^["].*["]$';
fragment NULL_VALUE: NULL_KEYWORD;
fragment TRUE_KEYWORD: T R U E;
fragment FALSE_KEYWORD: F A L S E;
fragment INTEGER_KEYWORD: I N T E G E R;
fragment FLOAT_KEYWORD: F L O A T;
fragment CHAR_KEYWORD: C H A R;
fragment BOOLEAN_KEYWORD: B O O L E A N;
fragment STRING_KEYWORD: S T R I N G;
fragment NULL_KEYWORD: N U L L;
fragment A:[aA];
fragment B:[bB];
fragment C:[cC];
fragment D:[dD];
fragment E:[eE];
fragment F:[fF];
fragment G:[gG];
fragment H:[hH];
fragment I:[iI];
fragment J:[jJ];
fragment K:[kK];
fragment L:[lL];
fragment M:[mM];
fragment N:[nN];
fragment O:[oO];
fragment P:[pP];
fragment Q:[qQ];
fragment R:[rR];
fragment S:[sS];
fragment T:[tT];
fragment U:[uU];
fragment V:[vV];
fragment W:[wW];
fragment X:[xX];
fragment Y:[yY];
fragment Z:[zZ];
WHITE_SPACE: [ \n\r\t]+ -> skip;