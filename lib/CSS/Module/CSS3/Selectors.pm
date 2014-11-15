use v6;

# CSS3 Selectors Module
# specification: http://www.w3.org/TR/2011/REC-css3-selectors-20110929/
# Notes:
# -- have relaxed negation rule to take a list of arguments - in common use
#    and supported  by major browsers.

class CSS::Module::CSS3::Selectors::Actions {...}

use CSS::Module::CSS3::_Base;

grammar CSS::Module::CSS3::Selectors:ver<20110929.000>
    is CSS::Module::CSS3::_Base {

    # extensions:
    # ----------
    # inherited combinators: '+' (adjacent), '>' (child)
    rule combinator:sym<sibling> { '~' }

    # allow '::' element selectors
    rule pseudo:sym<::element> {'::'<element=.Ident>}
 
    rule no-namespace {<?>}
    rule wildcard {'*'}
    rule namespace-prefix {[<Ident>|<wildcard>|<no-namespace>]'|'}

    # use <qname> in preference to <type_selector>
    # - see http://www.w3.org/TR/2008/CR-css3-namespace-20080523/#css-qnames
    rule qname      {<namespace-prefix>? <element-name>}
    rule universal  {<namespace-prefix>? <wildcard>}
    rule simple-selector { [<qname><!before '|'>|<universal>][<id>|<class>|<attrib>|<pseudo>]*
                               | [<id>|<class>|<attrib>|<pseudo>]+ }

    rule type-selector {<namespace-prefix>? <element-name>}
    
    rule attrib        {'[' <Ident> [ <attribute-selector> [<Ident>|<string>] ]? ']'}

    rule term:sym<unicode-range> {:i'U+'<unicode-range>}

    # inherited from base: = ~= |=
    rule attribute-selector:sym<prefix>    {'^='}
    rule attribute-selector:sym<suffix>    {'$='}
    rule attribute-selector:sym<substring> {'*='}

    # to compute a.n + b
    proto rule structural-args {*}
    rule structural-args:sym<odd>   {:i odd }
    rule structural-args:sym<even>  {:i even }
    rule structural-args:sym<expr> {
        [  $<a-sign>=< + - >?<a=.uint>?$<n>=<[Nn]> [$<b-sign>=< + - > <b=.uint>]?
        || $<b-sign>=< + - >?<b=.uint>
        ]
    }

    rule structural-selector {:i $<Ident>=[[nth|first|last|nth\-last]\-[child|of\-type]]'(' [ <args=.structural-args> || <any-args> ] ')'}
    rule pseudo-function:sym<structural-selector> {<structural-selector>}
    rule negation-args {[<type-selector> | <universal> | <id> | <class> | <attrib> | [$<nested>=<?before [:i':not(']> || <?>] <pseudo> | <any-arg> ]+}
    rule pseudo-function:sym<negation>  {:i'not(' [ <negation-args> || <any-args> ] ')'}

}

class CSS::Module::CSS3::Selectors::Actions
    is CSS::Module::CSS3::_Base::Actions {

    use CSS::Grammar::AST :CSSValue;

    method combinator:sym<sibling>($/)  { make $.token('~') }

    method pseudo:sym<::element>($/) { make $.node($/) }

    method no-namespace($/)     { make $.token('', :type(CSSValue::ElementNameComponent)) }
    method namespace-prefix($/) { make $.token( $.node($/), :type(CSSValue::NamespacePrefixComponent)) }
    method wildcard($/)         { make $.token(~$/, :type(CSSValue::ElementNameComponent)) }
    method type-selector($/)    { make $.node($/) }
    method qname($/)            { make $.token( $.node($/), :type(CSSValue::QnameComponent)) }
    method universal($/)        { make $.token( $.node($/), :type(CSSValue::QnameComponent)) }

    method attribute-selector:sym<prefix>($/)    { make ~$/ }
    method attribute-selector:sym<suffix>($/)    { make ~$/ }
    method attribute-selector:sym<substring>($/) { make ~$/ }

    method term:sym<unicode-range>($/) { make $.node($/) }
    method structural-selector($/)  {
        my $ident = $<Ident>.lc;
        return $.warning('usage '~$ident~'(an+b) e.g. "4" "3n+1"')
            if $<any-args>;

        my %node = %( $.node($/) );
        %node<ident> = $ident;

        make $.token( %node, :type(CSS::Grammar::AST::CSSSelector::PseudoFunction));
    }
    method pseudo-function:sym<structural-selector>($/)  { make $<structural-selector>.ast }

    method structural-args:sym<odd>($/)     { make {a => 2, b=> 1} }
    method structural-args:sym<even>($/)    { make {a => 2, b=> 0} }
    method structural-args:sym<expr>($/)    {

        my %node = %( $.node($/) );

        if $<a-sign> {
            %node<a> //= 1;
            %node<a> = -%node<a> if ~$<a-sign> eq '-';
        }

        %node<b> //= 0;
        if $<b-sign> {
            %node<b> = -%node<b> if ~$<b-sign> eq '-';
        }

        make %node;
    }
    method nth-functor($/)                   { make (~$/).lc  }

    method negation-args($/) {
        return $.warning('bad :not() argument', ~$<any-arg>)
            if $<any-arg>;
        return $.warning('illegal nested negation', ~$<pseudo>)
            if $<nested>;
        make $.list($/);
    }

    method pseudo-function:sym<negation>($/) {
        return $.warning('missing/incorrect arguments to :not()', ~$<any-args>)
            if $<any-args>;
        return unless $<negation-args>.ast;
        make $.token( {ident => 'not', args => $<negation-args>.ast}, :type(CSS::Grammar::AST::CSSSelector::PseudoFunction));
    }
}

