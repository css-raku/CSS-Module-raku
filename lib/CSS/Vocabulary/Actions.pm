use v6;

class CSS::Vocabulary::Actions {

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

    method _make_decl($/, $synopsis, :$body?) {
        # used by prop:sym<*> methods
        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if $<bad_args>;

        my %ast;
        %ast<property> = $property;

        my @expr;
        for $.list($body // $/) {
            my ($term, $val) = $_.kv;
            if $term eq 'inherit' {
                %ast<inherit> = True;
            }
            else {
                push @expr, $_;
            }
        }

        %ast<expr> = @expr if @expr;

        make %ast;
     }
}
