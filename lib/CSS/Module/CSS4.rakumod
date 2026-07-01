unit grammar CSS::Module::CSS4;

use CSS::Snapshot2026::Box::Gen::Grammar;
also is  CSS::Snapshot2026::Box::Gen::Grammar;

use CSS::Module::SVG;
also is CSS::Module::SVG;

token optional-comma {','?} # comma is becoming optional in many CSS4 functions, including, rgb(), rgba(), rect()
token alpha-channel-delim {<[,/]>}

#| usage: rgb(c c c) where c is 0..255 or 0%-100%
rule color:sym<rgb> {:i'rgb('
                          [ <c=.color-range> <.optional-comma>
                            <c=.color-range> <.optional-comma>
                            <c=.color-range>
                            [<.alpha-channel-delim> <c=.percentage-range>]? || <usage(&?ROUTINE.WHY)> ]
               ')'
}

#| usage: rgba(c,c,c[,a]?) where c is 0..255 or 0%-100% and a is 0-1 or 0%-100%
rule color:sym<rgba> {:i'rgba('
                          [ <c=.color-range> <.optional-comma>
                            <c=.color-range> <.optional-comma>
                            <c=.color-range>
                            [<.alpha-channel-delim> <c=.percentage-range>]? || <usage(&?ROUTINE.WHY)> ]
               ')'
}
#| usage: hsl(h,s,l) where h is 0..360  and s,l are 0-1 or 0%-100%
rule color:sym<hsl> {:i'hsl('
                         [ <c=.color-angle> <.optional-comma>
                           <c=.percentage-range> <.optional-comma>
                           <c=.percentage-range> || <usage(&?ROUTINE.WHY)> ]
                ')'
}

#| usage: hsla(h,s,l,a) where h is 0..360  and s,l,a are 0-1 or 0%-100%
rule color:sym<hsla> {:i'hsla('
                          [ <c=.color-angle> <.optional-comma>
                            <c=.percentage-range> <.optional-comma>
                            <c=.percentage-range> <.optional-comma>
                            <c=.percentage-range> || <usage(&?ROUTINE.WHY)> ]
               ')'
}

method module(|c) {
    use CSS::Module::CSS4::Actions;
    use CSS::Module::CSS4::Metadata;
    use CSS::Module::CSS3::Fonts::AtFontFace;
    my constant Metadata = CSS::Module::CSS4::Metadata;
    CSS::Module.new(
        :name<CSS4>,
        :grammar($?CLASS),
        :actions(CSS::Module::CSS4::Actions),
        :property-metadata($Metadata::property),
        :prop-names(Metadata::prop-names),
        :index(&Metadata::index),
        :sub-module('@font-face' => CSS::Module::CSS3::Fonts::AtFontFace.module),
        |c
        );
}
