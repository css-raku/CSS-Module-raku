unit grammar CSS::Snapshot2026::Gen::Grammar;
#| @import [ <url> | <string> ]        [ layer | layer(<layer-name>) ]?        <import-conditions> ;
rule decl:sym<@import> { "\@"<at-rule=.at-rule-import>}
rule at-rule-import { (:i import) [<url> || <string> ] [[layer | layer ]& <keyw>  <op("(")> <layer-name> <op(")")>  ] ? <import-conditions> ";"  }
#| <layer-name> = <ident> [ '.' <ident> ]*
rule layer-name { :i <Ident> [<op(".")> <Ident> ] *  }
#| <import-conditions> = [ supports( [ <supports-condition> | <declaration> ] ) ]?
rule import-conditions { :i <supports> ? }
#| @layer <layer-name>? <declarations>
rule decl:sym<@layer> { "\@"<at-rule=.at-rule-layer>}
rule at-rule-layer { (:i layer) <layer-name> ? <declarations>  }
#| <supports-condition> = not <supports-in-parens>                     | <supports-in-parens> [ and <supports-in-parens> ]*                     | <supports-in-parens> [ or <supports-in-parens> ]*
rule supports-condition { :i [not & <keyw> ] <supports-in-parens>  || <supports-in-parens> [[and & <keyw> ] <supports-in-parens> ] *  || <supports-in-parens> [[or & <keyw> ] <supports-in-parens> ] *   }
#| <supports-in-parens> = ( <supports-condition> ) | <supports-feature> | <general-enclosed>
rule supports-in-parens { :i <op("(")> <supports-condition> <op(")")>  || <supports-feature> || <general-enclosed>  }
#| <supports-feature> = <supports-decl>
rule supports-feature { :i <supports-decl> }
#| <supports-decl> = ( <declaration> )
rule supports-decl { :i <op("(")> <declaration> <op(")")>  }
#| <general-enclosed> = [ <function> ( <any-value>? ) ] | [ ( <any-value>? ) ]
rule general-enclosed { :i [<function> <op("(")> <any-value> ?<op(")")>  ] || [<op("(")> <any-value> ?<op(")")> ]  }
#| <function> = <ident>
rule function { :i <Ident> }
#| supports( [ <supports-condition> | <declaration> ] )
rule supports { :i "supports(" [[<supports-condition> || <declaration> ] || <usage(&?ROUTINE.WHY)> ] ")" }