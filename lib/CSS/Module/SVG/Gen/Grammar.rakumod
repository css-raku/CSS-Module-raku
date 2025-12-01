unit grammar CSS::Module::SVG::Gen::Grammar;
#| alignment-baseline: auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical
rule decl:sym<alignment-baseline> { :i ("alignment-baseline") ":" <val(/<css-val-alignment-baseline> /, &?ROUTINE.WHY)>}
rule css-val-alignment-baseline { :i [auto | baseline | "before-edge" | "text-before-edge" | middle | central | "after-edge" | "text-after-edge" | ideographic | alphabetic | hanging | mathematical ]& <keyw>  }
#| baseline-shift: baseline | sub | super | <percentage> | <length>
rule decl:sym<baseline-shift> { :i ("baseline-shift") ":" <val(/<css-val-baseline-shift> /, &?ROUTINE.WHY)>}
rule css-val-baseline-shift { :i [baseline | sub | super ]& <keyw>  || <percentage> || <length>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<css-val-color> /, &?ROUTINE.WHY)>}
rule css-val-color { :i <color> }
#| color-interpolation: auto | sRGB | linearRGB
rule decl:sym<color-interpolation> { :i ("color-interpolation") ":" <val(/<css-val-color-interpolation> /, &?ROUTINE.WHY)>}
rule css-val-color-interpolation { :i [auto | sRGB | linearRGB ]& <keyw>  }
#| color-rendering: auto | optimizeSpeed | optimizeQuality
rule decl:sym<color-rendering> { :i ("color-rendering") ":" <val(/<css-val-color-rendering> /, &?ROUTINE.WHY)>}
rule css-val-color-rendering { :i [auto | optimizeSpeed | optimizeQuality ]& <keyw>  }
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<css-val-direction> /, &?ROUTINE.WHY)>}
rule css-val-direction { :i [ltr | rtl ]& <keyw>  }
#| display: inline | block | list-item | run-in | compact | marker | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
rule decl:sym<display> { :i (display) ":" <val(/<css-val-display> /, &?ROUTINE.WHY)>}
rule css-val-display { :i [inline | block | "list-item" | "run-in" | compact | marker | table | "inline-table" | "table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-column-group" | "table-column" | "table-cell" | "table-caption" | none ]& <keyw>  }
#| dominant-baseline: auto | use-script | no-change | reset-size | ideographic | alphabetic | hanging | mathematical | central | middle | text-after-edge | text-before-edge
rule decl:sym<dominant-baseline> { :i ("dominant-baseline") ":" <val(/<css-val-dominant-baseline> /, &?ROUTINE.WHY)>}
rule css-val-dominant-baseline { :i [auto | "use-script" | "no-change" | "reset-size" | ideographic | alphabetic | hanging | mathematical | central | middle | "text-after-edge" | "text-before-edge" ]& <keyw>  }
#| fill: <paint>
rule decl:sym<fill> { :i (fill) ":" <val(/<css-val-fill> /, &?ROUTINE.WHY)>}
rule css-val-fill { :i <paint> }
#| <paint> = none | <color> | <url> [none | <color>]? | context-fill | context-stroke
rule paint { :i none & <keyw> || <color> || <url> [none & <keyw> || <color> ] ?  || ["context-fill" | "context-stroke" ]& <keyw>   }
#| fill-opacity: <alpha-value>
rule decl:sym<fill-opacity> { :i ("fill-opacity") ":" <val(/<css-val-fill-opacity> /, &?ROUTINE.WHY)>}
rule css-val-fill-opacity { :i <alpha-value> }
#| <alpha-value> = <percentage-range>
rule alpha-value { :i <percentage-range> }
#| fill-rule: nonzero | evenodd
rule decl:sym<fill-rule> { :i ("fill-rule") ":" <val(/<css-val-fill-rule> /, &?ROUTINE.WHY)>}
rule css-val-fill-rule { :i [nonzero | evenodd ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<css-val-font-variant> /, &?ROUTINE.WHY)>}
rule css-val-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| glyph-orientation-vertical: auto | <angle> | <number>
rule decl:sym<glyph-orientation-vertical> { :i ("glyph-orientation-vertical") ":" <val(/<css-val-glyph-orientation-vertical> /, &?ROUTINE.WHY)>}
rule css-val-glyph-orientation-vertical { :i auto & <keyw> || <angle> || <number>  }
#| image-rendering: auto | optimizeSpeed | optimizeQuality
rule decl:sym<image-rendering> { :i ("image-rendering") ":" <val(/<css-val-image-rendering> /, &?ROUTINE.WHY)>}
rule css-val-image-rendering { :i [auto | optimizeSpeed | optimizeQuality ]& <keyw>  }
#| line-height: normal | <number> | <length-percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<css-val-line-height> /, &?ROUTINE.WHY)>}
rule css-val-line-height { :i normal & <keyw> || <number> || <length-percentage>  }
#| marker: 'marker-start' || 'marker-mid' || 'marker-end'
rule decl:sym<marker> { :i (marker) ":" <val(/<css-val-marker> /, &?ROUTINE.WHY)>}
rule css-val-marker { :i [<css-val-marker-start> :my $*A; <!{
    $*A++
}>|| <css-val-marker-mid> :my $*B; <!{
    $*B++
}>|| <css-val-marker-end> :my $*C; <!{
    $*C++
}>]+ }
#| marker-start: none | <url>
rule decl:sym<marker-start> { :i ("marker-start") ":" <val(/<css-val-marker-start> /, &?ROUTINE.WHY)>}
rule css-val-marker-start { :i none & <keyw> || <url>  }
#| marker-start: none | <url>
rule decl:sym<marker-mid> { :i ("marker-mid") ":" <val(/<css-val-marker-mid> /, &?ROUTINE.WHY)>}
rule css-val-marker-mid { :i none & <keyw> || <url>  }
#| marker-start: none | <url>
rule decl:sym<marker-end> { :i ("marker-end") ":" <val(/<css-val-marker-end> /, &?ROUTINE.WHY)>}
rule css-val-marker-end { :i none & <keyw> || <url>  }
#| opacity: <alpha-value>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<css-val-opacity> /, &?ROUTINE.WHY)>}
rule css-val-opacity { :i <alpha-value> }
#| overflow: visible | hidden | scroll | auto
rule decl:sym<overflow> { :i (overflow) ":" <val(/<css-val-overflow> /, &?ROUTINE.WHY)>}
rule css-val-overflow { :i [visible | hidden | scroll | auto ]& <keyw>  }
#| paint-order: normal | [ fill || stroke || markers ]
rule decl:sym<paint-order> { :i ("paint-order") ":" <val(/<css-val-paint-order> /, &?ROUTINE.WHY)>}
rule css-val-paint-order { :i normal & <keyw> || [[fill & <keyw> :my $*A; <!{
    $*A++
}>|| stroke & <keyw> :my $*B; <!{
    $*B++
}>|| markers & <keyw> :my $*C; <!{
    $*C++
}>]+]  }
#| pointer-events: bounding-box | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none
rule decl:sym<pointer-events> { :i ("pointer-events") ":" <val(/<css-val-pointer-events> /, &?ROUTINE.WHY)>}
rule css-val-pointer-events { :i ["bounding-box" | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none ]& <keyw>  }
#| shape-rendering: auto | optimizeSpeed | crispEdges | geometricPrecision
rule decl:sym<shape-rendering> { :i ("shape-rendering") ":" <val(/<css-val-shape-rendering> /, &?ROUTINE.WHY)>}
rule css-val-shape-rendering { :i [auto | optimizeSpeed | crispEdges | geometricPrecision ]& <keyw>  }
#| stop-color: currentColor |<color>
rule decl:sym<stop-color> { :i ("stop-color") ":" <val(/<css-val-stop-color> /, &?ROUTINE.WHY)>}
rule css-val-stop-color { :i currentColor & <keyw> || <color>  }
#| stop-opacity: <alpha-value>
rule decl:sym<stop-opacity> { :i ("stop-opacity") ":" <val(/<css-val-stop-opacity> /, &?ROUTINE.WHY)>}
rule css-val-stop-opacity { :i <alpha-value> }
#| stroke: <paint>
rule decl:sym<stroke> { :i (stroke) ":" <val(/<css-val-stroke> /, &?ROUTINE.WHY)>}
rule css-val-stroke { :i <paint> }
#| stroke-dasharray: none | <dash-elem>#
rule decl:sym<stroke-dasharray> { :i ("stroke-dasharray") ":" <val(/<css-val-stroke-dasharray> /, &?ROUTINE.WHY)>}
rule css-val-stroke-dasharray { :i none & <keyw> || <dash-elem> +% <op(",")>  }
#| <length-percentage> = <length> | <percentage> | <number>
rule length-percentage { :i <length> || <percentage> || <number>  }
#| <dash-elem> = <length-percentage> | <number>
rule dash-elem { :i <length-percentage> || <number>  }
#| stroke-dashoffset: <length-percentage>
rule decl:sym<stroke-dashoffset> { :i ("stroke-dashoffset") ":" <val(/<css-val-stroke-dashoffset> /, &?ROUTINE.WHY)>}
rule css-val-stroke-dashoffset { :i <length-percentage> }
#| stroke-linecap: butt | round | square
rule decl:sym<stroke-linecap> { :i ("stroke-linecap") ":" <val(/<css-val-stroke-linecap> /, &?ROUTINE.WHY)>}
rule css-val-stroke-linecap { :i [butt | round | square ]& <keyw>  }
#| stroke-linejoin: miter | round | bevel
rule decl:sym<stroke-linejoin> { :i ("stroke-linejoin") ":" <val(/<css-val-stroke-linejoin> /, &?ROUTINE.WHY)>}
rule css-val-stroke-linejoin { :i [miter | round | bevel ]& <keyw>  }
#| stroke-miterlimit: <number>
rule decl:sym<stroke-miterlimit> { :i ("stroke-miterlimit") ":" <val(/<css-val-stroke-miterlimit> /, &?ROUTINE.WHY)>}
rule css-val-stroke-miterlimit { :i <number> }
#| stroke-opacity: <alpha-value>
rule decl:sym<stroke-opacity> { :i ("stroke-opacity") ":" <val(/<css-val-stroke-opacity> /, &?ROUTINE.WHY)>}
rule css-val-stroke-opacity { :i <alpha-value> }
#| stroke-width: <length-percentage>
rule decl:sym<stroke-width> { :i ("stroke-width") ":" <val(/<css-val-stroke-width> /, &?ROUTINE.WHY)>}
rule css-val-stroke-width { :i <length-percentage> }
#| text-anchor: start | middle | end
rule decl:sym<text-anchor> { :i ("text-anchor") ":" <val(/<css-val-text-anchor> /, &?ROUTINE.WHY)>}
rule css-val-text-anchor { :i [start | middle | end ]& <keyw>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<css-val-text-decoration> /, &?ROUTINE.WHY)>}
rule css-val-text-decoration { :i none & <keyw> || [[underline & <keyw> :my $*A; <!{
    $*A++
}>|| overline & <keyw> :my $*B; <!{
    $*B++
}>|| "line-through" & <keyw> :my $*C; <!{
    $*C++
}>|| blink & <keyw> :my $*D; <!{
    $*D++
}>]+]  }
#| text-rendering: auto | optimizeSpeed | optimizeLegibility | geometricPrecision
rule decl:sym<text-rendering> { :i ("text-rendering") ":" <val(/<css-val-text-rendering> /, &?ROUTINE.WHY)>}
rule css-val-text-rendering { :i [auto | optimizeSpeed | optimizeLegibility | geometricPrecision ]& <keyw>  }
#| vector-effect: non-scaling-stroke | none
rule decl:sym<vector-effect> { :i ("vector-effect") ":" <val(/<css-val-vector-effect> /, &?ROUTINE.WHY)>}
rule css-val-vector-effect { :i ["non-scaling-stroke" | none ]& <keyw>  }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<css-val-visibility> /, &?ROUTINE.WHY)>}
rule css-val-visibility { :i [visible | hidden | collapse ]& <keyw>  }
#| white-space: normal | pre | nowrap | pre-wrap | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<css-val-white-space> /, &?ROUTINE.WHY)>}
rule css-val-white-space { :i [normal | pre | nowrap | "pre-wrap" | "pre-line" ]& <keyw>  }
#| writing-mode: lr-tb | rl-tb | tb-rl | lr | rl | tb
rule decl:sym<writing-mode> { :i ("writing-mode") ":" <val(/<css-val-writing-mode> /, &?ROUTINE.WHY)>}
rule css-val-writing-mode { :i ["lr-tb" | "rl-tb" | "tb-rl" | lr | rl | tb ]& <keyw>  }
#| lighting-color: <color>
rule decl:sym<lighting-color> { :i ("lighting-color") ":" <val(/<css-val-lighting-color> /, &?ROUTINE.WHY)>}
rule css-val-lighting-color { :i <color> }
#| text-overflow: clip | ellipsis
rule decl:sym<text-overflow> { :i ("text-overflow") ":" <val(/<css-val-text-overflow> /, &?ROUTINE.WHY)>}
rule css-val-text-overflow { :i [clip | ellipsis ]& <keyw>  }
#| color-interpolation-filters: auto | sRGB | linearRGB
rule decl:sym<color-interpolation-filters> { :i ("color-interpolation-filters") ":" <val(/<css-val-color-interpolation-filters> /, &?ROUTINE.WHY)>}
rule css-val-color-interpolation-filters { :i [auto | sRGB | linearRGB ]& <keyw>  }