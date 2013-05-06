use v6;

# CSS3 Selectors Module
# specification: http://www.w3.org/TR/2001/CR-css3-selectors-20090929/
# Notes:
# -- have relaxed negation rule to take a list of arguments - in common use
#    and supported  by major browsers.

grammar CSS::Language::CSS3::Selectors::Syntax {
    # extensions:
    # ----------
    # inherited combinators: '+' (adjacent), '>' (child)
    rule combinator:sym<sibling> { '~' }

    # allow '::' element selectors
    rule pseudo:sym<::element> {'::'<element=.ident>}
 
    rule namespace-prefix {[<ident>|<wildcard>]?'|'}
    rule wildcard {'*'}

    rule simple-selector { <namespace-prefix>? [<element-name>|<element-name=.wildcard>][<id>|<class>|<attrib>|<pseudo>]*
                          | [<id>|<class>|<attrib>|<pseudo>]+ }

    rule type-selector {<namespace-prefix>? <element-name>}
    
    rule attrib        {'[' <ident> [ <attribute-selector> [<ident>|<string>] ]? ']'}

    rule universal      {<namespace-prefix>? <element-name=.wildcard>}

    rule term:sym<unicode-range> {'U+'<unicode-range>}

    # inherited from base: = ~= |=
    rule attribute-selector:sym<prefix>    {'^='}
    rule attribute-selector:sym<suffix>    {'$='}
    rule attribute-selector:sym<substring> {'*='}

    token nth-functor {:i[nth|first|last|'nth-last']'-'['child'|'of-type']}
    # to compute a.n + b
    proto token nth-args {*}
    token nth-args:sym<odd>   {:i 'odd' }
    token nth-args:sym<even>  {:i 'even' }
    token nth-args:sym<expr> {
        <ws>?
        [$<a-sign>=[\+|\-]? <a=.posint>? $<n>=<[Nn]> <ws>? [$<b-sign>=[\+|\-] <ws>? <b=.posint>]?
        |<b=.posint>
        ]<ws>?
    }

    rule pseudo-function:sym<nth-selector> {<ident=.nth-functor>'(' [<args=.nth-args> || <any-args> ] ')'} 
    rule negation_args {[<type-selector> | <universal> | <id> | <class> | <attrib> | $<nested>=[<?before [:i':not(']><pseudo>] | <pseudo> | <any-arg> ]+}
    rule pseudo-function:sym<negation>  {:i'not(' [ <negation_args> || <any-args> ] ')'}

}

grammar CSS::Language::CSS3::Selectors:ver<20090929.000>
    is  CSS::Language::CSS3::Selectors::Syntax {
}

class CSS::Language::CSS3::Selectors::Actions {

    method combinator:sym<sibling>($/)  { make $.token('~') }

    method pseudo:sym<::element>($/) { make $.node($/) }

    method namespace-prefix($/) { make $.node($/) }
    method wildcard($/)         { make $/.Str }
    method type-selector($/)    { make $.node($/) }
    method universal($/)        { make $.node($/) }

    method attribute-selector:sym<prefix>($/)    { make $/.Str }
    method attribute-selector:sym<suffix>($/)    { make $/.Str }
    method attribute-selector:sym<substring>($/) { make $/.Str }

    method term:sym<unicode-range>($/) { make $.node($/) }
    method pseudo-function:sym<nth-selector>($/)  {
        return $.warning('usage '~$<ident>~'(an+b) e.g "4" "3n+1"')
            if $<any-args>;
        make $.node($/)
    }

    method nth-args:sym<odd>($/)     { make {a => 2, b=> 1} }
    method nth-args:sym<even>($/)    { make {a => 2 } }
    method nth-args:sym<expr>($/)    {

        my %node = $.node($/);

        if $<a-sign> {
            %node<a> //= 1;
            %node<a> = -%node<a> if $<a-sign>.Str eq '-';
        }

        if $<b-sign> {
            %node<b> = -%node<b> if $<b-sign>.Str eq '-';
        }

        make %node;
    }
    method nth-functor($/)                   { make $/.Str.lc  }
    method pseudo:sym<nth-child>($/)         { make $.node($/) }

    method negation_args($/) {
        return $.warning('bad :not() argument', $<any-arg>.Str)
            if $<any-arg>;
        return $.warning('illegal nested negation', $<nested>.Str)
            if $<nested>;
        make $.list($/);
    }

    method pseudo-function:sym<negation>($/) {
        return $.warning('missing/incorrect arguments to :not()', $<any-args>.Str)
            if $<any-args>;
        return unless $<negation_args>.ast;
        make {ident => 'not', args => $<negation_args>.ast}
    }
}

