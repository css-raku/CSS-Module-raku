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

    method _make_decl($/, $synopsis, :$body?, :$top_right_bottom_left?) {
        # used by prop:sym<*> methods

        die "doesn't look like a property: " ~ $/.Str
            unless $0;

        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if $<bad_args>;

        my %ast;
        %ast<property> = $property;

        my @expr;
        for $.list($body // $/) {
            for @$_ {
                my ($term, $val) = $_.kv;

                if $term eq 'inherit' {
                    %ast<inherit> = True;
                }
                else {
                    @expr.push($_);
                }
            }
        }

        if @expr && $top_right_bottom_left {
            # map arguments to: top right bottom left
            warn "too many arguments: @expr"
                if @expr > 4;
            my %props;
            %props<top right bottom left> = @expr;
            %props<right>  //= %props<top>;
            %props<bottom> //= %props<top>;
            %props<left>   //= %props<right>;

            @expr = %props;
        }

        %ast<expr> = @expr if @expr;

        make %ast;
    }

}
