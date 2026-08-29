unit grammar CSS::Snapshot2026::Animations::AtKeyFrames::Gen::Grammar;
#| @keyframes <keyframes-name> { <keyframe-block>* }
rule decl:sym<@keyframes> { "\@"<at-rule=.at-rule-keyframes>}
rule at-rule-keyframes { (:i keyframes) <keyframes-name> "\{" <keyframe-block> * "}"  }
#| <keyframes-name> = <custom-ident> | <string>
rule keyframes-name { :i <custom-ident> || <string>  }
#| <keyframe-block> = <keyframe-selector># { <declaration-list> }
rule keyframe-block { :i <keyframe-selector> +% <op(",")>? "\{" <declaration-list> "}"  }
#| <keyframe-selector> = from | to | <percentage [0,100]>
rule keyframe-selector { :i [from | to ]& <keyw>  || <percentage>  }