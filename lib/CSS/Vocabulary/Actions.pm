use v6;

class CSS::Vocabulary::Actions {

    method _make_decl($/, $synopsis) {
        # used by prop:sym<*> methods
        my $property = $0.Str.trim.lc;

        return $.warning('usage ' ~ $property ~ ': ' ~ $synopsis)
            if $<bad_args>;

        my %ast;
        %ast<property> = $property;

        my @expr;
        for $.list($/) {
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
