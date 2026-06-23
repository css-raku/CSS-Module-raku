unit grammar CSS::Snapshot2026::Values::Gen::Grammar;
#| <position> = <position-one> | <position-two> | <position-four>
rule position { :i <position-one> || <position-two> || <position-four>  }
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
rule position-four { :i [[[[[left | right | "x-start" | "x-end" ]& <keyw> ] <length-percentage> ] :my $*A; <!{
    $*A++
}>|| [[[top | bottom | "y-start" | "y-end" ]& <keyw> ] <length-percentage> ] :my $*B; <!{
    $*B++
}>]** 2 || [[[["block-start" | "block-end" ]& <keyw> ] <length-percentage> ] :my $*C; <!{
    $*C++
}>|| [[["inline-start" | "inline-end" ]& <keyw> ] <length-percentage> ] :my $*D; <!{
    $*D++
}>]** 2 || [[[start | end ]& <keyw> ] <length-percentage> ] ** 2 ] }