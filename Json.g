json : object
     | array ;

object : LBRA members RBRA ;

members :
        | memberlist ;

memberlist : pair (COMMA pair)* ;

pair : STRING COLON value ;

array : LBRACKET elements  RBRACKET ;

elements :
         | elementlist ;

elementlist : value (COMMA value)* ;

value : STRING
      | INT
      | FLOAT
      | TRUE
      | FALSE
      | NULL
      | object
      | array
      ;
