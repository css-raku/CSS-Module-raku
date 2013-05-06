use v6;

# CSS3 Media Queries Extension Module
# - specification: http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/
#
# The CSS3 Core includes some basic CSS2.1 compatible @media at rules. This
# module follows the latest W3C recommendations, to extend the syntax.
#
# -- if you want the capability to to embed '@page' rules, you'll also need
#    to load the Paged Media extension module in your class structure.
class CSS::Language::CSS3::MediaQueries::Actions {...}

use CSS::Language::CSS3::_Base;

grammar CSS::Language::CSS3::MediaQueries::Syntax {
    rule at-rule:sym<media> {(:i'media') <media-list> <media-rules> }

    rule media-rules {
        '{' ['@'<?before [:i'page']><at-rule>|<ruleset>]* <.end-block>
    }

    rule media-list  {<media-query> [',' <media-query>]*}
    rule media-query {[<media-op>? <media=.ident> | '(' <media-expr> ')']
                      [:i'and' '(' <media-expr> ')' ]*}
    rule media-op    {:i['only'|'not']}

    proto rule media-expr {<...>}

    rule media-expr:sym<width|height> {:i ([[min|max|device]\-]?[width|height]) ':' [ <length> || <any-args> ] }

    rule media-expr:sym<orientation> {:i (orientation) ':' [ [ portrait | landscape ] & <keyw> || <any-args> ] }

    rule media-expr:sym<aspect-ratio> {:i ([device\-]?aspect\-ratio) ':' [ <horizontal=.integer> '/' <vertical=.integer> || <any-args> ] }

    rule media-expr:sym<color> {:i ([min|max]\-color[\-index]?) ':' [ <integer> || <any-args> ] }

    rule media-expr:sym<monochrome> {:i ([min|max]\-monochrome) ':' [ <integer> || <any-args> ] }

    rule media-expr:sym<resolution> {:i ([min|max]\-resolution) ':' [ <resolution> || <any-args> ] }

    rule media-expr:sym<scan> {:i (scan) ':' [ [ progressive | interlace] & <keyw> || <any-args> ] }

    rule media-expr:sym<grid> {:i (grid) ':' [ [0 | 1 ] & <integer> || <any-args> ] }

    rule media-expr:sym<any>  { '(' <media-feature=.ident> [ ':' <expr> ]? ')' }

    rule media-expr:sym<bool> {:i (height|color[\-index]?|[device\-]?[width|height]|[device\-]?aspect\-ratio|monochrome|resolution|grid|none) }

    token resolution {:i<num>(dpi|dpcm)}
    token quantity:sym<resolution> {<resolution>}
}

grammar CSS::Language::CSS3::MediaQueries:ver<20120619.000>
    is CSS::Language::CSS3::MediaQueries::Syntax
    is CSS::Language::CSS3::_Base {
}

class CSS::Language::CSS3::MediaQueries::Actions
    is CSS::Language::CSS3::_Base::Actions {

    # media-rules, media-list, media-query, media see core actions
    method media-op($/)              { make $/.Str.lc }

    method media-expr:sym<width|height>($/) {
        return $.warning($0.Str.lc ~ ': length cannot be negative')
            if $<length> && $<length>.ast < 0;
        $._make_decl($/,'<length>');
    }

    method media-expr:sym<bool>($/) {
        $._make_decl($/, '');
    }

    method media-expr:sym<orientation>($/) {
        $._make_decl($/, 'portrait | landscape');
    }

    method media-expr:sym<aspect-ratio>($/) {
        $._make_decl($/, '<horizontal> "/" <vertical>   (e.g. "16/9")');
    }

    method media-expr:sym<color>($/) {
        $._make_decl($/, '<integer>');
    }

    method media-expr:sym<monochrome>($/) {
        $._make_decl($/, '<integer>');
    }

    method media-expr:sym<resolution>($/) {
        $._make_decl($/, '<resolution>');
    }

    method media-expr:sym<scan>($/) {
        $._make_decl($/, 'progressive | interlace');
    }

    method media-expr:sym<grid>($/) {
        $._make_decl($/, '<integer>');
    }

    method media-expr:sym<any>($/)   {
        $.warning('unknown media-feature', $<media-feature>.ast);
        # todo - treat as 'not all'
    }
    method resolution($/)            { make $.token($<num>.ast, :units($0.Str.lc), :type('resolution')) }
    method quantity:sym<resolution>($/) { make $<resolution>.ast }
}
