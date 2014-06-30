use v6;

use CSS::Grammar::Actions;
use CSS::Specification::_Base::Actions;

class CSS::Language::_Base::Actions
    is CSS::Specification::_Base::Actions
    is CSS::Grammar::Actions {

    has Bool $.strict is rw = True;

    # ---- CSS::Grammar overrides ---- #

    method declaration:sym<base>($/)        {
        $.warning('unknown property', $<property>.ast, 'declaration dropped');
    }

    method any-function($/)             {
        $.warning('ignoring function', $<ident>.ast.lc);
    }

    method declaration:sym<validated>($/)  {
        return unless $<decl>.ast;
        
        my %ast = $<decl>.ast;

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

    #---- AST construction methods ----#

    method _decl($prop, $/, $synopsis is copy, :$expand?) {
        ## OBSOLETE ## use .decl() instead
        die "doesn't look like a property: " ~ ~$/
            unless $prop;

       my $property = (~$prop).trim.lc;
       $synopsis = $synopsis.content.join(' ')
           if $synopsis.can('content');

        if ($<proforma> && !$<proforma>.ast)
            || $<any> || $<any-arg> || $<any-args> {
                $.warning( 'usage '
                           ~ ($synopsis.subst(/^ .*? ':' || <?>/, $property ~ ':'), 
                              @._proforma).join(' | ') );
                return Any;
        }

        if $<expr> &&
            (!$<expr>.caps || $<expr>.caps.grep({! .value.ast.defined})) {
            $.warning('dropping declaration', $property);
            return Any;
        }

        my @expr;

        if $<proforma> {
            @expr = ($<proforma>.ast);
        }
        else {
            my $m = $<expr> // $/;
            @expr = @( $.list($m) );
            # automatic dereferencing of <ref> elems
            @expr = @expr.map({ .keys[0] eq 'ref' ?? @( .values[0] ) !! $_});
         }

        my %ast;

        if $expand {
            if $expand eq 'box' {
                #  expand to a list of properties. eg: margin => margin-top,
                #      margin-right margin-bottom margin-left
                warn "too many arguments: @expr"
                    if @expr > 4;
                constant @Edges = <top right bottom left>;
                my %box = @Edges Z=> @expr;
                %box<right>  //= %box<top>;
                %box<bottom> //= %box<top>;
                %box<left>   //= %box<right>;

               my @properties;
                for @Edges -> $edge {
                    my $prop = $property ~ '-' ~ $edge;
                    my $val = %box{$edge};
                    @properties.push( {property => $prop, expr => [$val]} );
               }
                %ast<property-list> = @properties;
            }
            else {
                die "bad :expand option: " ~ $expand;
            }
        }
        else {
            %ast<property> = $property;
            %ast<expr> = @expr
                if @expr;
        }

        return %ast;
    }

    #---- Language Extensions ----#

    proto method length {*}
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
