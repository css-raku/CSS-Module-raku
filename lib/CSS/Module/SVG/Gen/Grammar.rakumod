unit grammar CSS::Module::SVG::Gen::Grammar;
#| alignment-baseline: auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical
rule decl:sym<alignment-baseline> { :i ("alignment-baseline") ":" <val(/<expr=.expr-alignment-baseline> /, &?ROUTINE.WHY)>}
rule expr-alignment-baseline { :i [auto | baseline | "before-edge" | "text-before-edge" | middle | central | "after-edge" | "text-after-edge" | ideographic | alphabetic | hanging | mathematical ]& <keyw>  }
#| baseline-shift: baseline | sub | super | <percentage> | <length>
rule decl:sym<baseline-shift> { :i ("baseline-shift") ":" <val(/<expr=.expr-baseline-shift> /, &?ROUTINE.WHY)>}
rule expr-baseline-shift { :i [baseline | sub | super ]& <keyw>  || <percentage> || <length>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<expr=.expr-color> /, &?ROUTINE.WHY)>}
rule expr-color { :i <color> }
#| color-interpolation: auto | sRGB | linearRGB
rule decl:sym<color-interpolation> { :i ("color-interpolation") ":" <val(/<expr=.expr-color-interpolation> /, &?ROUTINE.WHY)>}
rule expr-color-interpolation { :i [auto | sRGB | linearRGB ]& <keyw>  }
#| color-rendering: auto | optimizeSpeed | optimizeQuality
rule decl:sym<color-rendering> { :i ("color-rendering") ":" <val(/<expr=.expr-color-rendering> /, &?ROUTINE.WHY)>}
rule expr-color-rendering { :i [auto | optimizeSpeed | optimizeQuality ]& <keyw>  }
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<expr=.expr-direction> /, &?ROUTINE.WHY)>}
rule expr-direction { :i [ltr | rtl ]& <keyw>  }
#| display: inline | block | list-item | run-in | compact | marker | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
rule decl:sym<display> { :i (display) ":" <val(/<expr=.expr-display> /, &?ROUTINE.WHY)>}
rule expr-display { :i [inline | block | "list-item" | "run-in" | compact | marker | table | "inline-table" | "table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-column-group" | "table-column" | "table-cell" | "table-caption" | none ]& <keyw>  }
#| dominant-baseline: auto | use-script | no-change | reset-size | ideographic | alphabetic | hanging | mathematical | central | middle | text-after-edge | text-before-edge
rule decl:sym<dominant-baseline> { :i ("dominant-baseline") ":" <val(/<expr=.expr-dominant-baseline> /, &?ROUTINE.WHY)>}
rule expr-dominant-baseline { :i [auto | "use-script" | "no-change" | "reset-size" | ideographic | alphabetic | hanging | mathematical | central | middle | "text-after-edge" | "text-before-edge" ]& <keyw>  }
#| fill: <paint>
rule decl:sym<fill> { :i (fill) ":" <val(/<expr=.expr-fill> /, &?ROUTINE.WHY)>}
rule expr-fill { :i <paint> }
#| none | <color> | <url> [none | <color>]? | context-fill | context-stroke
rule paint { :i none & <keyw>  || <color> || <url> [none & <keyw>  || <color> ] ?  || ["context-fill" | "context-stroke" ]& <keyw>   }
#| fill-opacity: <alpha-value>
rule decl:sym<fill-opacity> { :i ("fill-opacity") ":" <val(/<expr=.expr-fill-opacity> /, &?ROUTINE.WHY)>}
rule expr-fill-opacity { :i <alpha-value> }
#| <percentage-range>
rule alpha-value { :i <percentage-range> }
#| fill-rule: nonzero | evenodd
rule decl:sym<fill-rule> { :i ("fill-rule") ":" <val(/<expr=.expr-fill-rule> /, &?ROUTINE.WHY)>}
rule expr-fill-rule { :i [nonzero | evenodd ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.expr-font-variant> /, &?ROUTINE.WHY)>}
rule expr-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| glyph-orientation-vertical: auto | <angle> | <number>
rule decl:sym<glyph-orientation-vertical> { :i ("glyph-orientation-vertical") ":" <val(/<expr=.expr-glyph-orientation-vertical> /, &?ROUTINE.WHY)>}
rule expr-glyph-orientation-vertical { :i auto & <keyw>  || <angle> || <number>  }
#| image-rendering: auto | optimizeSpeed | optimizeQuality
rule decl:sym<image-rendering> { :i ("image-rendering") ":" <val(/<expr=.expr-image-rendering> /, &?ROUTINE.WHY)>}
rule expr-image-rendering { :i [auto | optimizeSpeed | optimizeQuality ]& <keyw>  }
#| line-height: normal | <number> | <length-percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<expr=.expr-line-height> /, &?ROUTINE.WHY)>}
rule expr-line-height { :i normal & <keyw>  || <number> || <length-percentage>  }
#| marker: 'marker-start' || 'marker-mid' || 'marker-end'
rule decl:sym<marker> { :i (marker) ":" <val(/<expr=.expr-marker> /, &?ROUTINE.WHY)>}
rule expr-marker { :i [<expr-marker-start>:my $a; <!{
    $a++
}>| <expr-marker-mid>:my $b; <!{
    $b++
}>| <expr-marker-end>:my $c; <!{
    $c++
}>]+ }
#| marker-start: none | <url>
rule decl:sym<marker-start> { :i ("marker-start") ":" <val(/<expr=.expr-marker-start> /, &?ROUTINE.WHY)>}
rule expr-marker-start { :i none & <keyw>  || <url>  }
#| marker-start: none | <url>
rule decl:sym<marker-mid> { :i ("marker-mid") ":" <val(/<expr=.expr-marker-mid> /, &?ROUTINE.WHY)>}
rule expr-marker-mid { :i none & <keyw>  || <url>  }
#| marker-start: none | <url>
rule decl:sym<marker-end> { :i ("marker-end") ":" <val(/<expr=.expr-marker-end> /, &?ROUTINE.WHY)>}
rule expr-marker-end { :i none & <keyw>  || <url>  }
#| opacity: <alpha-value>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<expr=.expr-opacity> /, &?ROUTINE.WHY)>}
rule expr-opacity { :i <alpha-value> }
#| overflow: visible | hidden | scroll | auto
rule decl:sym<overflow> { :i (overflow) ":" <val(/<expr=.expr-overflow> /, &?ROUTINE.WHY)>}
rule expr-overflow { :i [visible | hidden | scroll | auto ]& <keyw>  }
#| paint-order: normal | [ fill || stroke || markers ]
rule decl:sym<paint-order> { :i ("paint-order") ":" <val(/<expr=.expr-paint-order> /, &?ROUTINE.WHY)>}
rule expr-paint-order { :i normal & <keyw>  || [[fill & <keyw> :my $a; <!{
    $a++
}>| stroke & <keyw> :my $b; <!{
    $b++
}>| markers & <keyw> :my $c; <!{
    $c++
}>]+]  }
#| pointer-events: bounding-box | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none
rule decl:sym<pointer-events> { :i ("pointer-events") ":" <val(/<expr=.expr-pointer-events> /, &?ROUTINE.WHY)>}
rule expr-pointer-events { :i ["bounding-box" | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none ]& <keyw>  }
#| shape-rendering: auto | optimizeSpeed | crispEdges | geometricPrecision
rule decl:sym<shape-rendering> { :i ("shape-rendering") ":" <val(/<expr=.expr-shape-rendering> /, &?ROUTINE.WHY)>}
rule expr-shape-rendering { :i [auto | optimizeSpeed | crispEdges | geometricPrecision ]& <keyw>  }
#| stop-color: currentColor |<color>
rule decl:sym<stop-color> { :i ("stop-color") ":" <val(/<expr=.expr-stop-color> /, &?ROUTINE.WHY)>}
rule expr-stop-color { :i currentColor & <keyw>  || <color>  }
#| stop-opacity: <alpha-value>
rule decl:sym<stop-opacity> { :i ("stop-opacity") ":" <val(/<expr=.expr-stop-opacity> /, &?ROUTINE.WHY)>}
rule expr-stop-opacity { :i <alpha-value> }
#| stroke: <paint>
rule decl:sym<stroke> { :i (stroke) ":" <val(/<expr=.expr-stroke> /, &?ROUTINE.WHY)>}
rule expr-stroke { :i <paint> }
#| stroke-dasharray: none | <dash-elem>#
rule decl:sym<stroke-dasharray> { :i ("stroke-dasharray") ":" <val(/<expr=.expr-stroke-dasharray> /, &?ROUTINE.WHY)>}
rule expr-stroke-dasharray { :i none & <keyw>  || <dash-elem> +% <op(",")>  }
#| <length> | <percentage> | <number>
rule length-percentage { :i <length> || <percentage> || <number>  }
#| <length-percentage> | <number>
rule dash-elem { :i <length-percentage> || <number>  }
#| stroke-dashoffset: <length-percentage>
rule decl:sym<stroke-dashoffset> { :i ("stroke-dashoffset") ":" <val(/<expr=.expr-stroke-dashoffset> /, &?ROUTINE.WHY)>}
rule expr-stroke-dashoffset { :i <length-percentage> }
#| stroke-linecap: butt | round | square
rule decl:sym<stroke-linecap> { :i ("stroke-linecap") ":" <val(/<expr=.expr-stroke-linecap> /, &?ROUTINE.WHY)>}
rule expr-stroke-linecap { :i [butt | round | square ]& <keyw>  }
#| stroke-linejoin: miter | round | bevel
rule decl:sym<stroke-linejoin> { :i ("stroke-linejoin") ":" <val(/<expr=.expr-stroke-linejoin> /, &?ROUTINE.WHY)>}
rule expr-stroke-linejoin { :i [miter | round | bevel ]& <keyw>  }
#| stroke-miterlimit: <number>
rule decl:sym<stroke-miterlimit> { :i ("stroke-miterlimit") ":" <val(/<expr=.expr-stroke-miterlimit> /, &?ROUTINE.WHY)>}
rule expr-stroke-miterlimit { :i <number> }
#| stroke-opacity: <alpha-value>
rule decl:sym<stroke-opacity> { :i ("stroke-opacity") ":" <val(/<expr=.expr-stroke-opacity> /, &?ROUTINE.WHY)>}
rule expr-stroke-opacity { :i <alpha-value> }
#| stroke-width: <length-percentage>
rule decl:sym<stroke-width> { :i ("stroke-width") ":" <val(/<expr=.expr-stroke-width> /, &?ROUTINE.WHY)>}
rule expr-stroke-width { :i <length-percentage> }
#| text-anchor: start | middle | end
rule decl:sym<text-anchor> { :i ("text-anchor") ":" <val(/<expr=.expr-text-anchor> /, &?ROUTINE.WHY)>}
rule expr-text-anchor { :i [start | middle | end ]& <keyw>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<expr=.expr-text-decoration> /, &?ROUTINE.WHY)>}
rule expr-text-decoration { :i none & <keyw>  || [[underline & <keyw> :my $a; <!{
    $a++
}>| overline & <keyw> :my $b; <!{
    $b++
}>| "line-through" & <keyw> :my $c; <!{
    $c++
}>| blink & <keyw> :my $d; <!{
    $d++
}>]+]  }
#| text-rendering: auto | optimizeSpeed | optimizeLegibility | geometricPrecision
rule decl:sym<text-rendering> { :i ("text-rendering") ":" <val(/<expr=.expr-text-rendering> /, &?ROUTINE.WHY)>}
rule expr-text-rendering { :i [auto | optimizeSpeed | optimizeLegibility | geometricPrecision ]& <keyw>  }
#| vector-effect: non-scaling-stroke | none
rule decl:sym<vector-effect> { :i ("vector-effect") ":" <val(/<expr=.expr-vector-effect> /, &?ROUTINE.WHY)>}
rule expr-vector-effect { :i ["non-scaling-stroke" | none ]& <keyw>  }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<expr=.expr-visibility> /, &?ROUTINE.WHY)>}
rule expr-visibility { :i [visible | hidden | collapse ]& <keyw>  }
#| white-space: normal | pre | nowrap | pre-wrap | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<expr=.expr-white-space> /, &?ROUTINE.WHY)>}
rule expr-white-space { :i [normal | pre | nowrap | "pre-wrap" | "pre-line" ]& <keyw>  }
#| writing-mode: lr-tb | rl-tb | tb-rl | lr | rl | tb
rule decl:sym<writing-mode> { :i ("writing-mode") ":" <val(/<expr=.expr-writing-mode> /, &?ROUTINE.WHY)>}
rule expr-writing-mode { :i ["lr-tb" | "rl-tb" | "tb-rl" | lr | rl | tb ]& <keyw>  }
#| lighting-color: <color>
rule decl:sym<lighting-color> { :i ("lighting-color") ":" <val(/<expr=.expr-lighting-color> /, &?ROUTINE.WHY)>}
rule expr-lighting-color { :i <color> }
#| text-overflow: clip | ellipsis
rule decl:sym<text-overflow> { :i ("text-overflow") ":" <val(/<expr=.expr-text-overflow> /, &?ROUTINE.WHY)>}
rule expr-text-overflow { :i [clip | ellipsis ]& <keyw>  }
#| color-interpolation-filters: auto | sRGB | linearRGB
rule decl:sym<color-interpolation-filters> { :i ("color-interpolation-filters") ":" <val(/<expr=.expr-color-interpolation-filters> /, &?ROUTINE.WHY)>}
rule expr-color-interpolation-filters { :i [auto | sRGB | linearRGB ]& <keyw>  }