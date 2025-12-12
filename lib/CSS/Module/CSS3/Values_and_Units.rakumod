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

    subset AddSub of Str where '+'|'-';
    subset MulDiv of Str where '*'|'/';
    subset Dim of Str where %Dim{$_};

    # failure propagation
    multi arith('fail', $, $) { 'fail' }
    multi arith($, $, 'fail') { 'fail' }
    # zero
    multi arith($, '/', 0) { 'fail' }
    multi arith(0, '/', $b) { 0 }
    multi arith($, '*', 0)  { 0 }
    multi arith(0, '*', $)  { 0 }
    multi arith($a, AddSub, 0) { $a }
    multi arith(0, AddSub, $b) { $b }
    # numeric/percent
    multi arith(Numeric $a, '+', Numeric $b) { $a + $b }
    multi arith(Numeric $a, '-', Numeric $b) { $a - $b }
    multi arith('percent', AddSub, 'percent') { 'percent' }
    multi arith('percent', AddSub, Dim $b) { $b }
    multi arith('percent', MulDiv, Numeric) { 'percent' }
    multi arith(Numeric, MulDiv, 'percent') { Numeric }
    # dimensions
    multi arith(Dim $a, AddSub, 'percent') { $a }
    multi arith(Dim $a, MulDiv, Numeric) { $a }
    multi arith(Numeric, '*', Dim $b) { $b }
    multi arith($a, '/', Dim $b) { $a eq $b ?? Numeric !! 'fail' }
    multi arith(Dim $a, '*', Dim $b) { 'fail' }
    multi arith(Dim $a, AddSub, Dim $b) { $a eq $b ?? $a !! 'fail' }
    
    # binary left associative arithmetic operation
    multi sub type( %lhs, % ( :$op! ),  *@rhs (%, *@) ) {
        my $t1 := type(%lhs);
        my $t2 := type(|@rhs);
        arith($t1, $op, $t2);
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
        warn "Unhandled expression: {@expr.map(*.raku).join: "|"}";
        'fail';
    }

    method !make-expr($/, $expected-type?) {
        my @expr = $.build.list($/);

        if $expected-type {
            given type(|@expr) {
                when $expected-type | 0 | 'percent' { } # permitted
                when 'fail' {
                    $.warning: "Unable to evaluate calc() expression";
                }
                default {
                    $.warning: "Expected calc() expression of type $expected-type, got: $_";
                }
            }
        }

        my $type = $expected-type // 'expr';
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

