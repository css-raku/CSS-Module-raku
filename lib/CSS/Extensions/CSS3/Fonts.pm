use v6;

# CSS3 Font Extension Module
# specification: http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
#
# nb this standard is under revision (as of Feb 2013). Biggest change
# is the proposed at-rule @font-feature-values

grammar CSS::Extensions::CSS3::Fonts::Syntax {
    rule at-rule:sym<font_face> {(:i'font-face') <declarations> }
}

grammar CSS::Extensions::CSS3::Fonts:ver<20130212.000> 
    is CSS::Extensions::CSS3::Fonts::Syntax {

    # ---- Functions ----
    rule format {:i'format(' [ <format=.string> | <format=.keyw> || <any-args> ] ')'}
    rule local  {:i'local(' [ <font-face-name=.identifiers> | <font-face-name=.string> || <any-args> ] ')'}

    # ---- Properties ----

    # todo src: locally scoped to @font-face?
    token src { <uri> <format>? | <local> <format>? | <font-face-name=.identifiers> }
    rule decl:sym<src> {:i (src) ':' [ <src> [ ',' <src> ]* || <any-args> ] }

    rule decl:sym<font-size-adjust> {:i (font\-size\-adjust) ':' [ [ none | auto ] & <keyw> | <number>
                                                                   || <any-args> ] }

    rule decl:sym<font-synthesis> {:i (font\-synthesis) ':' [ none & <keyw> 
                                                              | [[ weight | style ] & <keyw> ]**1..2
                                                              || <any-args> ] }
}

class CSS::Extensions::CSS3::Fonts::Actions {
    method at-rule:sym<font_face>($/) { make $.at-rule($/) }

    method format($/) {
        return $.warning("usage: format(type)")
            if $<any-args>;

        make $<format>.ast;
    }

    method local($/) {
        return $.warning("usage: local(font-face-name)")
            if $<any-args>;

        make $<font-face-name>.ast;
    }

    # ---- Properties ----

    method src($/) { make $.node($/) }
    method decl:sym<src>($/) {
        make $._make_decl($/, '<uri> [format(<string>#)]? | <font-face-name>');
    }

    method decl:sym<font-size-adjust>($/) {
        make $._make_decl($/, '<none> | <auto> | <number>');
    }

    method decl:sym<font-synthesis>($/) {
        make $._make_decl($/, '<none> | [ weight || style ]');
    }

}

