unit grammar CSS::Snapshot2026::Scrolling::Gen::Grammar;
#| overflow-anchor: auto | none
rule decl:sym<overflow-anchor> { :i ("overflow-anchor") ":" <val(/<prop-val-overflow-anchor> /, &?ROUTINE.WHY)>}
rule prop-val-overflow-anchor { :i [auto | none ]& <keyw>  }
#| scrollbar-color: auto | <color>{2}
rule decl:sym<scrollbar-color> { :i ("scrollbar-color") ":" <val(/<prop-val-scrollbar-color> /, &?ROUTINE.WHY)>}
rule prop-val-scrollbar-color { :i [auto & <keyw> ] || <color> ** 2  }
#| scrollbar-width: auto | thin | none
rule decl:sym<scrollbar-width> { :i ("scrollbar-width") ":" <val(/<prop-val-scrollbar-width> /, &?ROUTINE.WHY)>}
rule prop-val-scrollbar-width { :i [auto | thin | none ]& <keyw>  }
#| scroll-margin: <length>{1,4}
rule decl:sym<scroll-margin> { :i ("scroll-margin") ":" <val(/<prop-val-scroll-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin { :i <length> }
#| scroll-margin-block: <length>{1,2}
rule decl:sym<scroll-margin-block> { :i ("scroll-margin-block") ":" <val(/<prop-val-scroll-margin-block> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-block { :i <length> ** 1..2 }
#| scroll-margin-block-end: <length>
rule decl:sym<scroll-margin-block-end> { :i ("scroll-margin-block-end") ":" <val(/<prop-val-scroll-margin-block-end> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-block-end { :i <length> }
#| scroll-margin-block-start: <length>
rule decl:sym<scroll-margin-block-start> { :i ("scroll-margin-block-start") ":" <val(/<prop-val-scroll-margin-block-start> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-block-start { :i <length> }
#| scroll-margin-bottom: <length>
rule decl:sym<scroll-margin-bottom> { :i ("scroll-margin-bottom") ":" <val(/<prop-val-scroll-margin-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-bottom { :i <length> }
#| scroll-margin-inline: <length>{1,2}
rule decl:sym<scroll-margin-inline> { :i ("scroll-margin-inline") ":" <val(/<prop-val-scroll-margin-inline> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-inline { :i <length> ** 1..2 }
#| scroll-margin-inline-end: <length>
rule decl:sym<scroll-margin-inline-end> { :i ("scroll-margin-inline-end") ":" <val(/<prop-val-scroll-margin-inline-end> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-inline-end { :i <length> }
#| scroll-margin-inline-start: <length>
rule decl:sym<scroll-margin-inline-start> { :i ("scroll-margin-inline-start") ":" <val(/<prop-val-scroll-margin-inline-start> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-inline-start { :i <length> }
#| scroll-margin-left: <length>
rule decl:sym<scroll-margin-left> { :i ("scroll-margin-left") ":" <val(/<prop-val-scroll-margin-left> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-left { :i <length> }
#| scroll-margin-right: <length>
rule decl:sym<scroll-margin-right> { :i ("scroll-margin-right") ":" <val(/<prop-val-scroll-margin-right> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-right { :i <length> }
#| scroll-margin-top: <length>
rule decl:sym<scroll-margin-top> { :i ("scroll-margin-top") ":" <val(/<prop-val-scroll-margin-top> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-margin-top { :i <length> }
#| scroll-padding: [ auto | <length-percentage [0,∞]> ]{1,4}
rule decl:sym<scroll-padding> { :i ("scroll-padding") ":" <val(/<prop-val-scroll-padding>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding { :i [[auto & <keyw> ] || <length-percentage> ] }
#| scroll-padding-block: [ auto | <length-percentage [0,∞]> ]{1,2}
rule decl:sym<scroll-padding-block> { :i ("scroll-padding-block") ":" <val(/<prop-val-scroll-padding-block> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-block { :i [[auto & <keyw> ] || <length-percentage> ] ** 1..2 }
#| scroll-padding-block-end: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-block-end> { :i ("scroll-padding-block-end") ":" <val(/<prop-val-scroll-padding-block-end> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-block-end { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-block-start: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-block-start> { :i ("scroll-padding-block-start") ":" <val(/<prop-val-scroll-padding-block-start> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-block-start { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-bottom: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-bottom> { :i ("scroll-padding-bottom") ":" <val(/<prop-val-scroll-padding-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-bottom { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-inline: [ auto | <length-percentage [0,∞]> ]{1,2}
rule decl:sym<scroll-padding-inline> { :i ("scroll-padding-inline") ":" <val(/<prop-val-scroll-padding-inline> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-inline { :i [[auto & <keyw> ] || <length-percentage> ] ** 1..2 }
#| scroll-padding-inline-end: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-inline-end> { :i ("scroll-padding-inline-end") ":" <val(/<prop-val-scroll-padding-inline-end> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-inline-end { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-inline-start: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-inline-start> { :i ("scroll-padding-inline-start") ":" <val(/<prop-val-scroll-padding-inline-start> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-inline-start { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-left: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-left> { :i ("scroll-padding-left") ":" <val(/<prop-val-scroll-padding-left> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-left { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-right: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-right> { :i ("scroll-padding-right") ":" <val(/<prop-val-scroll-padding-right> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-right { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-padding-top: auto | <length-percentage [0,∞]>
rule decl:sym<scroll-padding-top> { :i ("scroll-padding-top") ":" <val(/<prop-val-scroll-padding-top> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-padding-top { :i [auto & <keyw> ] || <length-percentage>  }
#| scroll-snap-align: [ none | start | end | center ]{1,2}
rule decl:sym<scroll-snap-align> { :i ("scroll-snap-align") ":" <val(/<prop-val-scroll-snap-align> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-snap-align { :i [[none | start | end | center ]& <keyw> ] ** 1..2 }
#| scroll-snap-stop: normal | always
rule decl:sym<scroll-snap-stop> { :i ("scroll-snap-stop") ":" <val(/<prop-val-scroll-snap-stop> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-snap-stop { :i [normal | always ]& <keyw>  }
#| scroll-snap-type: none | [ x | y | block | inline | both ] [ mandatory | proximity ]?
rule decl:sym<scroll-snap-type> { :i ("scroll-snap-type") ":" <val(/<prop-val-scroll-snap-type> /, &?ROUTINE.WHY)>}
rule prop-val-scroll-snap-type { :i [none & <keyw> ] || [[x | y | block | inline | both ]& <keyw> ] [[mandatory | proximity ]& <keyw> ] ?   }