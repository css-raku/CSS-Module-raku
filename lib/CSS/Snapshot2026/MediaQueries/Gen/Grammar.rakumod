unit grammar CSS::Snapshot2026::MediaQueries::Gen::Grammar;
#| <media-query> = <media-condition>             | [ not | only ]? <media-type> [ and <media-condition-without-or> ]?
rule media-query { :i <media-condition> || [[not | only ]& <keyw> ] ? <media-type> [[and & <keyw> ] <media-condition-without-or> ] ? }
#| <media-type> = <ident>
rule media-type { :i <Ident> }
#| <media-condition> = <media-not> | <media-in-parens> [ <media-and>* | <media-or>* ]
rule media-condition { :i <media-not> || <media-in-parens> [<media-and> * || <media-or> * ] }
#| <media-condition-without-or> = <media-not> | <media-in-parens> <media-and>*
rule media-condition-without-or { :i <media-not> || <media-in-parens> <media-and> * }
#| <media-not> = not <media-in-parens>
rule media-not { :i [not & <keyw> ] <media-in-parens> }
#| <media-and> = and <media-in-parens>
rule media-and { :i [and & <keyw> ] <media-in-parens> }
#| <media-or> = or <media-in-parens>
rule media-or { :i [or & <keyw> ] <media-in-parens> }
#| <media-in-parens> = ( <media-condition> ) | ( <media-feature> ) | <general-enclosed>
rule media-in-parens { :i <op("(")> <media-condition> <op(")")> || <op("(")> <media-feature> <op(")")> || <general-enclosed> }
#| <media-feature> = [ <mf-plain> | <mf-boolean> | <mf-range> ]
rule media-feature { :i [<mf-plain> || <mf-boolean> || <mf-range> ] }
#| <mf-plain> = <mf-name> : <mf-value>
rule mf-plain { :i <mf-name> ":" <mf-value> }
#| <mf-boolean> = <mf-name>
rule mf-boolean { :i <mf-name> }
#| <mf-range> = <mf-name> <mf-comparison> <mf-value>           | <mf-value> <mf-comparison> <mf-name>           | <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value>           | <mf-value> <mf-gt> <mf-name> <mf-gt> <mf-value>
rule mf-range { :i <mf-name> <mf-comparison> <mf-value> || <mf-value> <mf-comparison> <mf-name> || <mf-value> <mf-lt> <mf-name> <mf-lt> <mf-value> || <mf-value> <mf-gt> <mf-name> <mf-gt> <mf-value> }
#| <mf-name> = <ident>
rule mf-name { :i <Ident> }
#| <mf-value> = <number> | <dimension> | <ident> | <ratio>
rule mf-value { :i <number> || <dimension> || <Ident> || <ratio> }
#| <mf-lt> = '<' '='?
rule mf-lt { :i <op("<")> <op("=")> ? }
#| <mf-gt> = '>' '='?
rule mf-gt { :i <op(">")> <op("=")> ? }
#| <mf-eq> = '='
rule mf-eq { :i <op("=")> }
#| <mf-comparison> = <mf-lt> | <mf-gt> | <mf-eq>
rule mf-comparison { :i <mf-lt> || <mf-gt> || <mf-eq> }
#| <general-enclosed> = [ <function> ( <any-value>? ) ] | [ ( <any-value>? ) ]
rule general-enclosed { :i [<function> <op("(")> <any-value> ?<op(")")> ] || [<op("(")> <any-value> ?<op(")")> ] }
