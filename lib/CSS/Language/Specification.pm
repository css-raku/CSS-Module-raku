# a grammar for CSS parsing CSS property specifications. General format of
# each definition is: <properties> \t <synopsis> \t <initial-value>
#
# for example, then entries in http://www.w3.org/TR/CSS21/propidx.html
# we are only parsing properties and synopsis, these are the most regular
# and useful columns
#

grammar CSS::Language::Specification {
    rule TOP {^ <property-spec>* $}

    token ws {<!ww>' '*}
    token tab {\t}
    token property-spec {<prop-names> [<.tab>|<.ws>] <synopsis=.value-list>}

    token prop-names {[' '?[\'<prop-name=.id>\'|<prop-name=.id>|'*']]+}
    token id { <[a..z]>[\w|\-]* }
    token digits { \d+ }

    proto rule value-list {<...>}
    rule value-list:sym<either_or> { <value><occurs>? [ ('||') <value-list> ]+ }
    rule value-list:sym<or>        { <value><occurs>? [ ('|')  <value-list> ]+ }
    rule value-list:sym<values>    { <value><occurs>? [ <value-list> ]* }

    proto rule occurs {<...>}
    rule occurs:sym<maybe>      {'?'}
    rule occurs:sym<once_plus>  {'+'}
    rule occurs:sym<zero_plus>  {'*'}
    rule occurs:sym<narity>     {'{'$<min>=\d+[','$<max>=\d+]'}'}

    proto rule value {<...>}
    rule value:sym<group>       { '[' <value-list> ']' }
    rule value:sym<func>        { <id>'(' <value-list> ')' }
    rule value:sym<rule>        { '<'<id>'>' }
    rule value:sym<prop>        { \'<id>\' }
    rule value:sym<inherit>     { inherit }
    rule value:sym<keyw>        { <id> }
    rule value:sym<punc>        { ',' | '/' }
    rule quote {\'|\‘|\’}
    rule value:sym<quoted>      {<.quote>(<- quote>*)<.quote>}
    rule value:sym<num>         { <digits> }
}
