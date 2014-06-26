use v6;

grammar CSS::Language::CSS3::Fonts::AtFontFace {...}

use CSS::Language::CSS3::Fonts::Variants;
use CSS::Language::CSS3::_Base;
use CSS::Language::CSS3::Fonts::AtFontFace::Spec::Interface;
use CSS::Language::CSS3::Fonts::AtFontFace::Spec::Grammar;
use CSS::Language::CSS3::Fonts::AtFontFace::Spec::Actions;

grammar CSS::Language::CSS3::Fonts::AtFontFace
    is CSS::Language::CSS3::Fonts::Variants
    is CSS::Language::CSS3::Fonts::AtFontFace::Spec::Grammar
    is CSS::Language::CSS3::_Base {

    # @font-face declarations

    # ---- Functions ----
    rule format {:i'format(' [ <format=.string> | <format=.keyw> || <any-args> ] ')'}
    rule local  {:i'local(' [ <font-face-name> || <any-args> ] ')'}
    rule font-face-name { <font-face-name=.identifiers> | <font-face-name=.string> }

    rule src { <uri> <format>? | <local> <format>? | <font-face-name=.identifiers> }
}
