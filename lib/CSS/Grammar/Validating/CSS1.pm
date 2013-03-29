use v6;

use CSS::Grammar::CSS1;

grammar CSS::Grammar::Validating::CSS1 is CSS::Grammar:CSS1 {

    rule decl:sym<background-attachment> {:i (background\-attachment) ':' [
                                               [ scroll | fixed ] & <ident>
                                               | <inherit> || <bad_args> ]}

    rule decl:sym<background-color> {:i (background\-color) ':' [
                                          <color>
                                          | [ fixed & <ident> ]
                                          | <inherit> || <bad_args> ]}

    rule decl:sym<background-image> {:i (background\-image) ':' [
                                          <url>
                                          | [ fixed & <ident> ]
                                          | <inherit> || <bad_args> ]}

    rule decl:sym<background-position> {:i (background\-position) ':' [
                                          [ <percentage> | <length> ]**1..2 | [ top | center | bottom ] & <ident>
                                          [[ left | center | right ] & <ident> ]?
                                          | <inherit> || <bad_args> ]}

    rule decl:sym<background-repeat> {:i (background\-repeat) ':' [
                                          [ repeat[\-[x|y]]? | no\-repeat ] & <ident>
                                          | <inherit> || <bad_args> ]}

    rule decl:sym<font\-style> {:i (font\-style) ':' [
                                     [ normal |bold | oblique ] & <ident>
                                     | <inherit> || <bad_args> ] }

}
