use v6;

use CSS::Grammar::Actions;
use CSS::Grammar::AST :CSSValue;
use CSS::Specification::_Base::Actions;

class CSS::Module::_Base::Actions
    is CSS::Specification::_Base::Actions
    is CSS::Grammar::Actions {

    # ---- CSS::Grammar overrides ---- #

    method any-function($/)             {
        $.warning('ignoring function', $<Ident>.ast.lc);
    }

    method declaration($/)  {

        return if $<dropped-decl>;
        
        my %ast = %( $.decl( $<decl> ) );
        return Any
            unless +%ast;

        if $<any-arg> {
            return $.warning("extra terms following '{%ast<ident>}' declaration",
                             ~$<any-arg>, 'dropped');
        }

        if (my $prio = $<prio> && $<prio>.ast) {
            %ast<prio> = $prio;
        }
        

        make $.token( %ast, :type(CSSValue::Property) );
    }

    method proforma:sym<inherit>($/) { make {keyw => $.token('inherit', :type(CSSValue::KeywordComponent))} } 
    method proforma:sym<initial>($/) { make {keyw => $.token('initial', :type(CSSValue::KeywordComponent))} } 

    #---- Language Extensions ----#

    method length:sym<zero>($/) {
        make $.token(0, :type(CSSValue::LengthComponent))
    }

    method angle:sym<zero>($/) {
        make $.token(0, :type(CSSValue::AngleComponent))
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
        my $color-name = $<keyw>.ast;
        my @rgb = @( $.colors{$color-name} )
            or die "unknown color: " ~ $color-name;

        my $num-type = CSSValue::NumberComponent;
        my @color = @rgb.map: { %( $num-type.Str => $.token( $_, :type($num-type)) ).item };

        make $.token(@color, :type<rgb>);
    }

    method integer($/)     {
        my $val = $<uint>.ast;
        $val = -$val
            if $<sign> && $<sign> eq '-';
        make $.token($val, :type(CSSValue::IntegerComponent))
    }

    method uint($/)        { make $/.Int }
    method number($/)      { make $.token($<num>.ast, :type(CSSValue::NumberComponent)) }
    method uri($/)         { make $<url>.ast }
    method keyw($/)        { make $.token($<Ident>.ast, :type(CSSValue::KeywordComponent)) }
    # case sensitive identifiers
    method identifier($/)  { make $.token($<name>.ast, :type(CSSValue::IdentifierComponent)) }
    # identifiers strung-together, e.g New Century Schoolbook
    method identifiers($/) { make $.token( $<identifier>>>.ast.join(' '), :type(CSSValue::IdentifierComponent)) }
}
