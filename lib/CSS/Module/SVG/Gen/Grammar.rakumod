unit grammar CSS::Module::SVG::Gen::Grammar;
#| alignment-baseline: auto | baseline | before-edge | text-before-edge | middle | central | after-edge | text-after-edge | ideographic | alphabetic | hanging | mathematical
rule decl:sym<alignment-baseline> { :i ("alignment-baseline") ":" <val(/<expr=.prop-val-alignment-baseline> /, &?ROUTINE.WHY)>}
rule prop-val-alignment-baseline { :i [auto | baseline | "before-edge" | "text-before-edge" | middle | central | "after-edge" | "text-after-edge" | ideographic | alphabetic | hanging | mathematical ]& <keyw>  }
#| baseline-shift: baseline | sub | super | <percentage> | <length>
rule decl:sym<baseline-shift> { :i ("baseline-shift") ":" <val(/<expr=.prop-val-baseline-shift> /, &?ROUTINE.WHY)>}
rule prop-val-baseline-shift { :i [baseline | sub | super ]& <keyw>  || <percentage> || <length>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<expr=.prop-val-color> /, &?ROUTINE.WHY)>}
rule prop-val-color { :i <color> }
#| color-interpolation: auto | sRGB | linearRGB
rule decl:sym<color-interpolation> { :i ("color-interpolation") ":" <val(/<expr=.prop-val-color-interpolation> /, &?ROUTINE.WHY)>}
rule prop-val-color-interpolation { :i [auto | sRGB | linearRGB ]& <keyw>  }
#| color-rendering: auto | optimizeSpeed | optimizeQuality
rule decl:sym<color-rendering> { :i ("color-rendering") ":" <val(/<expr=.prop-val-color-rendering> /, &?ROUTINE.WHY)>}
rule prop-val-color-rendering { :i [auto | optimizeSpeed | optimizeQuality ]& <keyw>  }
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<expr=.prop-val-direction> /, &?ROUTINE.WHY)>}
rule prop-val-direction { :i [ltr | rtl ]& <keyw>  }
#| display: inline | block | list-item | run-in | compact | marker | table | inline-table | table-row-group | table-header-group | table-footer-group | table-row | table-column-group | table-column | table-cell | table-caption | none
rule decl:sym<display> { :i (display) ":" <val(/<expr=.prop-val-display> /, &?ROUTINE.WHY)>}
rule prop-val-display { :i [inline | block | "list-item" | "run-in" | compact | marker | table | "inline-table" | "table-row-group" | "table-header-group" | "table-footer-group" | "table-row" | "table-column-group" | "table-column" | "table-cell" | "table-caption" | none ]& <keyw>  }
#| dominant-baseline: auto | use-script | no-change | reset-size | ideographic | alphabetic | hanging | mathematical | central | middle | text-after-edge | text-before-edge
rule decl:sym<dominant-baseline> { :i ("dominant-baseline") ":" <val(/<expr=.prop-val-dominant-baseline> /, &?ROUTINE.WHY)>}
rule prop-val-dominant-baseline { :i [auto | "use-script" | "no-change" | "reset-size" | ideographic | alphabetic | hanging | mathematical | central | middle | "text-after-edge" | "text-before-edge" ]& <keyw>  }
#| fill: <paint>
rule decl:sym<fill> { :i (fill) ":" <val(/<expr=.prop-val-fill> /, &?ROUTINE.WHY)>}
rule prop-val-fill { :i <paint> }
#| <paint> = none | <color> | <url> [none | <color>]? | context-fill | context-stroke
rule paint { :i none & <keyw>  || <color> || <url> [none & <keyw>  || <color> ] ?  || ["context-fill" | "context-stroke" ]& <keyw>   }
#| fill-opacity: <alpha-value>
rule decl:sym<fill-opacity> { :i ("fill-opacity") ":" <val(/<expr=.prop-val-fill-opacity> /, &?ROUTINE.WHY)>}
rule prop-val-fill-opacity { :i <alpha-value> }
#| <alpha-value> = <percentage-range>
rule alpha-value { :i <percentage-range> }
#| fill-rule: nonzero | evenodd
rule decl:sym<fill-rule> { :i ("fill-rule") ":" <val(/<expr=.prop-val-fill-rule> /, &?ROUTINE.WHY)>}
rule prop-val-fill-rule { :i [nonzero | evenodd ]& <keyw>  }
#| font-variant: normal | small-caps
rule decl:sym<font-variant> { :i ("font-variant") ":" <val(/<expr=.prop-val-font-variant> /, &?ROUTINE.WHY)>}
rule prop-val-font-variant { :i [normal | "small-caps" ]& <keyw>  }
#| glyph-orientation-vertical: auto | <angle> | <number>
rule decl:sym<glyph-orientation-vertical> { :i ("glyph-orientation-vertical") ":" <val(/<expr=.prop-val-glyph-orientation-vertical> /, &?ROUTINE.WHY)>}
rule prop-val-glyph-orientation-vertical { :i auto & <keyw>  || <angle> || <number>  }
#| image-rendering: auto | optimizeSpeed | optimizeQuality
rule decl:sym<image-rendering> { :i ("image-rendering") ":" <val(/<expr=.prop-val-image-rendering> /, &?ROUTINE.WHY)>}
rule prop-val-image-rendering { :i [auto | optimizeSpeed | optimizeQuality ]& <keyw>  }
#| line-height: normal | <number> | <length-percentage>
rule decl:sym<line-height> { :i ("line-height") ":" <val(/<expr=.prop-val-line-height> /, &?ROUTINE.WHY)>}
rule prop-val-line-height { :i normal & <keyw>  || <number> || <length-percentage>  }
#| marker: 'marker-start' || 'marker-mid' || 'marker-end'
rule decl:sym<marker> { :i (marker) ":" <val(/<expr=.prop-val-marker> /, &?ROUTINE.WHY)>}
rule prop-val-marker { :i [<prop-val-marker-start> :my $*A; <!{
    $*A++
}>| <prop-val-marker-mid> :my $*B; <!{
    $*B++
}>| <prop-val-marker-end> :my $*C; <!{
    $*C++
}>]+ }
#| marker-start: none | <url>
rule decl:sym<marker-start> { :i ("marker-start") ":" <val(/<expr=.prop-val-marker-start> /, &?ROUTINE.WHY)>}
rule prop-val-marker-start { :i none & <keyw>  || <url>  }
#| marker-start: none | <url>
rule decl:sym<marker-mid> { :i ("marker-mid") ":" <val(/<expr=.prop-val-marker-mid> /, &?ROUTINE.WHY)>}
rule prop-val-marker-mid { :i none & <keyw>  || <url>  }
#| marker-start: none | <url>
rule decl:sym<marker-end> { :i ("marker-end") ":" <val(/<expr=.prop-val-marker-end> /, &?ROUTINE.WHY)>}
rule prop-val-marker-end { :i none & <keyw>  || <url>  }
#| opacity: <alpha-value>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<expr=.prop-val-opacity> /, &?ROUTINE.WHY)>}
rule prop-val-opacity { :i <alpha-value> }
#| overflow: visible | hidden | scroll | auto
rule decl:sym<overflow> { :i (overflow) ":" <val(/<expr=.prop-val-overflow> /, &?ROUTINE.WHY)>}
rule prop-val-overflow { :i [visible | hidden | scroll | auto ]& <keyw>  }
#| paint-order: normal | [ fill || stroke || markers ]
rule decl:sym<paint-order> { :i ("paint-order") ":" <val(/<expr=.prop-val-paint-order> /, &?ROUTINE.WHY)>}
rule prop-val-paint-order { :i normal & <keyw>  || [[fill & <keyw>  :my $*A; <!{
    $*A++
}>| stroke & <keyw>  :my $*B; <!{
    $*B++
}>| markers & <keyw>  :my $*C; <!{
    $*C++
}>]+]  }
#| pointer-events: bounding-box | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none
rule decl:sym<pointer-events> { :i ("pointer-events") ":" <val(/<expr=.prop-val-pointer-events> /, &?ROUTINE.WHY)>}
rule prop-val-pointer-events { :i ["bounding-box" | visiblePainted | visibleFill | visibleStroke | visible | painted | fill | stroke | all | none ]& <keyw>  }
#| shape-rendering: auto | optimizeSpeed | crispEdges | geometricPrecision
rule decl:sym<shape-rendering> { :i ("shape-rendering") ":" <val(/<expr=.prop-val-shape-rendering> /, &?ROUTINE.WHY)>}
rule prop-val-shape-rendering { :i [auto | optimizeSpeed | crispEdges | geometricPrecision ]& <keyw>  }
#| stop-color: currentColor |<color>
rule decl:sym<stop-color> { :i ("stop-color") ":" <val(/<expr=.prop-val-stop-color> /, &?ROUTINE.WHY)>}
rule prop-val-stop-color { :i currentColor & <keyw>  || <color>  }
#| stop-opacity: <alpha-value>
rule decl:sym<stop-opacity> { :i ("stop-opacity") ":" <val(/<expr=.prop-val-stop-opacity> /, &?ROUTINE.WHY)>}
rule prop-val-stop-opacity { :i <alpha-value> }
#| stroke: <paint>
rule decl:sym<stroke> { :i (stroke) ":" <val(/<expr=.prop-val-stroke> /, &?ROUTINE.WHY)>}
rule prop-val-stroke { :i <paint> }
#| stroke-dasharray: none | <dash-elem>#
rule decl:sym<stroke-dasharray> { :i ("stroke-dasharray") ":" <val(/<expr=.prop-val-stroke-dasharray> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-dasharray { :i none & <keyw>  || <dash-elem> +% <op(",")>  }
#| <length-percentage> = <length> | <percentage> | <number>
rule length-percentage { :i <length> || <percentage> || <number>  }
#| <dash-elem> = <length-percentage> | <number>
rule dash-elem { :i <length-percentage> || <number>  }
#| stroke-dashoffset: <length-percentage>
rule decl:sym<stroke-dashoffset> { :i ("stroke-dashoffset") ":" <val(/<expr=.prop-val-stroke-dashoffset> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-dashoffset { :i <length-percentage> }
#| stroke-linecap: butt | round | square
rule decl:sym<stroke-linecap> { :i ("stroke-linecap") ":" <val(/<expr=.prop-val-stroke-linecap> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-linecap { :i [butt | round | square ]& <keyw>  }
#| stroke-linejoin: miter | round | bevel
rule decl:sym<stroke-linejoin> { :i ("stroke-linejoin") ":" <val(/<expr=.prop-val-stroke-linejoin> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-linejoin { :i [miter | round | bevel ]& <keyw>  }
#| stroke-miterlimit: <number>
rule decl:sym<stroke-miterlimit> { :i ("stroke-miterlimit") ":" <val(/<expr=.prop-val-stroke-miterlimit> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-miterlimit { :i <number> }
#| stroke-opacity: <alpha-value>
rule decl:sym<stroke-opacity> { :i ("stroke-opacity") ":" <val(/<expr=.prop-val-stroke-opacity> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-opacity { :i <alpha-value> }
#| stroke-width: <length-percentage>
rule decl:sym<stroke-width> { :i ("stroke-width") ":" <val(/<expr=.prop-val-stroke-width> /, &?ROUTINE.WHY)>}
rule prop-val-stroke-width { :i <length-percentage> }
#| text-anchor: start | middle | end
rule decl:sym<text-anchor> { :i ("text-anchor") ":" <val(/<expr=.prop-val-text-anchor> /, &?ROUTINE.WHY)>}
rule prop-val-text-anchor { :i [start | middle | end ]& <keyw>  }
#| text-decoration: none | [ underline || overline || line-through || blink ]
rule decl:sym<text-decoration> { :i ("text-decoration") ":" <val(/<expr=.prop-val-text-decoration> /, &?ROUTINE.WHY)>}
rule prop-val-text-decoration { :i none & <keyw>  || [[underline & <keyw>  :my $*A; <!{
    $*A++
}>| overline & <keyw>  :my $*B; <!{
    $*B++
}>| "line-through" & <keyw>  :my $*C; <!{
    $*C++
}>| blink & <keyw>  :my $*D; <!{
    $*D++
}>]+]  }
#| text-rendering: auto | optimizeSpeed | optimizeLegibility | geometricPrecision
rule decl:sym<text-rendering> { :i ("text-rendering") ":" <val(/<expr=.prop-val-text-rendering> /, &?ROUTINE.WHY)>}
rule prop-val-text-rendering { :i [auto | optimizeSpeed | optimizeLegibility | geometricPrecision ]& <keyw>  }
#| vector-effect: non-scaling-stroke | none
rule decl:sym<vector-effect> { :i ("vector-effect") ":" <val(/<expr=.prop-val-vector-effect> /, &?ROUTINE.WHY)>}
rule prop-val-vector-effect { :i ["non-scaling-stroke" | none ]& <keyw>  }
#| visibility: visible | hidden | collapse
rule decl:sym<visibility> { :i (visibility) ":" <val(/<expr=.prop-val-visibility> /, &?ROUTINE.WHY)>}
rule prop-val-visibility { :i [visible | hidden | collapse ]& <keyw>  }
#| white-space: normal | pre | nowrap | pre-wrap | pre-line
rule decl:sym<white-space> { :i ("white-space") ":" <val(/<expr=.prop-val-white-space> /, &?ROUTINE.WHY)>}
rule prop-val-white-space { :i [normal | pre | nowrap | "pre-wrap" | "pre-line" ]& <keyw>  }
#| writing-mode: lr-tb | rl-tb | tb-rl | lr | rl | tb
rule decl:sym<writing-mode> { :i ("writing-mode") ":" <val(/<expr=.prop-val-writing-mode> /, &?ROUTINE.WHY)>}
rule prop-val-writing-mode { :i ["lr-tb" | "rl-tb" | "tb-rl" | lr | rl | tb ]& <keyw>  }
#| lighting-color: <color>
rule decl:sym<lighting-color> { :i ("lighting-color") ":" <val(/<expr=.prop-val-lighting-color> /, &?ROUTINE.WHY)>}
rule prop-val-lighting-color { :i <color> }
#| text-overflow: clip | ellipsis
rule decl:sym<text-overflow> { :i ("text-overflow") ":" <val(/<expr=.prop-val-text-overflow> /, &?ROUTINE.WHY)>}
rule prop-val-text-overflow { :i [clip | ellipsis ]& <keyw>  }
#| color-interpolation-filters: auto | sRGB | linearRGB
rule decl:sym<color-interpolation-filters> { :i ("color-interpolation-filters") ":" <val(/<expr=.prop-val-color-interpolation-filters> /, &?ROUTINE.WHY)>}
rule prop-val-color-interpolation-filters { :i [auto | sRGB | linearRGB ]& <keyw>  }