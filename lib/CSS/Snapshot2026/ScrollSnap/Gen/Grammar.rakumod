unit grammar CSS::Snapshot2026::ScrollSnap::Gen::Grammar;
#| scroll-margin: <length>{1,4}
rule decl:sym<scroll-margin> { :i ("scroll-margin") ":" <val(/<css-val-scroll-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin { :i <length> }
#| scroll-margin-block: <length>{1,2}
rule decl:sym<scroll-margin-block> { :i ("scroll-margin-block") ":" <val(/<css-val-scroll-margin-block> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-block { :i <length> ** 1..2 }
#| scroll-margin-block-end: <length>
rule decl:sym<scroll-margin-block-end> { :i ("scroll-margin-block-end") ":" <val(/<css-val-scroll-margin-block-end> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-block-end { :i <length> }
#| scroll-margin-block-start: <length>
rule decl:sym<scroll-margin-block-start> { :i ("scroll-margin-block-start") ":" <val(/<css-val-scroll-margin-block-start> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-block-start { :i <length> }
#| scroll-margin-bottom: <length>
rule decl:sym<scroll-margin-bottom> { :i ("scroll-margin-bottom") ":" <val(/<css-val-scroll-margin-bottom> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-bottom { :i <length> }
#| scroll-margin-inline: <length>{1,2}
rule decl:sym<scroll-margin-inline> { :i ("scroll-margin-inline") ":" <val(/<css-val-scroll-margin-inline> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-inline { :i <length> ** 1..2 }
#| scroll-margin-inline-end: <length>
rule decl:sym<scroll-margin-inline-end> { :i ("scroll-margin-inline-end") ":" <val(/<css-val-scroll-margin-inline-end> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-inline-end { :i <length> }
#| scroll-margin-inline-start: <length>
rule decl:sym<scroll-margin-inline-start> { :i ("scroll-margin-inline-start") ":" <val(/<css-val-scroll-margin-inline-start> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-inline-start { :i <length> }
#| scroll-margin-left: <length>
rule decl:sym<scroll-margin-left> { :i ("scroll-margin-left") ":" <val(/<css-val-scroll-margin-left> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-left { :i <length> }
#| scroll-margin-right: <length>
rule decl:sym<scroll-margin-right> { :i ("scroll-margin-right") ":" <val(/<css-val-scroll-margin-right> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-right { :i <length> }
#| scroll-margin-top: <length>
rule decl:sym<scroll-margin-top> { :i ("scroll-margin-top") ":" <val(/<css-val-scroll-margin-top> /, &?ROUTINE.WHY)>}
rule css-val-scroll-margin-top { :i <length> }
#| scroll-padding: [ auto | <length-percentage [0,∞]> ]{1,4}
rule decl:sym<scroll-padding> { :i ("scroll-padding") ":" <val(/<css-val-scroll-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding { :i [auto & <keyw> || <length-percentage> ] }
#| scroll-padding-block: [ auto | <length-percentage [0,∞]> ]{1,2}
rule decl:sym<scroll-padding-block> { :i ("scroll-padding-block") ":" <val(/<css-val-scroll-padding-block> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-block { :i [auto & <keyw> || <length-percentage> ] ** 1..2 }
#| scroll-padding-block-end: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-block-end> { :i ("scroll-padding-block-end") ":" <val(/<css-val-scroll-padding-block-end> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-block-end { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-block-start: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-block-start> { :i ("scroll-padding-block-start") ":" <val(/<css-val-scroll-padding-block-start> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-block-start { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-bottom: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-bottom> { :i ("scroll-padding-bottom") ":" <val(/<css-val-scroll-padding-bottom> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-bottom { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-inline: [ auto | <length-percentage [0,∞]> ]{1,2}
rule decl:sym<scroll-padding-inline> { :i ("scroll-padding-inline") ":" <val(/<css-val-scroll-padding-inline> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-inline { :i [auto & <keyw> || <length-percentage> ] ** 1..2 }
#| scroll-padding-inline-end: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-inline-end> { :i ("scroll-padding-inline-end") ":" <val(/<css-val-scroll-padding-inline-end> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-inline-end { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-inline-start: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-inline-start> { :i ("scroll-padding-inline-start") ":" <val(/<css-val-scroll-padding-inline-start> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-inline-start { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-left: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-left> { :i ("scroll-padding-left") ":" <val(/<css-val-scroll-padding-left> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-left { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-right: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-right> { :i ("scroll-padding-right") ":" <val(/<css-val-scroll-padding-right> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-right { :i auto & <keyw> || <length-percentage>  }
#| scroll-padding-top: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-top> { :i ("scroll-padding-top") ":" <val(/<css-val-scroll-padding-top> /, &?ROUTINE.WHY)>}
rule css-val-scroll-padding-top { :i auto & <keyw> || <length-percentage>  }
#| scroll-snap-align: [ none | start | end | center ]{1,2}
rule decl:sym<scroll-snap-align> { :i ("scroll-snap-align") ":" <val(/<css-val-scroll-snap-align> /, &?ROUTINE.WHY)>}
rule css-val-scroll-snap-align { :i [[none | start | end | center ]& <keyw> ] ** 1..2 }
#| scroll-snap-stop: normal | always
rule decl:sym<scroll-snap-stop> { :i ("scroll-snap-stop") ":" <val(/<css-val-scroll-snap-stop> /, &?ROUTINE.WHY)>}
rule css-val-scroll-snap-stop { :i [normal | always ]& <keyw>  }
#| scroll-snap-type: none | [ x | y | block | inline | both ] [ mandatory | proximity ]?
rule decl:sym<scroll-snap-type> { :i ("scroll-snap-type") ":" <val(/<css-val-scroll-snap-type> /, &?ROUTINE.WHY)>}
rule css-val-scroll-snap-type { :i none & <keyw> || [[x | y | block | inline | both ]& <keyw> ] [[mandatory | proximity ]& <keyw> ] ?   }