use v6;

use CSS::Grammar::CSS3;
use CSS::Language::Actions;

grammar CSS::Language::CSS3::_Base
    is CSS::Grammar::CSS3 {
 
        rule declaration:sym<validated> { <decl> <prio>? <any-arg>* <end-decl> }

        token integer     {[\+|\-]?\d+ <!before ['%'|\w|'.']>}
        token number      {<num> <!before ['%'|\w]>}
        token uri         {<url>}
        token keyw        {<ident>}           # keywords (case insensitive)
        token identifier  {<name>}            # identifiers (case sensitive)
        rule identifiers  {[ <identifier> ]+} # sequence of identifiers

        # http://www.w3.org/TR/2013/CR-css3-values-20130404/ 3.1.1
        # - all properties accept the 'initial' and 'inherit' keywords
        proto token proforma        { <...> }
        token proforma:sym<inherit> {:i inherit}
        token proforma:sym<initial> {:i initial}
        rule misc                   {<proforma>**0..1 <any-arg>*}
}

class CSS::Language::CSS3::_Base::Actions 
    is CSS::Language::Actions {
}
