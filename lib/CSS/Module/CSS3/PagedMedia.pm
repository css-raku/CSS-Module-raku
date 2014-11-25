use v6;

class CSS::Module::CSS3::PagedMedia::Actions {...}
use CSS::Module::CSS3::_Base;
# CSS3 Paged Media Module Extensions
# - reference: http://www.w3.org/TR/2006/WD-css3-page-20061010/
#

# BUILD.pl targets
use CSS::Module::CSS3::PagedMedia::Spec::Interface;
use CSS::Module::CSS3::PagedMedia::Spec::Grammar;
use CSS::Module::CSS3::PagedMedia::Spec::Actions;

grammar CSS::Module::CSS3::PagedMedia:ver<20061010.000>
    is CSS::Module::CSS3::_Base
    is CSS::Module::CSS3::PagedMedia::Spec::Grammar
    does CSS::Module::CSS3::PagedMedia::Spec::Interface {

    rule page-pseudo        {:i':'[ [left|right|first] && <keyw> || <Ident> ]? }

    # @page declarations
    rule at-rule:sym<page>  {'@'(:i'page') <page-pseudo>? <declarations=.page-declarations> }

    rule page-declarations {
        '{' [ '@'<declaration=.margin-declaration> || <declaration> || <dropped-decl> ]* <.end-block>
    }

    token box-hpos   {:i[left|right]}
    token box-vpos   {:i[top|bottom]}
    token box-center {:i[cent[er|re]]}
    token margin-box{:i[<box-hpos>'-'[<box-vpos>['-corner']?|<box-center>]
                      |<box-vpos>'-'[<box-hpos>['-corner']?|<box-center>]]}
    rule margin-declaration { <margin-box> <declarations> }

    token page-size {:i [ a[3|4|5] | b[4|5] | letter | legal | ledger ] & <keyw> }
}

class CSS::Module::CSS3::PagedMedia::Actions
    is CSS::Module::CSS3::_Base::Actions 
    is CSS::Module::CSS3::PagedMedia::Spec::Actions
    does CSS::Module::CSS3::PagedMedia::Spec::Interface {

        use CSS::AST :CSSValue;

        method page-pseudo($/)    {
            if $<Ident> {
                $.warning('ignoring page pseudo', ~$<Ident>)
            }
            elsif ! $<keyw> { 
                $.warning("':' should be followed by one of: left right first")
            }
            else {
                make $.token( $<keyw>.ast, :type(CSS::AST::CSSSelector::PseudoClass))
            }
        }

        method page-declarations($/) { make $.token( $.declaration-list($/), :type(CSSValue::PropertyList)) }

        method box-center($/) { make $.token( 'center', :type(CSSValue::KeywordComponent)) }
        method margin-box($/) { make $.token( $/.lc, :type(CSSValue::AtKeywordComponent)) }

        method margin-declaration($/) {
            make $.token($.node($/), :type(CSS::AST::CSSObject::MarginRule));
        }

        method page-size($/) { make $<keyw>.ast }
}
