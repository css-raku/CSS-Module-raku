use v6;

use CSS::Grammar::Actions;
use CSS::Specification::_Base::Actions;

class CSS::Module::_Base::Actions
    is CSS::Specification::_Base::Actions
    is CSS::Grammar::Actions {

    has Bool $.strict is rw = True;

    # ---- CSS::Grammar overrides ---- #

    method declaration($/)        {
        $.warning('unknown property', $<property>.ast, 'declaration dropped');
    }

    method any-function($/)             {
        $.warning('ignoring function', $<ident>.ast.lc);
    }

    method module-declaration:sym<validated>($/)  {
        return unless $<decl>.ast;
        
        my %ast = %( $<decl>.ast );

        if $<any-arg> {
            return $.warning("extra terms following '{%ast<property>}' declaration",
                             ~$<any-arg>, 'dropped');
        }

        if (my $prio = $<prio> && $<prio>.ast) {
            %ast<prio> = $prio;
        }

        make %ast;
    }

    method proforma:sym<inherit>($/) { make { inherit => True } }
    method proforma:sym<initial>($/) { make { initial => True } }

    #---- Language Extensions ----#

    method length:sym<num>($/) {
        my $num = $<number>.ast;

        return $.warning('number not followed by a length unit', ~$<number>)
            if $num && $.strict;

        make $.token($num, :type<length>, :units<px>)
    }

    method angle:sym<num>($/) {
        my $num = $<number>.ast;

        return $.warning('angle not followed by "deg", "rad" or "grad"', ~$<number>)
            if $num && $.strict;

        make $.token($num, :type<angle>, :units<deg>)
    }

    method frequency:sym<num>($/) {
        my $num = $<number>.ast;

        return $.warning('non-zero frequency not followed by "Hz" or "KHz"', ~$<number>)
            if $num && $.strict;

        make $.token($num, :type<frequency>, :units<hz>)
    }

    has Hash $.colors = {
            black   => [   0,   0,   0 ],
            silver  => [ 192, 192, 192 ],
            gray    => [ 128, 128, 128 ],
            white   => [ 255, 255, 255 ],
            maroon  => [ 128,   0,   0 ],
            red     => [ 255,   0,   0 ],
            orange  => [ 255, 165,   0 ],
            purple  => [ 128,   0, 128 ],
            fuchsia => [ 255,   0, 255 ],
            green   => [   0, 128,   0 ],
            lime    => [   0, 255,   0 ],
            olive   => [ 128, 128,   0 ],
            yellow  => [ 255, 255,   0 ],
            navy    => [   0,   0, 128 ],
            blue    => [   0,   0, 255 ],
            teal    => [   0, 128, 128 ],
            aqua    => [   0, 255, 255 ],
            };

   method color:sym<named>($/) {
        my $color_name = $<keyw>.ast;
        my $color = $.colors{$color_name}
        or die  "unknown color: " ~ $color_name;

        my %rgb; %rgb<r g b> = @$color;
        make $.token(%rgb, :type<color>, :units<rgb>);
    }

    method integer($/)     { make $<uint>.ast }
    method uint($/)        { make $.token($/.Int, :type<integer>) }
    method number($/)      { make $.token($<num>.ast, :type<number>) }
    method uri($/)         { make $<url>.ast }
    method keyw($/)        { make $<ident>.ast }
    # case sensitive identifiers
    method identifier($/)  { make $<name>.ast }
    # identifiers strung-together, e.g New Century Schoolbook
    method identifiers($/) { make $<identifier>>>.ast.join(' ') }
}
