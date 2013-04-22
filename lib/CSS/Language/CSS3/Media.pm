use v6;

# CSS3 Media Module Extensions
# - specification: http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/
#
# The CSS3 Core includes some basic CSS2.1 compatible @media at rules. This
# module follows the latest W3C recommendations, to extend the syntax.
#
# -- if you want the capability to to embed '@page' rules, you'll also need
#    to load the Paged Media extension module in your class structure.

grammar CSS::Language::CSS3::Media::Syntax {
    rule at-rule:sym<media> {(:i'media') <media-list> <media-rules> }

    rule media-rules {
        '{' ['@'<?before [:i'page']><at-rule>|<ruleset>]* <.end-block>
    }

    rule media-list  {<media-query> [',' <media-query>]*}
    rule media-query {[<media-op>? <media=.ident>|<media-expr>]
                      [:i'and' <media-expr>]*}
    rule media-op    {:i['only'|'not']}
    rule media-expr  { '(' <media-feature=.ident> [ ':' <expr> ]? ')' }

    token resolution {:i<num>(dpi|dpcm)}
    token quantity:sym<resolution> {<resolution>}
}

grammar CSS::Language::CSS3::Media:ver<20120619.000>
    is  CSS::Language::CSS3::Media::Syntax {
        # todo properties
}

class CSS::Language::CSS3::Media::Actions {

    # media-rules, media-list, media-query, media see core actions
    method media-op($/)              { make $/.Str.lc }
    method media-expr($/)            { make $.node($/) }
    method resolution($/)            { make $.token($<num>.ast, :units($0.Str.lc), :type('resolution')) }
    method quantity:sym<resolution>($/) { make $<resolution>.ast }
}
