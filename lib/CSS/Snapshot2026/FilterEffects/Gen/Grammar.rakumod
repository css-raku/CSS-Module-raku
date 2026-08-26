unit grammar CSS::Snapshot2026::FilterEffects::Gen::Grammar;
#| color-interpolation-filters: auto | sRGB | linearRGB
rule decl:sym<color-interpolation-filters> { :i ("color-interpolation-filters") ":" <val(/<prop-val-color-interpolation-filters> /, &?ROUTINE.WHY)>}
rule prop-val-color-interpolation-filters { :i [auto | sRGB | linearRGB ]& <keyw>  }
#| filter: none | <filter-value-list>
rule decl:sym<filter> { :i (filter) ":" <val(/<prop-val-filter> /, &?ROUTINE.WHY)>}
rule prop-val-filter { :i [none & <keyw> ] || <filter-value-list>  }
#| <filter-value-list> = [ <filter-function> | <url> ]+
rule filter-value-list { :i [<filter-function> || <url> ] + }
#| <filter-function> = <blur()> | <brightness()> | <contrast()> | <drop-shadow()> |  <grayscale()> | <hue-rotate()> | <invert()> | <opacity()> | <sepia()> | <saturate()>
rule filter-function { :i <blur> || <brightness> || <contrast> || <drop-shadow> || <grayscale> || <hue-rotate> || <invert> || <opacity> || <sepia> || <saturate>  }
#| blur( <length>? )
rule blur { :i "blur(" [<length> ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| brightness( [ <number> |  <percentage> ]? )
rule brightness { :i "brightness(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| contrast( [ <number> |  <percentage> ]? )
rule contrast { :i "contrast(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| drop-shadow( [ <color>? && <length>{2,3} ] )
rule drop-shadow { :i "drop-shadow(" [[[<color> ? :my $*A;<!{
    $*A++
}>|| <length> ** 2..3 :my $*B;<!{
    $*B++
}>]** 2] || <usage(&?ROUTINE.WHY)> ] ")" }
#| grayscale( [ <number> |  <percentage> ]? )
rule grayscale { :i "grayscale(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| hue-rotate( [ <angle> | <zero> ]? )
rule hue-rotate { :i "hue-rotate(" [[<angle> || <zero> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| invert( [ <number> |  <percentage> ]? )
rule invert { :i "invert(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| opacity( [ <number> |  <percentage> ]? )
rule opacity { :i "opacity(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| saturate( [ <number> |  <percentage> ]? )
rule saturate { :i "saturate(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| sepia( [ <number> |  <percentage> ]? )
rule sepia { :i "sepia(" [[<number> || <percentage> ] ? || <usage(&?ROUTINE.WHY)> ] ")" }
#| flood-color: <color>
rule decl:sym<flood-color> { :i ("flood-color") ":" <val(/<prop-val-flood-color> /, &?ROUTINE.WHY)>}
rule prop-val-flood-color { :i <color> }
#| flood-opacity: <'opacity'>
rule decl:sym<flood-opacity> { :i ("flood-opacity") ":" <val(/<prop-val-flood-opacity> /, &?ROUTINE.WHY)>}
rule prop-val-flood-opacity { :i <prop-val-opacity> }
#| lighting-color: <color>
rule decl:sym<lighting-color> { :i ("lighting-color") ":" <val(/<prop-val-lighting-color> /, &?ROUTINE.WHY)>}
rule prop-val-lighting-color { :i <color> }