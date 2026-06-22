unit grammar CSS::Module::CSS4::Color::Gen::Grammar;
#| <opacity-value> = <number> | <percentage>
rule opacity-value { :i <number> || <percentage>  }
#| color: <color>
rule decl:sym<color> { :i (color) ":" <val(/<css-val-color> /, &?ROUTINE.WHY)>}
rule css-val-color { :i <color> }
#| opacity: <opacity-value>
rule decl:sym<opacity> { :i (opacity) ":" <val(/<css-val-opacity> /, &?ROUTINE.WHY)>}
rule css-val-opacity { :i <opacity-value> }