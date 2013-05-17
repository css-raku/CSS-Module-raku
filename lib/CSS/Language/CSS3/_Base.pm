use v6;

use CSS::Grammar::CSS3;
use CSS::Language::Actions;

class CSS::Language::CSS3::_Base::Actions {...}

grammar CSS::Language::CSS3::_Base
    is CSS::Grammar::CSS3 {
 
    rule declaration:sym<validated> { <decl> <prio>**0..1 <any-arg>* <end-decl> }

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

    # base colors - may be extended by css3x::colors
    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

    # base resolution units, used by Media Queries module. May be extended
    # by Units and Values module
    token resolution-units {:i[dpi|dpcm]}
    proto token resolution {<...>}
    token resolution:sym<dim> {<num>(<.resolution-units>)}
    token dimension:sym<resolution> {<resolution>}
}

class CSS::Language::CSS3::_Base::Actions 
    is CSS::Language::Actions {

    method resolution:sym<dim>($/)        { make $.token($<num>.ast, :units($0.Str.lc), :type('resolution')) }
    method dimension:sym<resolution>($/)  { make $<resolution>.ast }

}
