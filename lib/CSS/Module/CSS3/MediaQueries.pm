use v6;

# CSS3 Media Queries Extension Module
# - specification: http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/
#
# The CSS3 Core includes some basic CSS2.1 compatible @media at rules. This
# module follows the latest W3C recommendations, to extend the syntax.
#
# -- if you want the capability to to embed '@page' rules, you'll also need
#    to load the Paged Media extension module in your class structure.
class CSS::Module::CSS3::MediaQueries::Actions {...}

use CSS::Module::CSS3::_Base;

grammar CSS::Module::CSS3::MediaQueries:ver<20120619.000>
    is CSS::Module::CSS3::_Base {

    rule at-rule:sym<media> {(:i'media') [<media-list>||<media-list=.unknown-media-list>] <media-rules> }

    rule media-rules {
        '{' [ '@'<at-rule> | <ruleset> ]* <.end-block>
    }

    rule unknown-media-list  { <CSS::Grammar::Core::_any>* }
    rule media-query {[<media-op>? <media=.ident> | '(' <media-expr> ')']
                      [:i'and' '(' <media-expr> ')' ]*}
    rule media-op    {:i'only'|'not'}

    my rule _range {:i [$<prefix>=[min|max]\-]}
    rule media-expr  { <expr=.media-feature> || <media-feature-unknown> }

    proto rule media-feature  {*}

    #| width: <length>
    rule media-feature:sym<width> {:i (<._range>?[device\-]?width) ':' [ <expr=.media-expr-length> || <usage(&?ROUTINE.WHY)> ] }

    #| height: <length>
    rule media-feature:sym<height> {:i (<._range>?[device\-]?height) ':' [ <expr=.media-expr-length> || <usage(&?ROUTINE.WHY)> ] }
    rule media-expr-length { <length> }

    #| orientation: [portrait | landscape]?
    rule media-feature:sym<orientation> {:i (orientation) [ ':' <expr=.media-expr-orientation> || <usage(&?ROUTINE.WHY)> ]? }
    rule media-expr-orientation {:i [ portrait | landscape ] & <keyw> }

    #| aspect-ratio: <horizontal> "/" <vertical>   (e.g. "16/9")
    rule media-feature:sym<aspect-ratio> {:i (<._range>?[device\-]?aspect\-ratio) ':' [ <expr=.media-expr-aspect> || <usage(&?ROUTINE.WHY)> ] }
    rule media-expr-aspect {:i <horizontal=.integer> '/' <vertical=.integer> }

    #| color: <integer>
    rule media-feature:sym<color> {:i (<._range>?color[\-index]?) ':' [ <expr=.media-expr-color> || <usage(&?ROUTINE.WHY)> ] }
    #| color
    rule media-feature:sym<color-bool> {:i (color[\-index]?) <!before ':'> }

    #| monochrome: <integer>
    rule media-feature:sym<monochrome> {:i (<._range>?monochrome) ':' [ <expr=.media-expr-color> || <usage(&?ROUTINE.WHY)> ] }
    rule media-expr-color {:i <integer> }

    #| resolution: <resolution>
    rule media-feature:sym<resolution> {:i (<._range>?resolution) ':' [ <expr=.media-expr-resolution> || <usage(&?ROUTINE.WHY)> ] }
    rule media-expr-resolution { <resolution> }

    #| scan: [progressive | interlace]?
    rule media-feature:sym<scan> {:i (scan) [ ':' [ <expr=.media-expr-scan> || <usage(&?ROUTINE.WHY)> ] ]? }
    rule media-expr-scan {:i [ progressive | interlace ] & <keyw> }

    #| grid: [<integer>]?
    rule media-feature:sym<grid> {:i (grid) [ ':' [ <expr=.media-expr-grid> || <usage(&?ROUTINE.WHY)> ] ]? }
    rule media-expr-grid {:i [0 | 1 ] & <integer> }

    rule media-feature-unknown  { (<.ident>) [ ':' <any>* ]? }

}

class CSS::Module::CSS3::MediaQueries::Actions
    is CSS::Module::CSS3::_Base::Actions {

    # media-rules, media-list, media see core grammar actions
    method unknown-media-list($/) {
	$.warning("discarding media list");
        make [{"media-query" => [{"media-op" => "not"}, {"media" => "all"}]}];
    }

    method media-query($/) {
        return make [{"media-op" => "not"}, {"media" => "all"}]
            if @<media-expr> && @<media-expr>.grep({! .ast.defined});

	make $.list($/);
    }

    method media-op($/) {
        make $/.Str.lc
    }

    method media-expr($/) {
	make $.decl($<expr>, () )
            if $<expr>;
    }

    method media-feature-unknown($/)   {
        $.warning('unknown media-feature', lc($0));
    }
}
