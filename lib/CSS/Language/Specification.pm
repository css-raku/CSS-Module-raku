# a grammar for CSS parsing CSS property specifications. General format of
# each definition is: <properties> \t <synopsis> \t <initial-value> ...
#
# for example, from entries in http://www.w3.org/TR/CSS21/propidx.html:
#
#    'content'	normal
#               | none
#               | [ <string> | <uri> | <counter> | attr(<identifier>)
#                  | open-quote | close-quote | no-open-quote | no-close-quote
#                 ]+
#               | inherit
#
# we are only parsing properties and synopsis, these are the most regular
# and useful columns
#

grammar CSS::Language::Specification {
    rule TOP {^ <property-spec>* $}

    token ws {<!ww>' '*}
    token tab {\t}
    token property-spec {<prop-names> [<.tab>|<.ws>] <synopsis=.list> }

    token prop-names {[' '?[\'<prop-name=.id>\'|<prop-name=.id>|'*']]+}
    token id { <!before inherit><[a..z]>[\w|\-]* }
    token keyw { <id> }
    token digits { \d+ }

    rule terms       { <list>* }
    rule list        { <either_or> [ '|' <either_or> ]* }
    rule either_or   { <values> [ '||' <values> ]* }
    rule values      { <value-inst>+ }
    rule value-inst  { <value><occurs>? }

    proto rule occurs {<...>}
    rule occurs:sym<maybe>      {'?'}
    rule occurs:sym<once_plus>  {'+'}
    rule occurs:sym<zero_plus>  {'*'}
    rule occurs:sym<range>      {'{'<min=.digits>[','<max=.digits>]'}'}

    proto rule value {<...>}
    rule value:sym<func>        { <keyw>'(' <.terms> ')' }
    rule value:sym<inherit>     { inherit }
    rule value:sym<keywords>    { <keyw> [ '|' <keyw> ]* }
    rule value:sym<numbers>     { <digits> [ '|' <digits> ]* }
    rule value:sym<group>       { '[' <terms> ']' }
    rule value:sym<rule>        { '<'<id>'>' }
    rule value:sym<prop>        { \'<id>\' }
    rule value:sym<punc>        { ',' | '/' }
    rule quote {\'|\‘|\’}
    rule value:sym<quoted>      {<.quote>(<- quote>*)<.quote>}

}
