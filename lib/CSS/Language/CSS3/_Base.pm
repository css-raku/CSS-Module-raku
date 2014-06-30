use v6;

use CSS::Grammar::CSS3;
use CSS::Language::_Base;
use CSS::Language::_Base::Actions;

class CSS::Language::CSS3::_Base::Actions {...}

grammar CSS::Language::CSS3::_Base
    is CSS::Language::_Base
    is CSS::Grammar::CSS3 {
 
    # http://www.w3.org/TR/2013/CR-css3-values-20130404/ 3.1.1
    # - all properties accept the 'initial' and 'inherit' keywords
    proto token proforma        {*}
    token proforma:sym<inherit> {:i inherit}
    token proforma:sym<initial> {:i initial}

    # base colors - may be extended by css3x::colors
    rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

    # base resolution units, used by Media Queries module. May be extended
    # by Units and Values module
    token resolution-units {:i[dpi|dpcm]}
    proto token resolution {*}
    token resolution:sym<dim> {<num>(<.resolution-units>)}
    token dimension:sym<resolution> {<resolution>}
    # <val(..)> - rule for processing right hand side of property declarations
    rule val($expr)   { <proforma> | $<expr>=$expr || <any-args> }
}

class CSS::Language::CSS3::_Base::Actions 
    is CSS::Language::_Base::Actions {

    has @._proforma = 'inherit', 'initial';

    method resolution:sym<dim>($/)        { make $.token($<num>.ast, :units($0.Str.lc), :type('resolution')) }
    method dimension:sym<resolution>($/)  { make $<resolution>.ast }

}
