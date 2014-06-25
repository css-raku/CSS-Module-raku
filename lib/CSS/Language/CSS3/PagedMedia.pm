use v6;

class CSS::Language::CSS3::PagedMedia::Actions {...}
use CSS::Language::CSS3::_Base;
# CSS3 Paged Media Module Extensions
# - reference: http://www.w3.org/TR/2006/WD-css3-page-20061010/
#

# BUILD.pl targets
use CSS::Language::CSS3::PagedMedia::Spec::Interface;
use CSS::Language::CSS3::PagedMedia::Spec::Grammar;
use CSS::Language::CSS3::PagedMedia::Spec::Actions;

grammar CSS::Language::CSS3::PagedMedia:ver<20061010.000>
    is CSS::Language::CSS3::PagedMedia::Spec::Grammar
    is CSS::Language::CSS3::_Base
    does CSS::Language::CSS3::PagedMedia::Spec::Interface {

    proto rule page-pseudo {*}
    rule page-pseudo:sym<left>    {:i'left'}
    rule page-pseudo:sym<right>   {:i'right'}
    rule page-pseudo:sym<first>   {:i'first'}
    rule page-pseudo:sym<other>   {<ident>}
    rule page-pseudo:sym<missing> {''}

    # @page declarations
    rule at-rule:sym<page>  {(:i'page') [\:<page=.page-pseudo>]? <declarations=.page-declarations> }

    rule page-declarations {
        '{' [ '@'<declaration=.margin-declaration> | <declaration> || <dropped-decl> ]* <.end-block>
    }

    token box-hpos   {:i[left|right]}
    token box-vpos   {:i[top|bottom]}
    token box-center {:i[cent[er|re]]}
    token margin-box{:i[<box-hpos>'-'[<box-vpos>['-corner']?|<box-center>]
                      |<box-vpos>'-'[<box-hpos>['-corner']?|<box-center>]]}
    rule margin-declaration { <margin-box> <declarations> }

    token page-size {:i [ a[3|4|5] | b[4|5] | letter | legal | ledger ] & <keyw> }
}

class CSS::Language::CSS3::PagedMedia::Actions
    is CSS::Language::CSS3::PagedMedia::Spec::Actions
    is CSS::Language::CSS3::_Base::Actions 
    does CSS::Language::CSS3::PagedMedia::Spec::Interface {

        method page-pseudo:sym<left>($/)  {make 'left'}
        method page-pseudo:sym<right>($/) {make 'right'}
        method page-pseudo:sym<first>($/) {make 'first'}
        method page-pseudo:sym<other>($/) {$.warning('ignoring page pseudo', ~$/)}
        method page-pseudo:sym<missing>($/) {$.warning("':' should be followed by one of: left right first")}

        method page-declarations($/) { make $.declaration-list($/) }

        method box-hpos($/)   { make (~$/).lc }
        method box-vpos($/)   { make (~$/).lc }
        method box-center($/) { make 'center' }
        method margin-box($/) { make $.node($/) }

        method margin-declaration($/) {
            my %ast = $.node($/);
            %ast<property> = '@' ~ (~$<margin-box>).lc;
            make %ast;
        }

        method page-size($/) { make $.token($<keyw>.ast) }
}
