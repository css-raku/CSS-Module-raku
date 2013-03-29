use v6;

use CSS::Grammar::Actions;

class CSS::Grammar::Validating::Actions
    is CSS::Grammar::Actions {

    method declaration:sym<raw>($/)        {
        $.warning('dropping declaration', $<property>.ast);
    }

    method declaration:sym<validated>($/)        {
        warn "todo: declaration_validated: " ~ $/.Str;
        make $.node($/);
    }

    method _make_decl($/, $synopsis) {
        # used by prop:sym<*> methods
        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if $<bad_args>;

        my %ast;
        %ast<property> = $property;

        my @expr;
        for $.list($/) {
            my ($term, $val) = $_.kv;
            if $term eq 'inherit' {
                %ast<inherit> = True;
            }
            else {
                push @expr, $_;
            }
        }

        %ast<expr> = @expr if @expr;

        make %ast;
     }

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

                @expr = (angle => $.token(%angles{$keyw}[$bh], :type('angle'), :units('degrees') ));
            }
            elsif $<delta> {
                my $delta_angle = $<dl> ?? -20 !! 20;
                @expr = (<delta> => $.token($delta_angle, :type('angle'), :units('degrees') ));
            }

            %ast<expr> = @expr;
        }

        make %ast;
    }

    method decl:sym<background-attachment>($/) {
        $._make_decl($/, 'scroll | fixed | inherit');
    };

    method decl:sym<background-color>($/) {
        $._make_decl($/, '<color> | transparent | inherit')
    };

    method decl:sym<background-image>($/) {
        $._make_decl($/, '<uri> | none | inherit')
    };

    method decl:sym<background-repeat>($/) {
        $._make_decl($/, 'repeat | repeat-x | repeat-y | no-repeat')
    };

    method decl:sym<background-position>($/) {
        $._make_decl($/, '[<percentage> | <length>]{1,2} | [top | center | bottom] || [left | center | right]')
    };

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
                @expr = (angle => $.token(%angles{$keyw}, :type('angle'), :units('degrees') ));
            }
            elsif $<delta> {
                my $delta_angle = $<dl> ?? -10 !! 10;
                @expr = (delta => $.token($delta_angle, :type('angle'), :units('degrees') ));
            }
            %ast<expr> = @expr;
        }

        make %ast;
    }

    method decl:sym<font-style>($/) {
        $._make_decl($/, '');
    }
}
