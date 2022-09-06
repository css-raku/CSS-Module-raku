use v6;
use Test;
use CSS::Module::CSS3;

is-deeply CSS::Module::CSS3.module.property-number('foo'), Int;

my $module = CSS::Module::CSS3.module: :vivify;

my UInt:D $foo = $module.property-number('foo');
ok $foo;
my UInt:D $bar = $module.property-number('bar');
is-deeply $bar, $foo + 1;
is-deeply $module.property-number('bar'), $bar;

my $meta = $module.property-metadata;
is-deeply $meta<foo>, %(:!inherit);
is-deeply $meta<bar>, %(:!inherit);

done-testing;
