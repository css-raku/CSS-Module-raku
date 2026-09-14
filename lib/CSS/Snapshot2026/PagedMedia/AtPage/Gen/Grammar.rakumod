unit grammar CSS::Snapshot2026::PagedMedia::AtPage::Gen::Grammar;
#| @page [<page-selector-list>?] <declarations>
rule decl:sym<@page> { "\@"<at-rule=.at-rule-page>}
rule at-rule-page { (:i page) [<page-selector-list> ?] <declarations> }
#| <page-selector-list> = <page-selector>#
rule page-selector-list { :i <page-selector> + % <op(",")>? }
#| <page-selector> = [ <ident>? <pseudo-page>* ]!
rule page-selector { :i [<Ident> ? <pseudo-page> * ] }
#| <pseudo-page> = ':' [ left | right | first | blank ]
rule pseudo-page { :i <op(":")> [[left | right | first | blank ]& <keyw> ] }
#| @top-left-corner <declarations>;?
rule decl:sym<@top-left-corner> { "\@"<at-rule=.at-rule-top-left-corner>}
rule at-rule-top-left-corner { (:i "top-left-corner") <declarations> [";"] ? }
#| @top-left <declarations>;?
rule decl:sym<@top-left> { "\@"<at-rule=.at-rule-top-left>}
rule at-rule-top-left { (:i "top-left") <declarations> [";"] ? }
#| @top-center <declarations>;?
rule decl:sym<@top-center> { "\@"<at-rule=.at-rule-top-center>}
rule at-rule-top-center { (:i "top-center") <declarations> [";"] ? }
#| @top-right <declarations>;?
rule decl:sym<@top-right> { "\@"<at-rule=.at-rule-top-right>}
rule at-rule-top-right { (:i "top-right") <declarations> [";"] ? }
#| @top-right-corner <declarations>;?
rule decl:sym<@top-right-corner> { "\@"<at-rule=.at-rule-top-right-corner>}
rule at-rule-top-right-corner { (:i "top-right-corner") <declarations> [";"] ? }
#| @bottom-left-corner <declarations>;?
rule decl:sym<@bottom-left-corner> { "\@"<at-rule=.at-rule-bottom-left-corner>}
rule at-rule-bottom-left-corner { (:i "bottom-left-corner") <declarations> [";"] ? }
#| @bottom-left <declarations>;?
rule decl:sym<@bottom-left> { "\@"<at-rule=.at-rule-bottom-left>}
rule at-rule-bottom-left { (:i "bottom-left") <declarations> [";"] ? }
#| @bottom-center <declarations>;?
rule decl:sym<@bottom-center> { "\@"<at-rule=.at-rule-bottom-center>}
rule at-rule-bottom-center { (:i "bottom-center") <declarations> [";"] ? }
#| @bottom-right <declarations>;?
rule decl:sym<@bottom-right> { "\@"<at-rule=.at-rule-bottom-right>}
rule at-rule-bottom-right { (:i "bottom-right") <declarations> [";"] ? }
#| @bottom-right-corner <declarations>;?
rule decl:sym<@bottom-right-corner> { "\@"<at-rule=.at-rule-bottom-right-corner>}
rule at-rule-bottom-right-corner { (:i "bottom-right-corner") <declarations> [";"] ? }
#| @left-top <declarations>;?
rule decl:sym<@left-top> { "\@"<at-rule=.at-rule-left-top>}
rule at-rule-left-top { (:i "left-top") <declarations> [";"] ? }
#| @left-middle <declarations>;?
rule decl:sym<@left-middle> { "\@"<at-rule=.at-rule-left-middle>}
rule at-rule-left-middle { (:i "left-middle") <declarations> [";"] ? }
#| @left-bottom <declarations>;?
rule decl:sym<@left-bottom> { "\@"<at-rule=.at-rule-left-bottom>}
rule at-rule-left-bottom { (:i "left-bottom") <declarations> [";"] ? }
#| @right-top <declarations>;?
rule decl:sym<@right-top> { "\@"<at-rule=.at-rule-right-top>}
rule at-rule-right-top { (:i "right-top") <declarations> [";"] ? }
#| @right-middle <declarations>;?
rule decl:sym<@right-middle> { "\@"<at-rule=.at-rule-right-middle>}
rule at-rule-right-middle { (:i "right-middle") <declarations> [";"] ? }
#| @right-bottom <declarations>;?
rule decl:sym<@right-bottom> { "\@"<at-rule=.at-rule-right-bottom>}
rule at-rule-right-bottom { (:i "right-bottom") <declarations> [";"] ? }
#| bleed: auto | <length>
rule decl:sym<bleed> { :i (bleed) ":" <val(/<prop-val-bleed> /, &?ROUTINE.WHY)>}
rule prop-val-bleed { :i [auto & <keyw> ] || <length> }
#| marks: none | [ crop || cross ]
rule decl:sym<marks> { :i (marks) ":" <val(/<prop-val-marks> /, &?ROUTINE.WHY)>}
rule prop-val-marks { :i [none & <keyw> ] || [[[crop & <keyw> ] :my $*A; <!{
    $*A++
}>|| [cross & <keyw> ] :my $*B; <!{
    $*B++
}>]+] }
#| page-orientation: upright | rotate-left | rotate-right
rule decl:sym<page-orientation> { :i ("page-orientation") ":" <val(/<prop-val-page-orientation> /, &?ROUTINE.WHY)>}
rule prop-val-page-orientation { :i [upright | "rotate-left" | "rotate-right" ]& <keyw> }
#| size: <length>{1,2} | auto | [ <page-size> || [ portrait | landscape ] ]
rule decl:sym<size> { :i (size) ":" <val(/<prop-val-size> /, &?ROUTINE.WHY)>}
rule prop-val-size { :i <length> ** 1..2 || [auto & <keyw> ] || [[<page-size> :my $*A; <!{
    $*A++
}>|| [[portrait | landscape ]& <keyw> ] :my $*B; <!{
    $*B++
}>]+] }
#| <page-size> = a3 | a4 | a5 | b4 | b5 | jis-b4 | jis-b5 | letter | legal | ledger
rule page-size { :i [a3 | a4 | a5 | b4 | b5 | "jis-b4" | "jis-b5" | letter | legal | ledger ]& <keyw> }
#| margin: <margin-width>{1,4}
rule decl:sym<margin> { :i (margin) ":" <val(/<prop-val-margin>** 1..4 /, &?ROUTINE.WHY)>}
rule prop-val-margin { :i <margin-width> }
#| <margin-width> = <length-percentage> | auto
rule margin-width { :i <length-percentage> || [auto & <keyw> ] }
#| margin-bottom: <margin-width>
rule decl:sym<margin-bottom> { :i ("margin-bottom") ":" <val(/<prop-val-margin-bottom> /, &?ROUTINE.WHY)>}
rule prop-val-margin-bottom { :i <margin-width> }
#| margin-left: <margin-width>
rule decl:sym<margin-left> { :i ("margin-left") ":" <val(/<prop-val-margin-left> /, &?ROUTINE.WHY)>}
rule prop-val-margin-left { :i <margin-width> }
#| margin-right: <margin-width>
rule decl:sym<margin-right> { :i ("margin-right") ":" <val(/<prop-val-margin-right> /, &?ROUTINE.WHY)>}
rule prop-val-margin-right { :i <margin-width> }
#| margin-top: <margin-width>
rule decl:sym<margin-top> { :i ("margin-top") ":" <val(/<prop-val-margin-top> /, &?ROUTINE.WHY)>}
rule prop-val-margin-top { :i <margin-width> }
