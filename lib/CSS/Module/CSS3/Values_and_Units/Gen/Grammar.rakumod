unit grammar CSS::Module::CSS3::Values_and_Units::Gen::Grammar;
#| calc( <calc-sum> )
rule calc { :i "calc(" [<calc-sum> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <calc-sum> = <calc-product> [ [ '+' | '-' ] <calc-product> ]*
rule calc-sum { :i <calc-product> [[<op("+")> || <op("-")> ] <calc-product> ] *  }
#| <calc-product> = <calc-value> [ '*' <calc-value> | '/' <calc-number-value> ]*
rule calc-product { :i <calc-value> [<op("*")> <calc-value>  || <op("/")> <calc-number-value>  ] *  }
#| <calc-value> = <number> | <dimension> | <percentage> | ( <calc-sum> )
rule calc-value { :i <number> || <dimension> || <percentage> || <op("(")> <calc-sum> <op(")")>   }
#| <calc-number-sum> = <calc-number-product> [ [ '+' | '-' ] <calc-number-product> ]*
rule calc-number-sum { :i <calc-number-product> [[<op("+")> || <op("-")> ] <calc-number-product> ] *  }
#| <calc-number-product> = <calc-number-value> [ '*' <calc-number-value> | '/' <calc-number-value> ]*
rule calc-number-product { :i <calc-number-value> [<op("*")> <calc-number-value>  || <op("/")> <calc-number-value>  ] *  }
#| <calc-number-value> = <number> | ( <calc-number-sum> )
rule calc-number-value { :i <number> || <op("(")> <calc-number-sum> <op(")")>   }