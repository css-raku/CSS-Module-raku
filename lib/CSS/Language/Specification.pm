# a grammar for CSS parsing CSS property specifications.
#
# An example, from http://www.w3.org/TR/CSS21/propidx.html:
#
#    'content'	normal
#               | none
#               | [  <string> | <uri> | <counter> | attr(<identifier>)
#                  | open-quote | close-quote | no-open-quote | no-close-quote
#                 ]+
#               | inherit
#
#

grammar CSS::Language::Specification {
    rule TOP {^ <property-spec>* $}

    rule property-spec {<prop-names>[\t| \: ]<synopsis=.terms>}

    rule prop-sep    {<[\x20 \, \*]>+}
    token prop-names { [ <id=.id-quoted> | <id> ] +%% <.prop-sep> }
    token id         { <[a..z]>[\w|\-]* }
    rule quote       {\'|\‘|\’}
    token id-quoted  { <.quote> <id> <.quote> }
    rule keyw        { <id> }
    rule digits      { \d+ }

    rule terms       { <options>* }
    rule options     { <combo>    +% '|'  }
    rule combo       { <required> +% '||' }
    rule required    { <values>   +% '&&' }
    rule values      { <value-inst>+ }
    rule value-inst  { <value><occurs>**0..1 }

    proto rule occurs {<...>}
    rule occurs:sym<maybe>        {'?'}
    rule occurs:sym<once_plus>    {'+'}
    rule occurs:sym<zero_plus>    {'*'}
    rule occurs:sym<range>        {'{'<min=.digits>','<max=.digits>'}'}
    rule occurs:sym<list>         {'#'}

    proto rule value {<...>}
    rule value:sym<func>          { <id>'(' <.terms> ')' }
    rule value:sym<keywords>      { <keyw>   +% '|' }
    rule value:sym<numbers>       { <digits> +% '|' }
    rule value:sym<group>         { '[' <terms> ']' }
    rule value:sym<rule>          { '<'<id>'>' }
    rule value:sym<punc>          { ',' | '/' }

    proto token property-ref      { <...> }
    token property-ref:sym<css21> { <id=.id-quoted> }
    token property-ref:sym<css3>  { '<' <id=.id-quoted> '>' }
    rule value:sym<prop-ref>      { <property-ref> }
    rule value:sym<literal>       { <.quote>(<- quote>*)<.quote> }

}
