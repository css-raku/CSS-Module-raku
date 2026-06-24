unit grammar CSS::Snapshot2026::Color;

use CSS::Snapshot2026::Color::Gen::Grammar;
also is CSS::Snapshot2026::Color::Gen::Grammar;

token optional-comma {','?} # comma is becoming optional in many CSS4 functions, including, rgb(), rgba(), rect()
token alpha-channel-delim {<[,/]>}

#| usage: rgb(c c c) where c is 0..255 or 0%-100%
rule color:sym<rgb> {:i'rgb('
                          [ <c=.color-range> <.optional-comma>
                            <c=.color-range> <.optional-comma>
                            <c=.color-range>
                            [<.alpha-delim> <c=.percentage-range>]? || <usage(&?ROUTINE.WHY)> ]
               ')'
}

#| usage: rgba(c,c,c[,a]?) where c is 0..255 or 0%-100% and a is 0-1 or 0%-100%
rule color:sym<rgba> {:i'rgba('
                          [ <c=.color-range> <.optional-comma>
                            <c=.color-range> <.optional-comma>
                            <c=.color-range>
                            [<.alpha-delim> <c=.percentage-range>]? || <usage(&?ROUTINE.WHY)> ]
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
