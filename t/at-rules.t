use Test;

use CSS::Module::CSS3;
use CSS::Module::Snapshot2026;
use CSS::Grammar::Test;
use CSS::Writer;

my CSS::Writer $writer .= new;
my $css3 = CSS::Module::CSS3.module;
my $snapshot2026 = CSS::Module::Snapshot2026.module;

for (
{:rule<at-rule>, input => q:to<END>, :ast(:at-rule{:at-keyw<color-profile>, :declarations[:property{:expr[{:url("http://example.org/swop-coated.icc")},], :ident<src>}], :ident<--swopc> })},
@color-profile --swopc {
  src: url('http://example.org/swop-coated.icc');
}
END
    
) -> % ( :$rule!, :$input!, *%expected ) {

    for $snapshot2026 -> $module {
        CSS::Grammar::Test::parse-tests($input,
                                        :$module,
				        :$rule,
##todo                                        :$writer,
				        :%expected );
    }
}

done-testing;
