use Test;

use CSS::Module::CSS3;
use CSS::Grammar::Test;
use CSS::Writer;

my CSS::Writer $writer .= new;
my $module = CSS::Module::CSS3.module;

for (
    {:rule<at-rule>, input => q:to<END>,
     @font-face {
       font-family: Gentium;
       src: url(http://example.com/fonts/Gentium.woff);
       color: blue;
     }
     END
    :ast(:at-rule{:at-keyw<font-face>,
                  :declarations[
                           :property{:expr[:ident<Gentium>,], :ident<font-family>},
                           :property{:expr[ :expr[:url("http://example.com/fonts/Gentium.woff"),] ], :ident<src>}]}),
    :warnings[ "dropping unknown property: color" ],
    },
) -> % ( :$rule!, :$input!, *%expected ) {

    subtest $input, {
        CSS::Grammar::Test::parse-tests($input,
                                        :$module,
                                        :$rule,
                                        :$writer,
                                        :%expected );
    }
}

done-testing;
