use v6;

use CSS::Grammar::Actions;
use CSS::Grammar::AST :CSSValue;
use CSS::Specification::_Base::Actions;

class CSS::Module::_Base::Actions
    is CSS::Specification::_Base::Actions
    is CSS::Grammar::Actions {

        has Bool $.pass-unknown is rw;

    use CSS::Grammar::AST;

    # ---- CSS::Grammar overrides ---- #

    method any-function($/)             {
        return callsame if $.pass-unknown;
        $.warning('ignoring function', $<Ident>.ast.lc);
    }

    method declaration($/)  {

        if $<any-declaration> {
            my $ast = $<any-declaration>.ast;
            if $ast.defined {
                my ($key, $value) = $ast.kv;
                if $.pass-unknown {
                    make {($key ~ ':unknown') => $value}
                }
                else {
                    $.warning('dropping unknown property',
                              $value<at-keyw> ?? '@'~$value<at-keyw> !! $value<ident>);
                }
            }
            return;
        }
        
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

    method proforma:sym<inherit>($/) { make (:keyw<inherit>) }
    method proforma:sym<initial>($/) { make (:keyw<initial>) }

    #---- Language Extensions ----#

    method length:sym<zero>($/) {
        make $.token(0, :type(CSSValue::LengthComponent))
    }

    method angle:sym<zero>($/) {
        make $.token(0, :type(CSSValue::AngleComponent))
    }

    has Hash $.colors = %CSS::Grammar::AST::CSS21-Colors;

   method color:sym<named>($/) {
        my $color-name = $<keyw>.ast.value;
        my @rgb = @( $.colors{$color-name} )
            or die "unknown color: " ~ $color-name;

        my $num-type = CSSValue::NumberComponent;
        my @color = @rgb.map: { $num-type.Str => $_ };

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
    method keyw($/)        { make $.token($<id>.lc, :type(CSSValue::KeywordComponent)) }
    # case sensitive identifiers
    method identifier($/)  { make $.token($<name>.ast, :type(CSSValue::IdentifierComponent)) }
    # identifiers strung-together, e.g New Century Schoolbook
    method identifiers($/) { make $.token( $<identifier>.map({ .ast.value }).join(' '), :type(CSSValue::IdentifierComponent)) }
}
