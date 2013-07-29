#!/usr/bin/env perl6

use Test;
use JSON::Tiny;

use CSS::Language::CSS21;
use CSS::Language::CSS21::Actions;
use CSS::Language::CSS3;
use CSS::Grammar::Test;

my $css21_actions = CSS::Language::CSS21::Actions.new;
my $css3_actions = CSS::Language::CSS3::Actions.new;

my %seen;

my $fh = open 't/css21-properties.json', :r;

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

    %declarations<_implied> = %test<_implied> if %test<_implied>;
    %test<ast> = %declarations;

    my $input = $prop ~ ':' ~ %test<decl>;

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
        my $junk = $prop ~ ': junk "x" 42';

        $css21_actions.reset;
        $p21 = CSS::Language::CSS21.parse( $junk, :rule('declaration-list'), :actions($css21_actions));
        is($p21.Str, $junk, "$prop: able to parse unexpected input");

        ok($css21_actions.warnings, "$prop : unexpected input produces warning")
            or diag $css21_actions.warnings;

        for <inherit initial> -> $misc {
            my $decl = $prop ~ ': ' ~ $misc;

            my @_expr = ($misc => True);

            my %ast = %test<box>
                ?? <top right bottom left>.map({($prop.lc ~ '-' ~ $_) => [expr => @_expr]})
                !! ($prop.lc => [expr => @_expr]);

            unless $misc eq 'initial' { # applicable to css3 only
                $css21_actions.reset;
                $p21 = CSS::Language::CSS21.parse( $decl, :rule('declaration-list'), :actions($css21_actions));

                CSS::Grammar::Test::parse_tests($decl, $p21, :rule('decl'), :suite('css21'),
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
