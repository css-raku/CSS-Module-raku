use v6;

# CSS3 Paged Media Module Extensions
# - reference: http://www.w3.org/TR/2006/WD-css3-page-20061010/
#
use CSS::Module::CSS3::PagedMedia::Gen::Interface;

grammar CSS::Module::CSS3::PagedMedia {
    use     CSS::Module::CSS3::_Base;
    also is CSS::Module::CSS3::_Base;

    use     CSS::Module::CSS3::PagedMedia::Gen::Grammar;
    also is CSS::Module::CSS3::PagedMedia::Gen::Grammar;

    also does CSS::Module::CSS3::PagedMedia::Gen::Interface;

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

    class Actions {

        use     CSS::Module::CSS3::_Base::Actions;
        also is CSS::Module::CSS3::_Base::Actions;

        use     CSS::Module::CSS3::PagedMedia::Gen::Actions;
        also is CSS::Module::CSS3::PagedMedia::Gen::Actions;

        also does CSS::Module::CSS3::PagedMedia::Gen::Interface;

        use CSS::Grammar::Defs :CSSValue;

        method page-pseudo($/)    {
            if $<Ident> {
                $.warning('ignoring page pseudo', ~$<Ident>)
            }
            elsif ! $<keyw> { 
                $.warning("':' should be followed by one of: left right first")
            }
            else {
                make $.build.token( $<keyw>.ast, :type(CSS::Grammar::Defs::CSSSelector::PseudoClass))
            }
        }

        method page-declarations($/) {
            my @decls = ($<declaration>>>.ast).grep: {.defined};
            make $.build.token(@decls, :type(CSSValue::PropertyList));
        }

        method box-center($/) { make $.build.token( 'center', :type(CSSValue::KeywordComponent)) }
        method margin-box($/) { make $.build.token( $/.lc, :type(CSSValue::AtKeywordComponent)) }

        method margin-declaration($/) {
            make $.build.at-rule($/);
        }
    }
}
