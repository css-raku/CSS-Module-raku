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

    proto rule page-pseudo {*}
    rule page-pseudo:sym<keyw>    {:i[left|right|first] && <keyw> || <Ident> }
    rule page-pseudo:sym<missing> {''}

    # @page declarations
    rule at-rule:sym<page>  {(:i'page') [\:<page=.page-pseudo>]? <declarations=.page-declarations> }

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

        use CSS::Grammar::AST :CSSValue;

        method page-pseudo:sym<keyw>($/)    {
            return $.warning('ignoring page pseudo', ~$<Ident>)
                if $<Ident>;
            make $<keyw>.ast
        }
        method page-pseudo:sym<missing>($/) {$.warning("':' should be followed by one of: left right first")}

        method page-declarations($/) { make $.declaration-list($/) }

        method box-center($/) { make $.token( 'center', :type(CSSValue::KeywordComponent)) }
        method margin-box($/) { make $.token( $/.lc, :type(CSSValue::KeywordComponent)) }

        method margin-declaration($/) {
            make $.token({expr => $.node($/),
                          ident => '@' ~ $<margin-box>.lc}, :type(CSSValue::Property));
        }

        method page-size($/) { make $<keyw>.ast }
}
