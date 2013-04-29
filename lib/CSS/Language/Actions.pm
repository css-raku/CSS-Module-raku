use v6;

use CSS::Grammar::Actions;

class CSS::Language::Actions
    is CSS::Grammar::Actions {

    has Bool $.strict is rw = True;

    # ---- CSS::Grammar overrides ----

    method declaration:sym<raw>($/)        {
        $.warning('unknown property', $<property>.ast, 'declaration dropped');
    }

    method declaration:sym<validated>($/)  {
        return unless $<decl>.ast;
        
        my %ast = $<decl>.ast;

        if (my $prio = $<prio> && $<prio>[0].ast) {
            # mark !important declarations
            %ast<prio> = $prio
        }

        make %ast;
    }

    method inherit($/) { make True }
    method initial($/) { make True }
    method misc($/) {
        # miscellaneous and fallback handling, including 'inherit' (css2) and
        # 'initial' css3
        make $.node($/)
            unless $<any-args>;
    }

    #---- AST construction methods ----#

    method _make_decl($/, $synopsis, :$body?, :$expand?) {
        # used by prop:sym<*> methods

        die "doesn't look like a property: " ~ $/.Str
            unless $0;

        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if ($<misc> && !$<misc>.ast) || $<any>;

        my @expr;

        if $<misc> {
            @expr = %( $<misc>.ast );
        }
        else {
            for $.list($body // $/) {
                for @$_ {
                    my ($term, $val) = $_.kv;
                    next if $term eq 'inherit';
                    
                    @expr.push($_);
                }
            }
        }

        if $expand {
            if $expand eq 'box' {
                #  expand to a list of properties. eg: margin => margin-top,
                #      margin-right margin-bottom margin-left
                if @expr {
                    warn "too many arguments: @expr"
                        if @expr > 4;
                    my %box;
                    %box<top right bottom left> = @expr;
                    %box<right>  //= %box<top>;
                    %box<bottom> //= %box<top>;
                    %box<left>   //= %box<right>;

                    @expr = ();

                    for %box.kv -> $k, $v {
                        my $box_prop = $property ~ '-' ~ $k;
                        @expr.push( $box_prop => [@$v] );
                    }
                }
            }
            else {
                die "bad :expand option: " ~ $expand;
            }
        }

        my %ast;
        %ast<property> = $property;
        %ast<expr> = @expr;

        make %ast;
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

    method std($/)         { make $/.Str.lc }
    method integer($/)     { make $/.Int }
    method number($/)      { make $<num>.ast }
    method uri($/)         { make $<url>.ast }
    method keyw($/)        { make $<ident>.ast }
    # case sensitive identifiers
    method identifier($/)  { make $<name>.ast }
    # identifiers strung-together, e.g New Century Schoolbook
    method identifiers($/) { make $<identifier>.map({$_.ast }).join(' ') }
}
