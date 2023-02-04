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
inheritance: INHERITED_KEYWORD FORM_KEYWORD CLASS_NAME (',' CLASS_NAME)*;
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

statement: ' ';

ACCESSTYPE:'directAccess'|'indirectAccess'|'restricted';
CLASS_NAME:;
LIBRARY_NAME:;
CLASS_KEYWORD:;
BEGIN_KEYWORD:;
END_KEYWORD:;
INHERITED_KEYWORD:;
FORM_KEYWORD:;
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