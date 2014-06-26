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

    rule property-spec { <prop-names>[ \t | \: ] <terms> }
    # possibly tab delimited. Assume one spec per line.
    token ws {<!ww>' '*}

    token prop-sep    {<[\x20 \, \*]>+}
    token prop-names { [ <id=.id-quoted> | <id> ] +%% <.prop-sep> }
    token id         { <[a..z]>[\w|\-]* }
    token quote      {<[\' \‘ \’]>}
    token id-quoted  { <.quote> <id> <.quote> }
    rule keyw        { <id> }
    rule digits      { \d+ }

    rule terms       { <term=.options>* }
    rule options     { <term=.combo>    +% '|'  }
    rule combo       { <term=.required> +% '||' }
    rule required    { <term=.values>   +% '&&' }
    rule values      { <term>+ }
    rule term        { <value><occurs>? }

    proto token occurs {*}
    token occurs:sym<maybe>       {'?'}
    token occurs:sym<once-plus>   {'+'}
    token occurs:sym<zero-plus>   {'*'}
    token occurs:sym<range>       {'{'~'}' [<min=.digits>','<max=.digits>] }
    token occurs:sym<list>        {'#'}

    proto rule value {*}
    rule value:sym<func>          { <id>'(' ~ ')' <.terms> }
    rule value:sym<keywords>      { <keyw>   +% '|' }
    rule value:sym<numbers>       { <digits> +% '|' }
    rule value:sym<group>         { '[' ~ ']' <terms> }
    rule value:sym<rule>          { '<'~'>' <id> }
    rule value:sym<punc>          { ',' | '/' }
    rule value:sym<prop-ref>      { <property-ref> }

    proto token property-ref      {*}
    token property-ref:sym<css21> { <id=.id-quoted> }
    token property-ref:sym<css3>  { '<'~'>' <id=.id-quoted> }

}
