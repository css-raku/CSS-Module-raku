use CSS::Grammar::CSS3;

grammar CSS::Language::CSS3::Fonts::Variants {

    rule feature-value-name  {<identifier>}
    rule feature-value-list  {<feature-value-name> [',' <feature-value-name>]*}

        rule annotation               {:i 'annotation('        [<feature-value-name>  || <any-args>] ')'}
        rule character-variant        {:i 'character-variant(' [<feature-value-list>  || <any-args>] ')'}
        rule ornaments                {:i 'ornaments('         [<feature-value-name>  || <any-args>] ')'}
        rule stylistic                {:i 'stylistic('         [<feature-value-name>  || <any-args>] ')'}
        rule styleset                 {:i 'styleset('          [<feature-value-list>  || <any-args>] ')'}
        rule swash                    {:i 'swash('             [<feature-value-name>  || <any-args>] ')'}

        rule common-lig-values         {:i [ common\-ligatures | no\-common\-ligatures ] & <keyw> }
        rule discretionary-lig-values  {:i [ discretionary\-ligatures | no\-discretionary\-ligatures ] & <keyw> }
        rule historical-lig-values     {:i [ historical\-ligatures | no\-historical\-ligatures ] & <keyw> }
        rule contextual-alt-values     {:i [ contextual | no\-contextual ] & <keyw> }
        rule numeric-figure-values     {:i [ lining\-nums | oldstyle\-nums ] & <keyw> }
        rule numeric-spacing-values    {:i [ proportional\-nums | tabular\-nums ] & <keyw> }
        rule numeric-fraction-values   {:i [ diagonal\-fractions | stacked\-fractions ] & <keyw> }

        rule east-asian-variant-values {:i [ jis78 | jis83 | jis90 | jis04 | simplified | traditional ] & <keyw> }
        rule east-asian-width-values   {:i [ full\-width | proportional\-width ] & <keyw> }
}

# ----------------------------------------------------------------------

class CSS::Language::CSS3::Fonts::Variants::Actions {

    method feature-value-name($/) { make $<identifier>.ast }
    method feature-value-list($/) { make $.list($/) }

    method annotation($/) { make $.node($/) }
    method character-variant($/) { make $.node($/) }
    method ornaments($/) { make $.node($/) }
    method stylistic($/) { make $.node($/) }
    method styleset($/) { make $.node($/) }
    method swash($/) { make $.node($/) }

    method common-lig-values($/) { make $<keyw>.ast }
    method discretionary-lig-values($/) { make $<keyw>.ast }
    method historical-lig-values($/) { make $<keyw>.ast }
    method contextul-alt-values($/) { make $<keyw>.ast }
    method numeric-figure-values($/) { make $<keyw>.ast }
    method numeric-spacing-values($/) { make $<keyw>.ast }
    method numeric-fraction-values($/) { make $<keyw>.ast }
    method east-asian-variant-values($/) { make $<keyw>.ast }
    method  east-asian-width-values($/) { make $<keyw>.ast }

}
