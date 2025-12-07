use v6;

# This class implements CSS3 Values and Units Module Level 3
# - reference: https://www.w3.org/TR/2024/CRD-css-values-3-20240322/
#
grammar CSS::Module::CSS3::Values_and_Units {
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
    token angle-units      {:i[deg|rad|rad|turn]}
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

        use CSS::Grammar::Defs :CSSValue;

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

        method !make-expr($/, $type) {
            make $.build.token($.build.list($/), :$type);
        }

        method calc-sum($/) is also<calc-product calc-number-sum calc-number-product calc-number-value calc-value> {
            self!make-expr: $/, 'expr';
        }
        method length:sym<calc>($/)     { self!make-expr: $/, CSSValue::LengthComponent; }
        method frequency:sym<calc>($/)  { self!make-expr: $/, CSSValue::FrequencyComponent; }
        method angle:sym<calc>($/)      { self!make-expr: $/, CSSValue::AngleComponent; }
        method time:sym<calc>($/)       { self!make-expr: $/, CSSValue::TimeComponent; }
        method resolution:sym<calc>($/) { self!make-expr: $/, CSSValue::ResolutionComponent; }

    }
}

