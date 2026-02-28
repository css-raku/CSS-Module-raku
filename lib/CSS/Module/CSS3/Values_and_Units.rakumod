use v6;

# This class implements CSS3 Values and Units Module Level 3
# - reference: https://www.w3.org/TR/2024/CRD-css-values-3-20240322/
#
unit grammar CSS::Module::CSS3::Values_and_Units;
use CSS::Grammar::CSS3;
use CSS::Specification::Base::Grammar;

use CSS::Module::CSS3::Values_and_Units::Gen::External;
use CSS::Module::CSS3::Values_and_Units::Gen::Grammar;

also is CSS::Module::CSS3::Values_and_Units::Gen::Grammar;

also is CSS::Specification::Base::Grammar;
also is CSS::Grammar::CSS3;
also does CSS::Module::CSS3::Values_and_Units::Gen::External;

token proforma:sym<inherit> {:i inherit}
token proforma:sym<initial> {:i initial}

# base colors - may be extended by css::module::css3::colors
rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

# -- Units -- #

# add viewport as a new type of length-units
token length-units:sym<viewport> {:i vw|vh|vmin|vmax}

# override/extend css::grammar <rel-font-units> & <angle-units>
token rel-font-units   {:i[em|ex|ch|rem]}
token angle-units      {:i[deg|rad|turn]}
# override/extend css::language::css3::_base <resolution-units>
token resolution-units {:i dp[i|cm|px]}

# extend module grammars
rule length:sym<calc>     {<calc>}
rule frequency:sym<calc>  {<calc>}
rule angle:sym<calc>      {<calc>}
rule time:sym<calc>       {<calc>}
rule resolution:sym<calc> {<calc>}

class Actions {
    use CSS::Specification::Base::Actions;
    use CSS::Grammar::Actions;
    use CSS::Specification::Base::Actions;
    also is CSS::Specification::Base::Actions;
    also is CSS::Grammar::Actions;
    also does CSS::Module::CSS3::Values_and_Units::Gen::External;
    use Method::Also;

    use CSS::Grammar::Defs :CSSValue, :CSSUnits;
    constant %Dim = CSSUnits.enums.Hash;
    role Cast {
        has $.cast is rw;
    }
    method build {
        use CSS::Grammar::AST;
        my class builder is CSS::Grammar::AST {
            method proforma { ['inherit', 'initial'] }
        }
    }

    method length-units:sym<viewport>($/) { make $/.lc }
    method rel-font-units($/)             { make $/.lc }
    method angle-units($/)                { make $/.lc }
    method resolution-units($/)           { make $/.lc }

    method calc($/) { $.make-func( 'calc', $/, :arg-type<expr>) }

    # calc() function
    multi sub type( % ( :%func!  ( :ident($)! where 'calc', :@expr! )) ) {
        type |@expr;
    }

    # trivial sub-expression
    multi sub type( % ( :@expr! ) ) {
        type |@expr;
    }

    # parenthesized sub-expression
    multi sub type( % ( :op($)! where '(' ), %expr, % ( :op($)! where ')' ) ) {
        type %expr;
    }

    subset Additive of Str where '+'|'-';
    subset Multiplicative of Str where '*'|'/';
    subset Dim of Str where %Dim{$_};

    # failure propagation
    multi resolved-type('fail', $, $) { 'fail' }
    multi resolved-type($, $, 'fail') { 'fail' }
    # zero
    multi resolved-type($, '/', 0)       { 'fail' }
    multi resolved-type(0, '/', $b)      { 0 }
    multi resolved-type($, '*', 0)       { 0 }
    multi resolved-type(0, '*', $)       { 0 }
    multi resolved-type($a, Additive, 0) { $a }
    multi resolved-type(0, Additive, $b) { $b }
    # numeric literal values
    multi resolved-type(Numeric:D $a, $_, Numeric:D $b)        {
        when '+' { $a + $b }
        when '-' { $a - $b }
        when '*' { $a * $b }
        when '/' { $a / $b }
    }
    multi resolved-type(Numeric, $, Numeric)   { Numeric }
    # percentages
    multi resolved-type('percent', '*', 'percent')          { 'fail' }
    multi resolved-type('percent', '/', 'percent')          { Numeric }
    multi resolved-type('percent', Additive, 'percent')     { 'percent' }
    multi resolved-type('percent', Multiplicative, Numeric) { 'percent' }
    multi resolved-type(Numeric, Multiplicative, 'percent') { Numeric }
    # dim/percent
    multi resolved-type(Dim $a, Additive, 'percent')        { $a }
    multi resolved-type('percent', Additive, Dim $b)        { $b }
    # dim/numeric
    multi resolved-type(Dim $a, Additive, Dim $b)           { $a eq $b ?? $a !! 'fail' }
    multi resolved-type(Dim $, '*', Dim $)                  { 'fail' }
    multi resolved-type(Dim $a, '/', Dim $b)                { $a eq $b ?? Numeric !! 'fail' }
    multi resolved-type(Dim $a, Multiplicative, Numeric)    { $a }
    multi resolved-type(Numeric, '*', Dim $b)               { $b }
    # fallback
    multi resolved-type($, $, $)       { 'fail' }
    
    # binary left associative arithmetic operation
    multi sub type( %lhs, % ( :$op! ),  *@rhs (%, *@) ) {
        my $t1 := type(%lhs);
        my $t2 := type(|@rhs);
        resolved-type($t1, $op, $t2);
    }

    # numeric constant
    multi sub type( % ( Numeric:D :$num! ) ) {
        $num;
    }
    multi sub type( % ( :percent($)! ) ) {
        'percent';
    }

    # dimensioned quantity
    multi sub type( %tk ) {
        %Dim{%tk.keys[0]} // 'fail';
    }

    multi sub type( *@expr ) {
        'fail';
    }

    method !make-expr($/, $type = 'expr') {
        my @expr = $.build.list($/);

        unless $type eq 'expr' {
            given type(|@expr) {
                when $type | 0 | 'percent' { }
                when 'fail' {
                    $.warning: "unable to evaluate expression", $/.Str;
                    return;
                }
                default {
                    $.warning: "expected type of $type, got {$_ ~~ Numeric ?? 'number' !! $_}", $/.Str;
                    return;
                }
            }
        }

        make $.build.token(@expr, :$type);
    }

    method calc-sum($/) is also<calc-product calc-number-sum calc-number-product calc-number-value calc-value> {
        self!make-expr: $/;
    }
    method length:sym<calc>($/)     { self!make-expr: $/, CSSValue::LengthComponent; }
    method frequency:sym<calc>($/)  { self!make-expr: $/, CSSValue::FrequencyComponent; }
    method angle:sym<calc>($/)      { self!make-expr: $/, CSSValue::AngleComponent; }
    method time:sym<calc>($/)       { self!make-expr: $/, CSSValue::TimeComponent; }
    method resolution:sym<calc>($/) { self!make-expr: $/, CSSValue::ResolutionComponent; }
}

