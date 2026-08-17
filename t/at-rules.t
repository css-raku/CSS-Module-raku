use Test;

use CSS::Module::CSS3;
use CSS::Module::Snapshot2026;
use CSS::Grammar::Test;
use CSS::Writer;

my CSS::Writer $writer .= new;
my $css3 = CSS::Module::CSS3.module;
my $snapshot2026 = CSS::Module::Snapshot2026.module;

for (
    {:rule<at-rule>, input => q:to<END>,
     @color-profile --swopc {
       src: url('http://example.org/swop-coated.icc');
       color: blue;
     }
     END
     :ast(:at-rule{:at-keyw<color-profile>,
                   :declarations[
                            :property{:expr[{:url("http://example.org/swop-coated.icc")},], :ident<src>}
                        ],
                   :ident<--swopc> }),
     :warnings[ "dropping unknown property: color" ],
    },
    {:rule<at-rule>, input => q:to<END>,
     @font-face {
       font-family: Gentium;
       src: url(http://example.com/fonts/Gentium.woff);
       color: blue;
     }
     END
    :ast(:at-rule{:at-keyw<font-face>,
                  :declarations[
                           :property{:expr[{:ident<Gentium>},], :ident<font-family>},
                           :property{:expr[{:url("http://example.com/fonts/Gentium.woff")},], :ident<src>}]}),
    :warnings[ "dropping unknown property: color" ],
    },
) -> % ( :$rule!, :$input!, *%expected ) {

    for $snapshot2026 -> $module {
        CSS::Grammar::Test::parse-tests($input,
                                        :$module,
				        :$rule,
                                        :$writer,
				        :%expected );
    }
}

done-testing;
