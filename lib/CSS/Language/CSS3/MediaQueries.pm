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

    rule media-feature:sym<width|height> {:i (<._range>?[device\-]?[width|height]) ':' <val(rx:i:s[ <length> ])> }

    rule media-feature:sym<orientation> {:i (orientation) [ ':' <val(rx:i:s[ [ portrait | landscape ] & <keyw> ])> ]? }

    rule media-feature:sym<aspect-ratio> {:i (<._range>?[device\-]?aspect\-ratio) ':' <val(rx:i:s[ <horizontal=.integer> '/' <vertical=.integer> ])> }

    rule media-feature:sym<color> {:i (<._range>?color[\-index]?) [ ':' <val(rx:i:s[ <integer> ])> ] }
    rule media-feature:sym<color-bool> {:i (color[\-index]?) <!before ':'> }

    rule media-feature:sym<monochrome> {:i (<._range>?monochrome) ':' <val(rx:i:s[ <integer> ])> }

    rule media-feature:sym<resolution> {:i (<._range>?resolution) ':' <val(rx:i:s[ <resolution> ])> }

    rule media-feature:sym<scan> {:i (scan) [ ':' <val(rx:i:s[ [ progressive | interlace] & <keyw> ])> ]? }

    rule media-feature:sym<grid> {:i (grid) [ ':' <val(rx:i:s[ [0 | 1 ] & <integer> ])> ]? }

    rule media-feature-unknown  { <media-feature=.ident> [ ':' <any>* ]? }

}

grammar CSS::Language::CSS3::MediaQueries:ver<20120619.000>
    is CSS::Language::CSS3::MediaQueries::Syntax
    is CSS::Language::CSS3::_Base {
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

    method _media-decl($prop, $/, $synopsis) {
        return $._decl($prop, $/, $synopsis);
    }

    method media-expr($/) {
	make $<expr>.ast;
    }

    #= width|height: <length>
    method media-feature:sym<width|height>($/) {
        return $.warning($0.Str.lc ~ ': length cannot be negative')
            if $<val> && $<val>.match(/\-/);
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= orientation: [portrait | landscape]?
    method media-feature:sym<orientation>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= aspect-ratio: <horizontal> "/" <vertical>   (e.g. "16/9")
    method media-feature:sym<aspect-ratio>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= color: <integer>
    method media-feature:sym<color>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= color-bool: 
    method media-feature:sym<color-bool>($/) {
        make $._media-decl($0, $<val>, '');
    }

    #= monochrome: <integer>
    method media-feature:sym<monochrome>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= resolution: <resolution>
    method media-feature:sym<resolution>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= scan: [progressive | interlace]?
    method media-feature:sym<scan>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    #= grid: [<integer>]?
    method media-feature:sym<grid>($/) {
        make $._media-decl($0, $<val>, &?ROUTINE.WHY);
    }

    method media-feature-unknown($/)   {
        $.warning('unknown media-feature', $<media-feature>.ast);
    }
}
