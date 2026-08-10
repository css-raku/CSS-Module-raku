unit grammar CSS::Snapshot2026::Break::Gen::Grammar;
#| box-decoration-break: slice | clone
rule decl:sym<box-decoration-break> { :i ("box-decoration-break") ":" <val(/<prop-val-box-decoration-break> /, &?ROUTINE.WHY)>}
rule prop-val-box-decoration-break { :i [slice | clone ]& <keyw>  }
#| break-after: auto | avoid | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region
rule decl:sym<break-after> { :i ("break-after") ":" <val(/<prop-val-break-after> /, &?ROUTINE.WHY)>}
rule prop-val-break-after { :i [auto | avoid | "avoid-page" | page | left | right | recto | verso | "avoid-column" | column | "avoid-region" | region ]& <keyw>  }
#| break-before: auto | avoid | avoid-page | page | left | right | recto | verso | avoid-column | column | avoid-region | region
rule decl:sym<break-before> { :i ("break-before") ":" <val(/<prop-val-break-before> /, &?ROUTINE.WHY)>}
rule prop-val-break-before { :i [auto | avoid | "avoid-page" | page | left | right | recto | verso | "avoid-column" | column | "avoid-region" | region ]& <keyw>  }
#| break-inside: auto | avoid | avoid-page | avoid-column | avoid-region
rule decl:sym<break-inside> { :i ("break-inside") ":" <val(/<prop-val-break-inside> /, &?ROUTINE.WHY)>}
rule prop-val-break-inside { :i [auto | avoid | "avoid-page" | "avoid-column" | "avoid-region" ]& <keyw>  }
#| orphans: <integer [1,∞]>
rule decl:sym<orphans> { :i (orphans) ":" <val(/<prop-val-orphans> /, &?ROUTINE.WHY)>}
rule prop-val-orphans { :i <integer> }
#| widows: <integer [1,∞]>
rule decl:sym<widows> { :i (widows) ":" <val(/<prop-val-widows> /, &?ROUTINE.WHY)>}
rule prop-val-widows { :i <integer> }