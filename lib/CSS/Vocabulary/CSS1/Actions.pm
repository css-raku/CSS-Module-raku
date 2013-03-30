use v6;

use CSS::Vocabulary::Actions;

class CSS::Vocabulary::CSS1::Actions
    is CSS::Vocabulary::Actions {

    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed | inherit');
    };

    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent | inherit')
    };

    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none | inherit')
    };

    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat')
    };

    method decl:sym<background-position>($/) {
        $._make_decl($/, '[<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]')
    };

    method decl:sym<font-style>($/) {
        $._make_decl($/, '');
    }


}
