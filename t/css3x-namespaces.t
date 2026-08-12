#!/usr/bin/env perl6

use Test;

use CSS::Module::CSS3;
use CSS::Module::Snapshot2026;
use CSS::Grammar::Test;
use CSS::Writer;

my CSS::Writer $writer .= new;
my $css3 = CSS::Module::CSS3.module;
my $snapshot2026 = CSS::Module::Snapshot2026.module;

for (
    {:rule<at-decl>, :input('@namespace empty "";'),
     :ast(:at-rule{ :ns-prefix<empty>, :url(""), :at-keyw<namespace>}),
    },
    {:rule<at-decl>, :input('@NAMESPACE "";'),
     :ast(:at-rule{ :url(""), :at-keyw<namespace>}),
    },
    {:rule<at-decl>, :input('@namespace "http://www.w3.org/1999/xhtml";'),
     :ast(:at-rule{ :url<http://www.w3.org/1999/xhtml>, :at-keyw<namespace>}),
    },
    {:rule<at-decl>, :input('@namespace svg "http://www.w3.org/2000/svg";'),
     :ast(:at-rule{ :ns-prefix<svg>, :url<http://www.w3.org/2000/svg>, :at-keyw<namespace>}),
    },
    {:rule<stylesheet>, :input('@namespace toto url(http://toto.example.org);'),
     :ast(:stylesheet[{ :at-rule{ :ns-prefix<toto>, :url<http://toto.example.org>, :at-keyw<namespace>}}]),
    },
) -> % ( :$rule!, :$input!, *%expected ) {

    for $css3, $snapshot2026 -> $module {
        CSS::Grammar::Test::parse-tests($input,
                                        :$module,
				        :$rule,
                                        :$writer,
				        :%expected );
    }
}

done-testing;
