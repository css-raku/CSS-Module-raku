use v6;

class CSS::Vocabulary::Actions {

    # ---- CSS::Grammar overrides ----

    method declaration:sym<raw>($/)        {
        $.warning('unknown property', $<property>.ast, 'declaration dropped');
    }

    method declaration:sym<validated>($/)  {
        return unless $<decl>.ast;
        my %ast = $<decl>.ast;

        %ast<prio> = $<prio>.ast
            if $<prio> && $<prio>.ast.defined;

        make %ast;
    }

    #---- AST construction methods ----#

    method _make_decl($/, $synopsis, :$body?, :$box?) {
        # used by prop:sym<*> methods

        die "doesn't look like a property: " ~ $/.Str
            unless $0;

        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if $<bad_args>;

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

        if $box {
            #  expand to a list of properties. eg: margin => margin-top,
            #      margin-right margin-bottom margin-left
            warn "too many arguments: @expr"
                if @expr > 4;
            my %box;
            %box<top right bottom left> = @expr;
            %box<right>  //= %box<top>;
            %box<bottom> //= %box<top>;
            %box<left>   //= %box<right>;

            my @props;

            for %box.kv -> $side, $expr {
                my %prop = (property => $property ~ '-' ~ $side);

                if $inherit {
                    %prop<inherit> = True;
                }
                else {
                    %prop<expr> = $expr;
                }

                @props.push( {%prop} );
            }

            %ast<property_list> = @props;
        }
        else {
            %ast<property> = $property;
            if $inherit {
                %ast<inherit> = True;
            }
            else {
                %ast<expr> = @expr;
            }
        }

        make %ast;
    }

}
