use v6;

use CSS::Vocabulary::Actions;

class CSS::Vocabulary::CSS1::Actions
    is CSS::Vocabulary::Actions {

    method decl:sym<font-family>($/) { warn "font-family - tba" }

    method decl:sym<font-style>($/) {
        $._make_decl($/, '');
    }

    method decl:sym<font-variant>($/) { warn "font-variant - tba" }
    method decl:sym<font-weight>($/) { warn "font-weight - tba" }
    method decl:sym<font-size>($/) { warn "font-size - tba" }
    method decl:sym<font>($/) { warn "font - tba" }
    method decl:sym<color>($/) { warn "color - tba" }

    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent | inherit')
    };

    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none | inherit')
    };

    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat')
    };

    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed | inherit');
    };

    method decl:sym<background-position>($/) {
        $._make_decl($/, '[<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]')
    };

    method decl:sym<background>($/) { warn "background - tba" }
    method decl:sym<word-spacing>($/) { warn "word-spacing - tba" }
    method decl:sym<letter-spacing>($/) { warn "letter-spacing - tba" }
    method decl:sym<text-decoration>($/) { warn "text-decoration - tba" }
    method decl:sym<vertical-align>($/) { warn "vertical-align - tba" }
    method decl:sym<text-transform>($/) { warn "text-transform - tba" }
    method decl:sym<text-align>($/) { warn "text-align - tba" }
    method decl:sym<text-indent>($/) { warn "text-indent - tba" }
    method decl:sym<line-height>($/) { warn "line-height - tba" }
    method decl:sym<margin-top>($/) { warn "margin-top - tba" }
    method decl:sym<margin-right>($/) { warn "margin-right - tba" }
    method decl:sym<margin-bottom>($/) { warn "margin-bottom - tba" }
    method decl:sym<margin-left>($/) { warn "margin-left - tba" }
    method decl:sym<margin>($/) { warn "margin - tba" }
    method decl:sym<padding-top>($/) { warn "padding-top - tba" }
    method decl:sym<padding-right>($/) { warn "padding-right - tba" }
    method decl:sym<padding-bottom>($/) { warn "padding-bottom - tba" }
    method decl:sym<padding-left>($/) { warn "padding-left - tba" }
    method decl:sym<padding>($/) { warn "padding - tba" }
    method decl:sym<border-top-width>($/) { warn "border-top-width - tba" }
    method decl:sym<border-right-width>($/) { warn "border-right-width - tba" }
    method decl:sym<border-bottom-width>($/) { warn "border-bottom-width - tba" }
    method decl:sym<border-left-width>($/) { warn "border-left-width - tba" }
    method decl:sym<border-width>($/) { warn "border-width - tba" }
    method decl:sym<border-color>($/) { warn "border-color - tba" }
    method decl:sym<border-style>($/) { warn "border-style - tba" }
    method decl:sym<border-top>($/) { warn "border-top - tba" }
    method decl:sym<border-right>($/) { warn "border-right - tba" }
    method decl:sym<border-bottom>($/) { warn "border-bottom - tba" }
    method decl:sym<border-left>($/) { warn "border-left - tba" }
    method decl:sym<border>($/) { warn "border - tba" }
    method decl:sym<width>($/) {  warn "width - tba" }
    method decl:sym<height>($/) {  warn "height - tba" }
    method decl:sym<float>($/) { warn "float - tba" }
    method decl:sym<clear>($/) { warn "clear - tba" }
    method decl:sym<display>($/) { warn "display - tba" }
    method decl:sym<white-space>($/) { warn "white-space - tba" }
    method decl:sym<list-style-type>($/) { warn "list-style-type - tba" }
    method decl:sym<list-style-image>($/) { warn "list-style-image - tba" }
    method decl:sym<list-style-position>($/) { warn "list-style-position - tba" }
    method decl:sym<list-style>($/) { warn "list-style - tba" }
    method decl:sym<position>($/) { warn "position - tba" }
    method decl:sym<left>($/) { warn "left - tba" }
    method decl:sym<top>($/) { warn "top - tba" }
    method decl:sym<clip>($/) { warn "clip - tba" }
    method decl:sym<overflow>($/) { warn "overflow - tba" }
    method decl:sym<z-index>($/) { warn "z-index - tba" }
    method decl:sym<visibility>($/) { warn "visibility - tba" }
    method decl:sym<page-break-before>($/) { warn "page-break-before - tba" }
    method decl:sym<page-break-after>($/) { warn "page-break-after - tba" }
    method decl:sym<size>($/) { warn "size - tba" }
    method decl:sym<marks>($/) { warn "marks - tba" }


}
