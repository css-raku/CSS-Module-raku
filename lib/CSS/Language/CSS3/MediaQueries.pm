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

grammar CSS::Language::CSS3::MediaQueries:ver<20120619.000>
    is CSS::Language::CSS3::_Base {

    rule at-rule:sym<media> {(:i'media') [<media-list>||<media-list=.unknown-media-list>] <media-rules> }

    rule media-rules {
        '{' [ '@'<at-rule> | <ruleset> ]* <.end-block>
    }

    rule unknown-media-list  { <CSS::Grammar::Core::_any>* }
    rule media-query {[<media-op>? <media=.ident> | '(' <media-expr> ')']
                      [:i'and' '(' <media-expr> ')' ]*}
    rule media-op    {:i'only'|'not'}

    my rule _range {:i [$<prefix>=[min|max]\-]}
    rule media-expr  { <expr=.media-feature> || <expr=.media-feature-unknown> }

    proto rule media-feature  {*}

    rule media-feature:sym<width|height> {:i (<._range>?[device\-]?[width|height]) ':' [ <expr=.media-expr-length> || <any-args> ] }
    rule media-expr-length { <length> }

    rule media-feature:sym<orientation> {:i (orientation) [ ':' <expr=.media-expr-orientation> || <any-args> ]? }
    rule media-expr-orientation {:i [ portrait | landscape ] & <keyw> }

    rule media-feature:sym<aspect-ratio> {:i (<._range>?[device\-]?aspect\-ratio) ':' [ <expr=.media-expr-aspect> || <any-args> ] }
    rule media-expr-aspect {:i <horizontal=.integer> '/' <vertical=.integer> }

    rule media-feature:sym<color> {:i (<._range>?color[\-index]?) ':' [ <expr=.media-expr-color> || <any-args> ] }
    rule media-feature:sym<monochrome> {:i (<._range>?monochrome) ':' [ <expr=.media-expr-color> || <any-args> ] }
    rule media-expr-color {:i <integer> }

    rule media-feature:sym<color-bool> {:i (color[\-index]?) <!before ':'> }

    rule media-feature:sym<resolution> {:i (<._range>?resolution) ':' [ <expr=.media-expr-resolution> || <any-args> ] }
    rule media-expr-resolution { <resolution> }

    rule media-feature:sym<scan> {:i (scan) [ ':' [ <expr=.media-expr-scan> || <any-args> ] ]? }
    rule media-expr-scan {:i [ progressive | interlace ] & <keyw> }

    rule media-feature:sym<grid> {:i (grid) [ ':' [ <expr=.media-expr-grid> || <any-args> ] ]? }
    rule media-expr-grid {:i [0 | 1 ] & <integer> }

    rule media-feature-unknown  { <media-feature=.ident> [ ':' <any>* ]? }

}

class CSS::Language::CSS3::MediaQueries::Actions
    is CSS::Language::CSS3::_Base::Actions {

    has @._proforma;

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

    method media-op($/)              { make $/.Str.lc }

    method media-expr($/) {
	make $<expr>.ast;
    }

    #= width|height: <length>
    method media-feature:sym<width|height>($/) {
        return $.warning($0.Str.lc ~ ': length cannot be negative')
            if $<expr> && $<expr>.match(/\-/);
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= orientation: [portrait | landscape]?
    method media-feature:sym<orientation>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= aspect-ratio: <horizontal> "/" <vertical>   (e.g. "16/9")
    method media-feature:sym<aspect-ratio>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= color: <integer>
    method media-feature:sym<color>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= color-bool 
    method media-feature:sym<color-bool>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= monochrome: <integer>
    method media-feature:sym<monochrome>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= resolution: <resolution>
    method media-feature:sym<resolution>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    #= scan: [progressive | interlace]?
    method media-feature:sym<scan>($/) {
        make $._decl($/, &?ROUTINE.WHY);
    }

    #= grid: [<integer>]?
    method media-feature:sym<grid>($/) {
        make $.decl($/, &?ROUTINE.WHY);
    }

    method media-feature-unknown($/)   {
        $.warning('unknown media-feature', $<media-feature>);
    }
}
