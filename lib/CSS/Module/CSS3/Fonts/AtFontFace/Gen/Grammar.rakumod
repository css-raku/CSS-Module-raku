use v6;
#  -- DO NOT EDIT --
# generated by: make-modules.raku;

unit grammar CSS::Module::CSS3::Fonts::AtFontFace::Gen::Grammar;


#| font-family: <family-name>
rule decl:sym<font-family> {:i (font\-family) ':' <val( rx{ <expr=.expr-font-family> }, &?ROUTINE.WHY)> }
rule expr-font-family {:i <family-name> }

#| family-name: <identifiers> | <string>
rule family-name {:i [ <identifiers> || <string> ] }

#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> {:i (font\-feature\-settings) ':' <val( rx{ <expr=.expr-font-feature-settings> }, &?ROUTINE.WHY)> }
rule expr-font-feature-settings {:i [ normal & <keyw> || <feature-tag-value>+% <op(',')> ] }

#| font-stretch: normal | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule decl:sym<font-stretch> {:i (font\-stretch) ':' <val( rx{ <expr=.expr-font-stretch> }, &?ROUTINE.WHY)> }
rule expr-font-stretch {:i [ normal | ultra\-condensed | extra\-condensed | condensed | semi\-condensed | semi\-expanded | expanded | extra\-expanded | ultra\-expanded ] & <keyw> }

#| font-style: normal | italic | oblique
rule decl:sym<font-style> {:i (font\-style) ':' <val( rx{ <expr=.expr-font-style> }, &?ROUTINE.WHY)> }
rule expr-font-style {:i [ normal | italic | oblique ] & <keyw> }

#| font-variant: normal | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> || stylistic(<feature-value-name>) || historical-forms || styleset(<feature-value-name>#) || character-variant(<feature-value-name>#) || swash(<feature-value-name>) || ornaments(<feature-value-name>) || annotation(<feature-value-name>) || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero || <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant> {:i (font\-variant) ':' <val( rx{ <expr=.expr-font-variant> }, &?ROUTINE.WHY)> }
rule expr-font-variant {:i :my @*SEEN; [ normal & <keyw> || [ [ <common-lig-values> <!seen(0)> | <discretionary-lig-values> <!seen(1)> | <historical-lig-values> <!seen(2)> | <contextual-alt-values> <!seen(3)> | <stylistic> <!seen(4)> | historical\-forms & <keyw> <!seen(5)> | <styleset> <!seen(6)> | <character-variant> <!seen(7)> | <swash> <!seen(8)> | <ornaments> <!seen(9)> | <annotation> <!seen(10)> | [ [ small\-caps | all\-small\-caps | petite\-caps | all\-petite\-caps | unicase | titling\-caps ] & <keyw> ] <!seen(11)> | <numeric-figure-values> <!seen(12)> | <numeric-spacing-values> <!seen(13)> | <numeric-fraction-values> <!seen(14)> | ordinal & <keyw> <!seen(15)> | slashed\-zero & <keyw> <!seen(16)> | <east-asian-variant-values> <!seen(17)> | <east-asian-width-values> <!seen(18)> | ruby & <keyw> <!seen(19)> ]+ ] ] }

#| font-weight: normal | bold | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900
rule decl:sym<font-weight> {:i (font\-weight) ':' <val( rx{ <expr=.expr-font-weight> }, &?ROUTINE.WHY)> }
rule expr-font-weight {:i [ [ normal | bold ] & <keyw> || [ 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 ] & <number> ] }

#| src: <font-src-expr>#
rule decl:sym<src> {:i (src) ':' <val( rx{ <expr=.expr-src> }, &?ROUTINE.WHY)> }
rule expr-src {:i <font-src-expr>+% <op(',')> }

#| font-src-expr: [<uri>|local(<string>)] [format(<string>#)]? | <font-face-name>
rule font-src-expr {:i [ [ [ <uri> || <local> ] ] [ <format> ]? || <font-face-name> ] }

#| font-face-name: <identifiers> | <string>
rule font-face-name {:i [ <identifiers> || <string> ] }

#| unicode-range: <urange>#
rule decl:sym<unicode-range> {:i (unicode\-range) ':' <val( rx{ <expr=.expr-unicode-range> }, &?ROUTINE.WHY)> }
rule expr-unicode-range {:i <urange>+% <op(',')> }
