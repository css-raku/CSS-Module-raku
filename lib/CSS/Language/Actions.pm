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
            if (my $prop_list = %ast<property_list>) {
                %$_<prio> = $prio for @$prop_list;
            }
            else {
                %ast<prio> = $prio
            }
        }

        make %ast;
    }

    #---- AST construction methods ----#

    method _make_decl($/, $synopsis, :$body?, :$expand?) {
        # used by prop:sym<*> methods

        die "doesn't look like a property: " ~ $/.Str
            unless $0;

        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if $<any_args> || $<any>;

        my %ast;

        my @expr;
        my $inherit;

        for $.list($body // $/) {
            for @$_ {
                my ($term, $val) = $_.kv;

                if $term eq 'inherit' {
                    $inherit = True;
                }
                else {
                    @expr.push($_);
                }
            }
        }

        if $expand {
            my @props;

            # indicate the start of a property set
            my %propset = (property => $property);
            %propset<inherit> = True if $inherit;
            @props.push({%propset});

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

                    for %box.kv -> $side, $expr {
                        my %prop = (property => $property ~ '-' ~ $side);
                        %prop<expr> = [$expr]
                            if $expr;

                        @props.push( {%prop} );
                    }
                }
            }
            elsif $expand eq 'family' {

                for @expr {
                    my ($prop, $val) = $_.kv;
                    @props.push({property => $prop, expr => $val});
                };

            }
            else {
                die "bad :expand option: " ~ $expand;
            }

            %ast<property_list> = @props;
        }
        else {
            %ast<property> = $property;
            %ast<inherit> = True if $inherit;
            %ast<expr> = @expr
                if @expr;
        }

        make %ast;
    }

    #---- Language Extensions ----#

    method length:sym<num>($/) {
        my $num = $<num>.ast;

        return $.warning('number not followed by a length unit', $<num>.Str)
            if $num && $.strict;

        make $.token($num, :type<length>, :units<px>)
    }

    method named-color($/) {
        state %colors = (
            black   => [   0,   0,   0 ],
            silver  => [ 192, 192, 192 ],
            gray    => [ 128, 128, 128 ],
            white   => [ 255, 255, 255 ],
            maroon  => [ 128,   0,   0 ],
            red     => [ 255,   0,   0 ],
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
            );

        my $color_name = $<ident>.ast;
        my $color = %colors{$color_name}
        or die  "unknown color: " ~ $color_name;

        my %rgb; %rgb<r g b> = @$color;
        make $.token(%rgb, :type<color>, :units<rgb>);
    }

    method color:sym<named>($/) { make $<named-color>.ast }

}
