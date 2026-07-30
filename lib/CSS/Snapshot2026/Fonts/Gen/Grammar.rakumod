unit grammar CSS::Snapshot2026::Fonts::Gen::Grammar;
#| font: [ [ <'font-style'> || <font-variant-css2> || <'font-weight'> || <'font-stretch'> ]? <'font-size'> [ / <'line-height'> ]? <'font-family'># ] | <system-font-family-name>
rule decl:sym<font> { :i (font) ":" <val(/<css-val-font> /, &?ROUTINE.WHY)>}
rule css-val-font { :i [[[<css-val-font-style> :my $*A;<!{
    $*A++
}>|| <font-variant-css2> :my $*B;<!{
    $*B++
}>|| <css-val-font-weight> :my $*C;<!{
    $*C++
}>|| <css-val-font-stretch> :my $*D;<!{
    $*D++
}>]+] ? <css-val-font-size> [<op("/")> <css-val-line-height> ] ? <css-val-font-family> +% <op(",")>? ] || <system-font-family-name>  }
#| <font-variant-css2> = normal | small-caps
rule font-variant-css2 { :i [normal | "small-caps" ]& <keyw>  }
#| font-stretch: <font-width-css3>
rule decl:sym<font-stretch> { :i ("font-stretch") ":" <val(/<css-val-font-stretch> /, &?ROUTINE.WHY)>}
rule css-val-font-stretch { :i <font-width-css3> }
#| <font-width-css3> = normal | ultra-condensed | extra-condensed | condensed |    semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule font-width-css3 { :i [normal | "ultra-condensed" | "extra-condensed" | condensed | "semi-condensed" | "semi-expanded" | expanded | "extra-expanded" | "ultra-expanded" ]& <keyw>  }
#| font-family: [ <generic-font-family> | <font-family-name> ]#
rule decl:sym<font-family> { :i ("font-family") ":" <val(/<css-val-font-family> /, &?ROUTINE.WHY)>}
rule css-val-font-family { :i [<generic-font-family> || <font-family-name> ] +% <op(",")>? }
#| <system-font-family-name> = caption | icon | menu | message-box | small-caption | status-bar
rule system-font-family-name { :i [caption | icon | menu | "message-box" | "small-caption" | "status-bar" ]& <keyw>  }
#| <generic-font-family> = <generic-font-script-specific>| <generic-font-complete> | <generic-font-incomplete>
rule generic-font-family { :i <generic-font-script-specific> || <generic-font-complete> || <generic-font-incomplete>  }
#| <generic-font-script-specific> = <generic()>
rule generic-font-script-specific { :i <generic> }
#| generic([fangsong | kai | khmer-mul | nastaliq])
rule generic { :i "generic(" [[[fangsong | kai | "khmer-mul" | nastaliq ]& <keyw> ] || <usage(&?ROUTINE.WHY)> ] ")" }
#| <generic-font-complete> = serif | sans-serif | system-ui | cursive | fantasy | math | monospace
rule generic-font-complete { :i [serif | "sans-serif" | "system-ui" | cursive | fantasy | math | monospace ]& <keyw>  }
#| <generic-font-incomplete> = ui-serif | ui-sans-serif | ui-monospace | ui-rounded
rule generic-font-incomplete { :i ["ui-serif" | "ui-sans-serif" | "ui-monospace" | "ui-rounded" ]& <keyw>  }
#| font-feature-settings: normal | <feature-tag-value>#
rule decl:sym<font-feature-settings> { :i ("font-feature-settings") ":" <val(/<css-val-font-feature-settings> /, &?ROUTINE.WHY)>}
rule css-val-font-feature-settings { :i normal & <keyw> || <feature-tag-value> +% <op(",")>?  }
#| font-kerning: auto | normal | none
rule decl:sym<font-kerning> { :i ("font-kerning") ":" <val(/<css-val-font-kerning> /, &?ROUTINE.WHY)>}
rule css-val-font-kerning { :i [auto | normal | none ]& <keyw>  }
#| font-language-override: normal | <string>
rule decl:sym<font-language-override> { :i ("font-language-override") ":" <val(/<css-val-font-language-override> /, &?ROUTINE.WHY)>}
rule css-val-font-language-override { :i normal & <keyw> || <string>  }
#| font-optical-sizing: auto | none
rule decl:sym<font-optical-sizing> { :i ("font-optical-sizing") ":" <val(/<css-val-font-optical-sizing> /, &?ROUTINE.WHY)>}
rule css-val-font-optical-sizing { :i [auto | none ]& <keyw>  }
#| font-palette: normal | light | dark | <palette-identifier> | <palette-mix()>
rule decl:sym<font-palette> { :i ("font-palette") ":" <val(/<css-val-font-palette> /, &?ROUTINE.WHY)>}
rule css-val-font-palette { :i [normal | light | dark ]& <keyw>  || <palette-identifier> || <palette-mix>  }
#| <palette-identifier> = <dashed-ident>
rule palette-identifier { :i <dashed-ident> }
#| <dashed-ident> = <custom-ident>
rule dashed-ident { :i <custom-ident> }
#| palette-mix(<color-interpolation-method> , [ [normal | light | dark | <palette-identifier> | <palette-mix()> ] && <percentage [0,100]>? ]#{2})
rule palette-mix { :i "palette-mix(" [<color-interpolation-method> "," [[[[normal | light | dark ]& <keyw>  || <palette-identifier> || <palette-mix> ] :my $*A;<!{
    $*A++
}>|| <percentage> ? :my $*B;<!{
    $*B++
}>]** 2] ** 2% ","?  || <usage(&?ROUTINE.WHY)> ] ")" }
#| font-size: <absolute-size> | <relative-size> | <length-percentage [0,∞]> | math
rule decl:sym<font-size> { :i ("font-size") ":" <val(/<css-val-font-size> /, &?ROUTINE.WHY)>}
rule css-val-font-size { :i <absolute-size> || <relative-size> || <length-percentage> || math & <keyw>  }
#| <absolute-size> = [ xx-small | x-small | small | medium | large | x-large | xx-large | xxx-large ]
rule absolute-size { :i [["xx-small" | "x-small" | small | medium | large | "x-large" | "xx-large" | "xxx-large" ]& <keyw> ] }
#| <relative-size> = [ larger | smaller ]
rule relative-size { :i [[larger | smaller ]& <keyw> ] }
#| font-size-adjust: none | <number [0,∞]>
rule decl:sym<font-size-adjust> { :i ("font-size-adjust") ":" <val(/<css-val-font-size-adjust> /, &?ROUTINE.WHY)>}
rule css-val-font-size-adjust { :i none & <keyw> || <number>  }
#| font-style: normal | italic | left | right | oblique <angle [-90deg,90deg]>?
rule decl:sym<font-style> { :i ("font-style") ":" <val(/<css-val-font-style> /, &?ROUTINE.WHY)>}
rule css-val-font-style { :i [normal | italic | left | right | oblique ]& <keyw>  <angle> ?  }
#| font-synthesis: none | [ weight || style || small-caps || position]
rule decl:sym<font-synthesis> { :i ("font-synthesis") ":" <val(/<css-val-font-synthesis> /, &?ROUTINE.WHY)>}
rule css-val-font-synthesis { :i none & <keyw> || [[weight & <keyw> :my $*A;<!{
    $*A++
}>|| style & <keyw> :my $*B;<!{
    $*B++
}>|| "small-caps" & <keyw> :my $*C;<!{
    $*C++
}>|| position & <keyw> :my $*D;<!{
    $*D++
}>]+]  }
#| font-synthesis-position: auto | none
rule decl:sym<font-synthesis-position> { :i ("font-synthesis-position") ":" <val(/<css-val-font-synthesis-position> /, &?ROUTINE.WHY)>}
rule css-val-font-synthesis-position { :i [auto | none ]& <keyw>  }
#| font-synthesis-small-caps: auto | none
rule decl:sym<font-synthesis-small-caps> { :i ("font-synthesis-small-caps") ":" <val(/<css-val-font-synthesis-small-caps> /, &?ROUTINE.WHY)>}
rule css-val-font-synthesis-small-caps { :i [auto | none ]& <keyw>  }
#| font-synthesis-style: auto | none | oblique-only
rule decl:sym<font-synthesis-style> { :i ("font-synthesis-style") ":" <val(/<css-val-font-synthesis-style> /, &?ROUTINE.WHY)>}
rule css-val-font-synthesis-style { :i [auto | none | "oblique-only" ]& <keyw>  }
#| font-synthesis-weight: auto | none
rule decl:sym<font-synthesis-weight> { :i ("font-synthesis-weight") ":" <val(/<css-val-font-synthesis-weight> /, &?ROUTINE.WHY)>}
rule css-val-font-synthesis-weight { :i [auto | none ]& <keyw>  }
#| font-variant: normal | none | [ [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ] || [ small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps ] || [ stylistic(<font-feature-value-name>) || historical-forms || styleset(<font-feature-value-name>#) || character-variant(<font-feature-value-name>#) || swash(<font-feature-value-name>) || ornaments(<font-feature-value-name>) || annotation(<font-feature-value-name>) ] || [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ] || [ <east-asian-variant-values> || <east-asian-width-values> || ruby ] || [ sub | super ] || [ text | emoji | unicode ] ]
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<css-val-font-variant> /, &?ROUTINE.WHY)>}
rule css-val-font-variant { :i [normal | none ]& <keyw>  || [[[[<common-lig-values> :my $*B;<!{
    $*B++
}>|| <discretionary-lig-values> :my $*C;<!{
    $*C++
}>|| <historical-lig-values> :my $*D;<!{
    $*D++
}>|| <contextual-alt-values> :my $*E;<!{
    $*E++
}>]+] :my $*A;<!{
    $*A++
}>|| [["small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw> ] :my $*F;<!{
    $*F++
}>|| [[<stylistic> :my $*H;<!{
    $*H++
}>|| "historical-forms" & <keyw> :my $*I;<!{
    $*I++
}>|| <styleset> :my $*J;<!{
    $*J++
}>|| <character-variant> :my $*K;<!{
    $*K++
}>|| <swash> :my $*L;<!{
    $*L++
}>|| <ornaments> :my $*M;<!{
    $*M++
}>|| <annotation> :my $*N;<!{
    $*N++
}>]+] :my $*G;<!{
    $*G++
}>|| [[<numeric-figure-values> :my $*P;<!{
    $*P++
}>|| <numeric-spacing-values> :my $*Q;<!{
    $*Q++
}>|| <numeric-fraction-values> :my $*R;<!{
    $*R++
}>|| ordinal & <keyw> :my $*S;<!{
    $*S++
}>|| "slashed-zero" & <keyw> :my $*T;<!{
    $*T++
}>]+] :my $*O;<!{
    $*O++
}>|| [[<east-asian-variant-values> :my $*V;<!{
    $*V++
}>|| <east-asian-width-values> :my $*W;<!{
    $*W++
}>|| ruby & <keyw> :my $*X;<!{
    $*X++
}>]+] :my $*U;<!{
    $*U++
}>|| [[sub | super ]& <keyw> ] :my $*Y;<!{
    $*Y++
}>|| [[text | emoji | unicode ]& <keyw> ] :my $*Z;<!{
    $*Z++
}>]+]  }
#| font-variant-alternates: normal | [ stylistic(<font-feature-value-name>) || historical-forms || styleset(<font-feature-value-name>#) || character-variant(<font-feature-value-name>#) || swash(<font-feature-value-name>) || ornaments(<font-feature-value-name>) || annotation(<font-feature-value-name>) ]
rule decl:sym<font-variant-alternates> { :i ("font-variant-alternates") ":" <val(/<css-val-font-variant-alternates> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-alternates { :i normal & <keyw> || [[<stylistic> :my $*A;<!{
    $*A++
}>|| "historical-forms" & <keyw> :my $*B;<!{
    $*B++
}>|| <styleset> :my $*C;<!{
    $*C++
}>|| <character-variant> :my $*D;<!{
    $*D++
}>|| <swash> :my $*E;<!{
    $*E++
}>|| <ornaments> :my $*F;<!{
    $*F++
}>|| <annotation> :my $*G;<!{
    $*G++
}>]+]  }
#| font-variant-caps: normal | small-caps | all-small-caps | petite-caps | all-petite-caps | unicase | titling-caps
rule decl:sym<font-variant-caps> { :i ("font-variant-caps") ":" <val(/<css-val-font-variant-caps> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-caps { :i [normal | "small-caps" | "all-small-caps" | "petite-caps" | "all-petite-caps" | unicase | "titling-caps" ]& <keyw>  }
#| font-variant-east-asian: normal | [ <east-asian-variant-values> || <east-asian-width-values> || ruby ]
rule decl:sym<font-variant-east-asian> { :i ("font-variant-east-asian") ":" <val(/<css-val-font-variant-east-asian> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-east-asian { :i normal & <keyw> || [[<east-asian-variant-values> :my $*A;<!{
    $*A++
}>|| <east-asian-width-values> :my $*B;<!{
    $*B++
}>|| ruby & <keyw> :my $*C;<!{
    $*C++
}>]+]  }
#| font-variant-emoji: normal | text | emoji | unicode
rule decl:sym<font-variant-emoji> { :i ("font-variant-emoji") ":" <val(/<css-val-font-variant-emoji> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-emoji { :i [normal | text | emoji | unicode ]& <keyw>  }
#| font-variant-ligatures: normal | none | [ <common-lig-values> || <discretionary-lig-values> || <historical-lig-values> || <contextual-alt-values> ]
rule decl:sym<font-variant-ligatures> { :i ("font-variant-ligatures") ":" <val(/<css-val-font-variant-ligatures> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-ligatures { :i [normal | none ]& <keyw>  || [[<common-lig-values> :my $*A;<!{
    $*A++
}>|| <discretionary-lig-values> :my $*B;<!{
    $*B++
}>|| <historical-lig-values> :my $*C;<!{
    $*C++
}>|| <contextual-alt-values> :my $*D;<!{
    $*D++
}>]+]  }
#| font-variant-numeric: normal | [ <numeric-figure-values> || <numeric-spacing-values> || <numeric-fraction-values> || ordinal || slashed-zero ]
rule decl:sym<font-variant-numeric> { :i ("font-variant-numeric") ":" <val(/<css-val-font-variant-numeric> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-numeric { :i normal & <keyw> || [[<numeric-figure-values> :my $*A;<!{
    $*A++
}>|| <numeric-spacing-values> :my $*B;<!{
    $*B++
}>|| <numeric-fraction-values> :my $*C;<!{
    $*C++
}>|| ordinal & <keyw> :my $*D;<!{
    $*D++
}>|| "slashed-zero" & <keyw> :my $*E;<!{
    $*E++
}>]+]  }
#| font-variant-position: normal | sub | super
rule decl:sym<font-variant-position> { :i ("font-variant-position") ":" <val(/<css-val-font-variant-position> /, &?ROUTINE.WHY)>}
rule css-val-font-variant-position { :i [normal | sub | super ]& <keyw>  }
#| font-variation-settings: normal | [ <opentype-tag> <number> ]#
rule decl:sym<font-variation-settings> { :i ("font-variation-settings") ":" <val(/<css-val-font-variation-settings> /, &?ROUTINE.WHY)>}
rule css-val-font-variation-settings { :i normal & <keyw> || [<opentype-tag> <number> ] +% <op(",")>?  }
#| font-weight: <font-weight-absolute> | bolder | lighter
rule decl:sym<font-weight> { :i ("font-weight") ":" <val(/<css-val-font-weight> /, &?ROUTINE.WHY)>}
rule css-val-font-weight { :i <font-weight-absolute> || [bolder | lighter ]& <keyw>   }
#| font-width: normal | <percentage [0,∞]> | ultra-condensed | extra-condensed | condensed | semi-condensed | semi-expanded | expanded | extra-expanded | ultra-expanded
rule decl:sym<font-width> { :i ("font-width") ":" <val(/<css-val-font-width> /, &?ROUTINE.WHY)>}
rule css-val-font-width { :i normal & <keyw> || <percentage> || ["ultra-condensed" | "extra-condensed" | condensed | "semi-condensed" | "semi-expanded" | expanded | "extra-expanded" | "ultra-expanded" ]& <keyw>   }