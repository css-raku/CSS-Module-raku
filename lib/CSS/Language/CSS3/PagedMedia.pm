use v6;

class CSS::Language::CSS3::PagedMedia::Actions {...}

use CSS::Language::CSS3::_Base;
# CSS3 Paged Media Module Extensions
# - reference: http://www.w3.org/TR/2006/WD-css3-page-20061010/
#

grammar CSS::Language::CSS3::PagedMedia::Syntax {

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

}

grammar CSS::Language::CSS3::PagedMedia:ver<20061010.000>
    is CSS::Language::CSS3::PagedMedia::Syntax
    is CSS::Language::CSS3::_Base {

        # ---- Properties ----#

        # override for css21 size rule
        # - size: <length>{1,2} | auto | [ <page-size> || [ portrait | landscape] ]
        token page-size {:i [ a[3|4|5] | b[4|5] | letter | legal | ledger ] & <keyw> }
        rule decl:sym<size> {:i (size) ':' [ <length> ** 1..2 | auto & <keyw>
                                             | [ <page-size> | [ portrait | landscape ] & <keyw> ]**1..2
                                             | <misc> ]}


}

class CSS::Language::CSS3::PagedMedia::Actions
    is CSS::Language::CSS3::_Base::Actions {

    method page-pseudo:sym<left>($/)  {make 'left'}
    method page-pseudo:sym<right>($/) {make 'right'}
    method page-pseudo:sym<first>($/) {make 'first'}
    method page-pseudo:sym<other>($/) {$.warning('ignoring page pseudo', $/.Str)}
    method page-pseudo:sym<missing>($/) {$.warning("':' should be followed by one of: left right first")}

    method page-declarations($/) { make $.declaration-list($/) }

    method box-hpos($/)   { make $/.Str.lc }
    method box-vpos($/)   { make $/.Str.lc }
    method box-center($/) { make 'center' }
    method margin-box($/) { make $.node($/) }

    method margin-declaration($/) {
        my %ast = $.node($/);
        %ast<property> = '@' ~ $<margin-box>.Str.lc;
        make %ast;
    }

    method page-size($/) { make $.token($<keyw>.ast) }
    method decl:sym<size>($/) {
        $._make_decl($/, '<length>{1,2} | auto | [ <page-size> || [ portrait | landscape] ]')
    }
}
