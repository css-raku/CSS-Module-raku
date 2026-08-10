unit grammar CSS::Snapshot2026::WritingModes::Gen::Grammar;
#| direction: ltr | rtl
rule decl:sym<direction> { :i (direction) ":" <val(/<prop-val-direction> /, &?ROUTINE.WHY)>}
rule prop-val-direction { :i [ltr | rtl ]& <keyw>  }
#| glyph-orientation-vertical: auto | 0deg | 90deg | 0 | 90
rule decl:sym<glyph-orientation-vertical> { :i ("glyph-orientation-vertical") ":" <val(/<prop-val-glyph-orientation-vertical> /, &?ROUTINE.WHY)>}
rule prop-val-glyph-orientation-vertical { :i [auto | 0deg | 90deg ]& <keyw>  || [0 | 90 ]& <number>  }
#| text-combine-upright: none | all | [ digits <integer [2,4]>? ]
rule decl:sym<text-combine-upright> { :i ("text-combine-upright") ":" <val(/<prop-val-text-combine-upright> /, &?ROUTINE.WHY)>}
rule prop-val-text-combine-upright { :i [none | all ]& <keyw>  || [digits & <keyw> <integer> ? ]  }
#| text-orientation: mixed | upright | sideways
rule decl:sym<text-orientation> { :i ("text-orientation") ":" <val(/<prop-val-text-orientation> /, &?ROUTINE.WHY)>}
rule prop-val-text-orientation { :i [mixed | upright | sideways ]& <keyw>  }
#| unicode-bidi: normal | embed | isolate | bidi-override | isolate-override | plaintext
rule decl:sym<unicode-bidi> { :i ("unicode-bidi") ":" <val(/<prop-val-unicode-bidi> /, &?ROUTINE.WHY)>}
rule prop-val-unicode-bidi { :i [normal | embed | isolate | "bidi-override" | "isolate-override" | plaintext ]& <keyw>  }
#| writing-mode: horizontal-tb | vertical-rl | vertical-lr | sideways-rl | sideways-lr
rule decl:sym<writing-mode> { :i ("writing-mode") ":" <val(/<prop-val-writing-mode> /, &?ROUTINE.WHY)>}
rule prop-val-writing-mode { :i ["horizontal-tb" | "vertical-rl" | "vertical-lr" | "sideways-rl" | "sideways-lr" ]& <keyw>  }