use v6;

# references:
# -- http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
# -- http://129.69.59.141/css1pqre.htm

use CSS::Language::_Base;
use CSS::Grammar::CSS1;
# BUILD.pl targets
use CSS::Language::CSS1::Spec::Interface;
use CSS::Language::CSS1::Spec::Grammar;

grammar CSS::Language::CSS1:ver<20080411.000>
    is CSS::Language::_Base
    is CSS::Grammar::CSS1
    is CSS::Language::CSS1::Spec::Grammar
    does CSS::Language::CSS1::Spec::Interface {

        # tweak generated font-family expression.
        rule expr-font-family    {:i  [ <generic-family> || <family-name> ] +% ',' }


        # allow color names and define our vocabulary
        rule color:sym<named>  {:i [aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | purple | red | silver | teal | white | yellow] & <keyw> }

        rule family-name    { <family-name=.identifiers> || <family-name=.string> }
        rule generic-family {:i [ serif | sans\-serif | cursive | fantasy | monospace ] & <generic-family=.identifier> }

        rule absolute-size {:i [ [[xx|x]\-]?small | medium | [[xx|x]\-]?large ] & <keyw> }
        rule relative-size {:i [ larger | smaller ] & <keyw> }

}
