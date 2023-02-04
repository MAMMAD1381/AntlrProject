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
          '(' variable_initialzing (';' variable_initialzing)* ')'
          RETURNS_KEYWORD DATATYPE
          '{'
          statement*
          (RETURN_KEYWORD '(' VALUE ')' ';')?
          '}' (';')?;
proc: ACCESSTYPE? STATIC_KEYWORD? PROC_KEYWORD CLASS_NAME
      '(' statement* ')' ';';
statement: ' ';

variable_initialzing: ' ';
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