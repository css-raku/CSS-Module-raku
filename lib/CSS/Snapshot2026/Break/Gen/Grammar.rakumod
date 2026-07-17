unit grammar CSS::Snapshot2026::Break::Gen::Grammar;
#| box-decoration-break: slice | clone
rule decl:sym<box-decoration-break> { :i ("box-decoration-break") ":" <val(/<css-val-box-decoration-break> /, &?ROUTINE.WHY)>}
rule css-val-box-decoration-break { :i [slice | clone ]& <keyw>  }
#| break-after: auto | avoid | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region
rule decl:sym<break-after> { :i ("break-after") ":" <val(/<css-val-break-after> /, &?ROUTINE.WHY)>}
rule css-val-break-after { :i [auto | avoid | "avoid-page" | page | left | right | recto | verso | "avoid-column" | column | "avoid-region" | region ]& <keyw>  }
#| break-before: auto | avoid | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region
rule decl:sym<break-before> { :i ("break-before") ":" <val(/<css-val-break-before> /, &?ROUTINE.WHY)>}
rule css-val-break-before { :i [auto | avoid | "avoid-page" | page | left | right | recto | verso | "avoid-column" | column | "avoid-region" | region ]& <keyw>  }
#| break-inside: auto | avoid | avoid-page | avoid-column | avoid-region
rule decl:sym<break-inside> { :i ("break-inside") ":" <val(/<css-val-break-inside> /, &?ROUTINE.WHY)>}
rule css-val-break-inside { :i [auto | avoid | "avoid-page" | "avoid-column" | "avoid-region" ]& <keyw>  }
#| orphans: <integer [1,∞]>
rule decl:sym<orphans> { :i (orphans) ":" <val(/<css-val-orphans> /, &?ROUTINE.WHY)>}
rule css-val-orphans { :i <integer> }
#| widows: <integer [1,∞]>
rule decl:sym<widows> { :i (widows) ":" <val(/<css-val-widows> /, &?ROUTINE.WHY)>}
rule css-val-widows { :i <integer> }