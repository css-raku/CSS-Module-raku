#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Language::CSS1::Actions;
use CSS::Language::CSS1;

use CSS::Language::CSS21::Actions;
use CSS::Language::CSS21;

use CSS::Language::CSS3;

use CSS::Grammar::Test;

my $css1_actions = CSS::Language::CSS1::Actions.new;
my $css21_actions = CSS::Language::CSS21::Actions.new;
my $css3_actions = CSS::Language::CSS3::Actions.new;

my %seen;

my $fh = open 't/css1-properties.json', :r;

for ( $fh.lines ) {

    if .substr(0,2) eq '//' {
##        note '[' ~ .substr(2) ~ ']';
        next;
    }

    my %test = %( from-json($_) );
    my $prop = %test<prop>;

    my %declarations;

    if %test<box> {
        for @(%test<box>) {
            my ($edge, $val) = .kv;
            %declarations{$prop.lc ~ '-' ~ $edge} = {expr => $val}
        }
    }
    else {
        %declarations{ $prop.lc } = {expr => %test<expr>};
    }

    %test<ast> = %declarations;

    my $input = $prop ~ ':' ~ %test<decl>;

    $css1_actions.reset;
    my $p1 = CSS::Language::CSS1.parse( $input, :rule('declaration-list'), :actions($css1_actions));
    CSS::Grammar::Test::parse_tests($input, $p1, :rule('decl'), :suite('css1'),
                         :warnings($css1_actions.warnings),
                         :expected(%test) );

    $css21_actions.reset;
    my $p21 = CSS::Language::CSS21.parse( $input, :rule('declaration-list'), :actions($css21_actions));
    CSS::Grammar::Test::parse_tests($input, $p21, :rule('decl'), :suite('css21'),
                         :warnings($css21_actions.warnings),
                         :expected(%test) );

    $css3_actions.reset;
    my $p3 = CSS::Language::CSS3.parse( $input, :rule('declaration-list'), :actions($css3_actions));
    CSS::Grammar::Test::parse_tests($input, $p3, :rule('decl'), :suite('css3'),
                         :warnings($css3_actions.warnings),
                         :expected(%test) );

    unless %seen{$prop.lc}++ {
        # usage and inheritence  tests
        my $junk = $prop ~ ': junk +-42';

        $css1_actions.reset;
        $p1 = CSS::Language::CSS1.parse( $junk, :rule('declaration-list'), :actions($css1_actions));
        is($p1.Str, $junk, "$prop: able to parse unexpected input");

        ok($css1_actions.warnings.grep({/^usage:/}), "css1 $prop : unexpected input produces warning")
            or diag $css1_actions.warnings;

        $css21_actions.reset;
        $p21 = CSS::Language::CSS21.parse( $junk, :rule('declaration-list'), :actions($css21_actions));
        is($p21.Str, $junk, "css21 $prop: able to parse unexpected input");

        $css3_actions.reset;
        $p3 = CSS::Language::CSS3.parse( $junk, :rule('declaration-list'), :actions($css3_actions));
        is($p3.Str, $junk, "css3 $prop: able to parse unexpected input");

       ok($css3_actions.warnings, "$prop : unexpected input produces warning")
            or diag $css3_actions.warnings;

        for <inherit initial> -> $misc {
            my $decl = $prop ~ ': ' ~ $misc;

            my @_expr = ($misc => True);
            my %ast = %test<box>
                ?? <top right bottom left>.map({($prop.lc ~ '-' ~ $_) => [expr => @_expr]})
                !! ($prop.lc => [expr => @_expr]);

            unless $misc eq 'initial' { # applicable to css3 only
                $css21_actions.reset;
                $p21 = CSS::Language::CSS21.parse( $decl, :rule('declaration-list'), :actions($css21_actions));

                CSS::Grammar::Test::parse_tests($decl, $p21, :rule('declaration-list'), :suite('css21'),
                                    :warnings($css21_actions.warnings),
                                    :expected({ast => %ast}) );

            }

            $css3_actions.reset;
            $p3 = CSS::Language::CSS3.parse( $decl, :rule('declaration-list'), :actions($css3_actions));

            CSS::Grammar::Test::parse_tests($decl, $p3, :rule('decl'), :suite('css3'),
                                :warnings($css3_actions.warnings),
                                :expected({ast => %ast}) );
        }
    }

}

done;
