unit grammar CSS::Snapshot2026::Values::Gen::Grammar;
#| <position> = <position-four> | <position-two> | <position-one>
rule position { :i <position-four> || <position-two> || <position-one>  }
#| <position-one> = [  left | center | right | top | bottom |  x-start | x-end | y-start | y-end |  block-start | block-end | inline-start | inline-end |  <length-percentage>]
rule position-one { :i [[left | center | right | top | bottom | "x-start" | "x-end" | "y-start" | "y-end" | "block-start" | "block-end" | "inline-start" | "inline-end" ]& <keyw>  || <length-percentage> ] }
#| <position-two> = [  [ left | center | right | x-start | x-end ] &&  [ top | center | bottom | y-start | y-end ]|  [ left | center | right | x-start | x-end | <length-percentage> ]  [ top | center | bottom | y-start | y-end | <length-percentage> ]|  [ block-start | center | block-end ] &&  [ inline-start | center | inline-end ]|  [ start | center | end ]{2}]
rule position-two { :i [[[[left | center | right | "x-start" | "x-end" ]& <keyw> ] :my $*A;<!{
    $*A++
}>|| [[top | center | bottom | "y-start" | "y-end" ]& <keyw> ] :my $*B;<!{
    $*B++
}>]** 2 || [[left | center | right | "x-start" | "x-end" ]& <keyw>  || <length-percentage> ] [[top | center | bottom | "y-start" | "y-end" ]& <keyw>  || <length-percentage> ]  || [[["block-start" | center | "block-end" ]& <keyw> ] :my $*C;<!{
    $*C++
}>|| [["inline-start" | center | "inline-end" ]& <keyw> ] :my $*D;<!{
    $*D++
}>]** 2 || [[start | center | end ]& <keyw> ] ** 2 ] }
#| <position-four> = [  [ [ left | right | x-start | x-end ] <length-percentage> ] &&  [ [ top | bottom | y-start | y-end ] <length-percentage> ]|  [ [ block-start | block-end ] <length-percentage> ] &&  [ [ inline-start | inline-end ] <length-percentage> ]|  [ [ start | end ] <length-percentage> ]{2}]
rule position-four { :i [[[[[left | right | "x-start" | "x-end" ]& <keyw> ] <length-percentage> ] :my $*A;<!{
    $*A++
}>|| [[[top | bottom | "y-start" | "y-end" ]& <keyw> ] <length-percentage> ] :my $*B;<!{
    $*B++
}>]** 2 || [[[["block-start" | "block-end" ]& <keyw> ] <length-percentage> ] :my $*C;<!{
    $*C++
}>|| [[["inline-start" | "inline-end" ]& <keyw> ] <length-percentage> ] :my $*D;<!{
    $*D++
}>]** 2 || [[[start | end ]& <keyw> ] <length-percentage> ] ** 2 ] }
#| <length-percentage> = <length> | <percentage> | <number>
rule length-percentage { :i <length> || <percentage> || <number>  }
#| calc( <calc-sum> )
rule calc { :i "calc(" [<calc-sum> || <usage(&?ROUTINE.WHY)> ] ")" }
#| <calc-sum> = <calc-product> [ [ '+' | '-' ] <calc-product> ]*
rule calc-sum { :i <calc-product> [[<op("+")> || <op("-")> ] <calc-product> ] *  }
#| <calc-product> = <calc-value> [ [ '*' | '/' ] <calc-value> ]*
rule calc-product { :i <calc-value> [[<op("*")> || <op("/")> ] <calc-value> ] *  }
#| <calc-value> = <number> | <dimension> | <percentage> |               <calc-keyword> | ( <calc-sum> )
rule calc-value { :i <number> || <dimension> || <percentage> || <calc-keyword> || <op("(")> <calc-sum> <op(")")>   }
#| <calc-keyword> = e | pi | infinity | -infinity | NaN
rule calc-keyword { :i [e | pi | infinity | "-infinity" | NaN ]& <keyw>  }