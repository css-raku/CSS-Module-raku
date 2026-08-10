unit grammar CSS::Snapshot2026::UI::Gen::Grammar;
#| box-sizing: content-box | border-box
rule decl:sym<box-sizing> { :i ("box-sizing") ":" <val(/<prop-val-box-sizing> /, &?ROUTINE.WHY)>}
rule prop-val-box-sizing { :i ["content-box" | "border-box" ]& <keyw>  }
#| caret-color: auto | <color>
rule decl:sym<caret-color> { :i ("caret-color") ":" <val(/<prop-val-caret-color> /, &?ROUTINE.WHY)>}
rule prop-val-caret-color { :i auto & <keyw> || <color>  }
#| cursor: [<cursor-image>,]* <cursor-predefined>
rule decl:sym<cursor> { :i (cursor) ":" <val(/<prop-val-cursor> /, &?ROUTINE.WHY)>}
rule prop-val-cursor { :i [<cursor-image> <op(",")> ] * <cursor-predefined>  }
#| <cursor-image> = <url> <number>{2}?
rule cursor-image { :i <url> [<number> ** 2] ?  }
#| <cursor-predefined> = auto | default | none |  context-menu | help | pointer | progress | wait |  cell | crosshair | text | vertical-text |  alias | copy | move | no-drop | not-allowed | grab | grabbing |  e-resize | n-resize | ne-resize | nw-resize | s-resize | se-resize | sw-resize | w-resize |  ew-resize | ns-resize | nesw-resize | nwse-resize |  col-resize | row-resize | all-scroll |  zoom-in | zoom-out
rule cursor-predefined { :i [auto | default | none | "context-menu" | help | pointer | progress | wait | cell | crosshair | text | "vertical-text" | alias | copy | move | "no-drop" | "not-allowed" | grab | grabbing | "e-resize" | "n-resize" | "ne-resize" | "nw-resize" | "s-resize" | "se-resize" | "sw-resize" | "w-resize" | "ew-resize" | "ns-resize" | "nesw-resize" | "nwse-resize" | "col-resize" | "row-resize" | "all-scroll" | "zoom-in" | "zoom-out" ]& <keyw>  }
#| outline: [ <'outline-color'> || <'outline-style'> || <'outline-width'> ]
rule decl:sym<outline> { :i (outline) ":" <val(/<prop-val-outline> /, &?ROUTINE.WHY)>}
rule prop-val-outline { :i [[<prop-val-outline-color> :my $*A;<!{
    $*A++
}>|| <prop-val-outline-style> :my $*B;<!{
    $*B++
}>|| <prop-val-outline-width> :my $*C;<!{
    $*C++
}>]+] }
#| outline-color: <color> | invert
rule decl:sym<outline-color> { :i ("outline-color") ":" <val(/<prop-val-outline-color> /, &?ROUTINE.WHY)>}
rule prop-val-outline-color { :i <color> || invert & <keyw>  }
#| outline-offset: <length>
rule decl:sym<outline-offset> { :i ("outline-offset") ":" <val(/<prop-val-outline-offset> /, &?ROUTINE.WHY)>}
rule prop-val-outline-offset { :i <length> }
#| outline-style: auto | <.'border-style'>
rule decl:sym<outline-style> { :i ("outline-style") ":" <val(/<prop-val-outline-style> /, &?ROUTINE.WHY)>}
rule prop-val-outline-style { :i auto & <keyw> || <prop-val-border-style>  }
#| outline-width: <line-width>
rule decl:sym<outline-width> { :i ("outline-width") ":" <val(/<prop-val-outline-width> /, &?ROUTINE.WHY)>}
rule prop-val-outline-width { :i <line-width> }
#| resize: none | both | horizontal | vertical
rule decl:sym<resize> { :i (resize) ":" <val(/<prop-val-resize> /, &?ROUTINE.WHY)>}
rule prop-val-resize { :i [none | both | horizontal | vertical ]& <keyw>  }
#| text-overflow: clip | ellipsis
rule decl:sym<text-overflow> { :i ("text-overflow") ":" <val(/<prop-val-text-overflow> /, &?ROUTINE.WHY)>}
rule prop-val-text-overflow { :i [clip | ellipsis ]& <keyw>  }