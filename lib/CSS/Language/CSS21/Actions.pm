use v6;

use CSS::Language::_Base::Actions;
use CSS::Language::CSS21::Spec::Interface;
use CSS::Language::CSS21::Spec::Actions;

class CSS::Language::CSS21::Actions
    is CSS::Language::CSS21::Spec::Actions
    is CSS::Language::_Base::Actions 
    does CSS::Language::CSS21::Spec::Interface {

    has $._proforma-usage = ' | inherit';

    method color:sym<system>($/) { make $.node($/) }

    # --- Functions --- #

    #= usage: attr( attribute-name <type-or-unit>? )
    method attr($/)             {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: counter(ident [, ident [,...] ])
    method counter($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: counters(ident [, "string"])
    method counters($/) {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }

    #= usage: rect(<top>, <right>, <botom>, <left>)
    method shape($/)     {
        return $.warning(&?ROUTINE.WHY)
            if $<any-args>;
        make $.list($/);
    }
    method shape-arg($/) { make $.list($/) }

    method val($/) { make $.list($<expr> // $/) }

   # --- Expressions --- #

    method expr-azimuth($/) {
        my $ast = $.node($/);
        die {ast => $ast}.perl;
        # compute implied angles
        my $angle;

        if my $direction = $ast<direction> || $ast<behind> {

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

            my $bh = $ast<behind> ?? 1 !! 0;

            $angle = {angle => $.token(%angles{$direction}[$bh], :type<angle>, :units<degrees> )};
	}
        elsif $ast<delta> {
            my $delta_angle = $ast<delta> eq 'leftwards' ?? -20 !! 20;
            $angle = {turn => $.token($delta_angle, :type<angle>, :units<degrees> )};
        }
	else {
	    $angle = $ast;
	}

        make [$angle];
    }

    method border-style($/) { make $.list($/) }
    method outline-style($/) { make <border-style>.ast }
    method border-width($/) { make $.list($/) }

    method expr-elevation($/) {
        my $ast = $.node($/);

        my $angle;

        if my $direction = $ast<direction> {

            state %angles = (
                'below'    => -90,
                'level'    =>   0,
                'above'    =>  90,
                );

            $angle = {angle => $.token(%angles{$direction}, :type<angle>, :units<degrees> )};
        }
        elsif $ast<tilt> {
            my $delta_angle = $ast<tilt> eq 'lower' ?? -10 !! 10;
            $angle = {tilt => $.token($delta_angle, :type<angle>, :units<degrees> )};
        }
	else {
	    $angle = $ast;
	}

        make [$angle];
    }

    method family-name($/) { make $<family-name>.ast }
    method generic-family($/) { make $<generic-family>.ast }
    method absolute-size($/) { make $.token($<keyw>.ast) }
    method relative-size($/) { make $.token($<keyw>.ast) }
    method margin-width($/) { make $.list($/) }
    method padding-width($/) { make $.list($/) }
    method generic-voice($/) { make $.list($/) }
    method specific-voice($/) { make $.list($/) }
}
