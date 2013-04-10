#!perl6

use CSS::Language::Specification;

my $fh = open("etc/css1-properties.txt");

for $fh.lines {
    my $/ = CSS::Language::Specification.parse($_, :rule('property-spec'));
    next note "bad: $_" unless $/;
}
