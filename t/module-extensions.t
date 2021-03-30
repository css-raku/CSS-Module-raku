use v6;
use Test;
use CSS::Module::CSS3;

subset MyAlignment of Str where 'left'|'middle'|'right';
sub coerce(MyAlignment:D $keyw --> Pair) { :$keyw }

my %extensions =  %(
    '-my-align' => %(:synopsis("left | middle | right"),
                     :default<middle>,
                     :&coerce
                    ),
);

my $module = CSS::Module::CSS3.module: :%extensions;

is $module.index.tail(2)[0].name, 'z-index', 'index';
is $module.index.tail.name, '-my-align', 'index';
is $module.property-number('-my-align'), $module.index.elems-1, 'module property-number';

is $module.name, 'CSS3', 'module.name';
isa-ok $module.grammar, ::('CSS::Module::CSS3'), 'css3 grammar';
isa-ok $module.actions, ::('CSS::Module::CSS3::Actions'), 'css3 actions';
my $meta = $module.property-metadata;
is-deeply $meta<-my-align>, {:default["middle", [:keyw<middle>,]], :!inherit, :synopsis("left | middle | right")}, 'extension property';

my $module2 = CSS::Module::CSS3.module;
my $meta2 = $module2.property-metadata;
nok $meta2<-my-align>:exists, 'extensions are isolated';

done-testing;
