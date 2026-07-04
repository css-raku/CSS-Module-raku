unit grammar CSS::Snapshot2026::UI::Gen::Grammar;
#| box-sizing: content-box | border-box
rule decl:sym<box-sizing> { :i ("box-sizing") ":" <val(/<css-val-box-sizing> /, &?ROUTINE.WHY)>}
rule css-val-box-sizing { :i ["content-box" | "border-box" ]& <keyw>  }
#| caret-color: auto | <color>
rule decl:sym<caret-color> { :i ("caret-color") ":" <val(/<css-val-caret-color> /, &?ROUTINE.WHY)>}
rule css-val-caret-color { :i auto & <keyw> || <color>  }
#| cursor: [<cursor-image>,]* <cursor-predefined>
rule decl:sym<cursor> { :i (cursor) ":" <val(/<css-val-cursor> /, &?ROUTINE.WHY)>}
rule css-val-cursor { :i [<cursor-image> <op(",")> ] * <cursor-predefined>  }
#| <cursor-image> = <url> <number>{2}?
rule cursor-image { :i <url> [<number> ** 2] ?  }
#| <cursor-predefined> = auto | default | none |  context-menu | help | pointer | progress | wait |  cell | crosshair | text | vertical-text |  alias | copy | move | no-drop | not-allowed | grab | grabbing |  e-resize | n-resize | ne-resize | nw-resize | s-resize | se-resize | sw-resize | w-resize |  ew-resize | ns-resize | nesw-resize | nwse-resize |  col-resize | row-resize | all-scroll |  zoom-in | zoom-out
rule cursor-predefined { :i [auto | default | none | "context-menu" | help | pointer | progress | wait | cell | crosshair | text | "vertical-text" | alias | copy | move | "no-drop" | "not-allowed" | grab | grabbing | "e-resize" | "n-resize" | "ne-resize" | "nw-resize" | "s-resize" | "se-resize" | "sw-resize" | "w-resize" | "ew-resize" | "ns-resize" | "nesw-resize" | "nwse-resize" | "col-resize" | "row-resize" | "all-scroll" | "zoom-in" | "zoom-out" ]& <keyw>  }
#| outline: [ <'outline-color'> || <'outline-style'> || <'outline-width'> ]
rule decl:sym<outline> { :i (outline) ":" <val(/<css-val-outline> /, &?ROUTINE.WHY)>}
rule css-val-outline { :i [[<css-val-outline-color> :my $*A;<!{
    $*A++
}>|| <css-val-outline-style> :my $*B;<!{
    $*B++
}>|| <css-val-outline-width> :my $*C;<!{
    $*C++
}>]+] }
#| outline-color: <color> | invert
rule decl:sym<outline-color> { :i ("outline-color") ":" <val(/<css-val-outline-color> /, &?ROUTINE.WHY)>}
rule css-val-outline-color { :i <color> || invert & <keyw>  }
#| outline-offset: <length>
rule decl:sym<outline-offset> { :i ("outline-offset") ":" <val(/<css-val-outline-offset> /, &?ROUTINE.WHY)>}
rule css-val-outline-offset { :i <length> }
#| outline-style: auto | <'border-style'>
rule decl:sym<outline-style> { :i ("outline-style") ":" <val(/<css-val-outline-style> /, &?ROUTINE.WHY)>}
rule css-val-outline-style { :i auto & <keyw> || <css-val-border-style>  }
#| outline-width: <line-width>
rule decl:sym<outline-width> { :i ("outline-width") ":" <val(/<css-val-outline-width> /, &?ROUTINE.WHY)>}
rule css-val-outline-width { :i <line-width> }
#| resize: none | both | horizontal | vertical
rule decl:sym<resize> { :i (resize) ":" <val(/<css-val-resize> /, &?ROUTINE.WHY)>}
rule css-val-resize { :i [none | both | horizontal | vertical ]& <keyw>  }
#| text-overflow: clip | ellipsis
rule decl:sym<text-overflow> { :i ("text-overflow") ":" <val(/<css-val-text-overflow> /, &?ROUTINE.WHY)>}
rule css-val-text-overflow { :i [clip | ellipsis ]& <keyw>  }