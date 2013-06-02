use v6;

use CSS::Grammar::Actions;

class CSS::Language::Actions
    is CSS::Grammar::Actions {

    has Bool $.strict is rw = True;

    # ---- CSS::Grammar overrides ----

    method declaration:sym<base>($/)        {
        $.warning('unknown property', $<property>.ast, 'declaration dropped');
    }

    method declaration:sym<validated>($/)  {
        return unless $<decl>.ast;
        
        my %ast = $<decl>.ast;

        if $<any-arg> {
            return $.warning("extra terms following '{%ast<property>}' declaration",
                             $<any-arg>.Str, 'dropped');
        }

        if (my $prio = $<prio> && $<prio>[0].ast) {
            %ast<prio> = $prio;
        }

        make %ast;
    }

    method proforma:sym<inherit>($/) { make {inherit => True } }
    method proforma:sym<initial>($/) { make {initial => True } }

    method misc($/) {
        # miscellaneous and fallback handling, including 'inherit' (css2) and
        # 'initial' css3
        make $<proforma>[0].ast
            if $<proforma> && !$<any-args>;
    }

    #---- AST construction methods ----#

    method _decl($prop, $/, $synopsis, :$expand?) {
        # used by prop:sym<*> methods

        die "doesn't look like a property: " ~ $/.Str
            unless $prop;

        my $property = $prop.Str.trim.lc;

        if ($<misc> && !$<misc>.ast) 
            || ($<proforma> && !$<proforma>.ast) 
            || $<any> || $<any-arg> || $<any-args> {
                $.warning('usage ' ~ $property ~ ': ' ~ $synopsis);
                return Any;
        }

        my @expr;

        my $proforma = $<misc> || $<proforma>;
        if $proforma {
            my %proforma = $proforma.ast;
            @expr = %proforma;
        }
        else {
            my $m = $<expr> // $/;
            @expr = @( $.list($m) );
            # automatic dereferencing of <ref> elems
            @expr = @expr.map({$_.key eq 'ref' ?? @( $_.value ) !! $_});
         }

        my %ast;

        if $expand {
            if $expand eq 'box' {
                my @properties;
                #  expand to a list of properties. eg: margin => margin-top,
                #      margin-right margin-bottom margin-left
                warn "too many arguments: @expr"
                    if @expr > 4;
                my %box;
                %box<top right bottom left> = @expr;
                %box<right>  //= %box<top>;
                %box<bottom> //= %box<top>;
                %box<left>   //= %box<right>;

                for %box.kv -> $edge, $val {
                    my $prop = $property ~ '-' ~ $edge;
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

    method length:sym<num>($/) {
        my $num = $<number>.ast;

        return $.warning('number not followed by a length unit', $<number>.Str)
            if $num && $.strict;

        make $.token($num, :type<length>, :units<px>)
    }

    method angle:sym<num>($/) {
        my $num = $<number>.ast;

        return $.warning('angle not followed by "deg", "rad" or "grad"', $<number>.Str)
            if $num && $.strict;

        make $.token($num, :type<angle>, :units<deg>)
    }

    method frequency:sym<num>($/) {
        my $num = $<number>.ast;

        return $.warning('non-zero frequency not followed by "Hz" or "KHz"', $<number>.Str)
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

    method integer($/)     { make $.token($/.Int, :type<integer>) }
    method number($/)      { make $.token($<num>.ast, :type<number>) }
    method uri($/)         { make $<url>.ast }
    method keyw($/)        { make $<ident>.ast }
    # case sensitive identifiers
    method identifier($/)  { make $<name>.ast }
    # identifiers strung-together, e.g New Century Schoolbook
    method identifiers($/) { make $<identifier>.map({$_.ast }).join(' ') }
}
