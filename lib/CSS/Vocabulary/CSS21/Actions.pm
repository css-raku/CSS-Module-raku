use v6;

use CSS::Vocabulary::CSS1::Actions;

class CSS::Vocabulary::CSS21::Actions
    is CSS::Vocabulary::CSS1::Actions {

    # --- Functions --- #

    method any_function($/)             {
        $.warning('unknown function', $<ident>.ast.lc);
    }

    method function:sym<attr>($/)             {
        return $.warning('usage: attr( attribute-name <type-or-unit>? [, <fallback> ]? )')
            if $<bad_args>;
        make {ident => 'attr', args => $.list($/)}
    }
    method function:sym<counter>($/) {
        return $.warning('usage: counter(ident [, ident [,...] ])')
            if $<bad_args>;
        make {ident => 'counter', args => $.list($/)}
    }
    method function:sym<counters>($/) {
        return $.warning('usage: counters(ident [, "string"])')
            if $<bad_args>;
        make {ident => 'counters', args => $.list($/)}
    }

    # --- Properties --- #

   method decl:sym<azimuth>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html

        return $.warning('usage azimuth: <angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards | inherit')
            if $<bad_args>;

        my %ast;
        %ast<property> = $0.Str.trim.lc;

        if $<inherit> {
            %ast<inherit> = True;
        }
        else {
            my @expr;
            if $<angle> {
                @expr = (<angle> => $<angle>.ast);
            }
            elsif $<lr> || $<bh> {

                state %angles = (
                    'left-side'    => [270, 270],
                    'far-left'     => [300, 240],
                    'left'         => [320, 220],
                    'center-left'  => [340, 200],
                    'center'       => [0,   180],
                    'center-right' => [20,  160],
                    'right'        => [40,  140],
                    'far-right'    => [60,  120],
                    'right-side'   => [90,  90],
                    'behind'       => [180, 180],
                    );

                my $keyw = $<lr>.Str.trim.lc || 'behind';
                my $bh = $<bh>.Str ?? 1 !! 0;

                @expr = (angle => $.token(%angles{$keyw}[$bh], :type<angle>, :units<degrees> ));
            }
            elsif $<delta> {
                my $delta_angle = $<dl> ?? -20 !! 20;
                @expr = (<delta> => $.token($delta_angle, :type<angle>, :units<degrees> ));
            }

            %ast<expr> = @expr;
        }

        make %ast;
    }

    method decl:sym<clip>($/) {
        $._make_decl($/, ' <shape> | auto');
    }

    method decl:sym<elevation>($/) {
        # see http://www.w3.org/TR/2011/REC-CSS2-20110607/aural.html

        return $.warning('usage elevation: <angle> | below | level | above | higher | lower | inherit')
            if $<bad_args>;

        my %ast;
        %ast<property> = $0.Str.trim.lc;

        if $<inherit> {
            %ast<inherit> = True;
        }
        else {
            my @expr;

            if $<angle> {
                @expr = (<angle> => $<angle>.ast);
            }
            elsif $<tilt> {

                state %angles = (
                    'below'    => -90,
                    'level'    =>   0,
                    'above'    =>  90,
                    );

                my $keyw = $<tilt>.Str.trim.lc;
                @expr = (angle => $.token(%angles{$keyw}, :type<angle>, :units<degrees> ));
            }
            elsif $<delta> {
                my $delta_angle = $<dl> ?? -10 !! 10;
                @expr = (delta => $.token($delta_angle, :type<angle>, :units<degrees> ));
            }
            %ast<expr> = @expr;
        }

        make %ast;
    }

}
