use v6;

class CSS::Language::Specification::Actions {

    # these actions translate a css property specification to Perl 6 grammar.

    method property-spec($/) {
        my $synopsis = $<synopsis>.Str;
        my $grammar = $<synopsis>.ast;
        my %prop_defs = $<prop-names>.map({$_.ast => {synopsis => $synopsis,
                                                      grammar => $grammar,
                                           }});
        make %prop_defs;
    }

    method prop-names($/) {
        my @prop_names = $<prop-name>.map({$_.ast});
        make @prop_names;
    }

    method id($/)     { make $/.Str }
    method keyw($/)   { make $<id>.subst(/\-/, '\-'):g }
    method digits($/) { make $/.Int }

    method value-inst($/) {
        my $value = $<value>.ast // '??' ~ $<value>.Str;
        $value ~= $<occurs>[0].ast
            if $<occurs>;

        make $value;
    }

    method value-list($/) {
        make $<or>.map({$_.ast}).join(' ');
    }

    method or($/) {
        return make @$<or2>[0].ast unless @$<or2> > 1;
        make '[ ' ~ $<or2>.map({$_.ast}).join(' | ') ~ ' ]';
    }

    method or2($/) {
        return make $<value-inst>[0].ast unless @$<value-inst> > 1;
        make '[ ' ~ $<value-inst>.map({$_.ast}).join(' | ') ~ ' ]+';
    }

    method occurs:sym<maybe>($/)     { make '?' }
    method occurs:sym<once_plus>($/) { make '+' }
    method occurs:sym<zero_plus>($/) { make '*' }
    method occurs:sym<range>($/) {
        make '**' ~ $<min>.ast ~ '..' ~ $<max>.ast;
    }

    method value:sym<func>($/)     {
        make "[ '" ~ $<keyw>.ast ~ "(' <.any_args> ')' ] & <function>";
    }
    method value:sym<inherit>($/)  { make '<inherit>' }
    method value:sym<keywords>($/) {
        my $keywords = @$<keyw> > 1
            ?? '[ ' ~ $<keyw>.map({$_.ast}).join(' | ') ~ ' ]'
            !! $<keyw>[0].ast;

        make $keywords ~ ' & <ident> ';
    }
    method value:sym<numbers>($/) {
        my $keywords = @$<digits> > 1
            ?? '[ ' ~ $<digits>.map({$_.ast}).join(' | ') ~ ' ]'
            !! $<digits>[0].ast;

        make $keywords ~ ' & <num> ';
    }
    method value:sym<group>($/) {
        my $val = $<value-list>.ast;
        make '[ ' ~ $val ~ ' ]';
    }
    method value:sym<rule>($/)   { make '<' ~ $<id>.ast ~ '>' }
    method value:sym<prop>($/)   { make '<' ~ $<id>.ast ~ '>' }
    method value:sym<punc>($/)   { make "'" ~ $/.Str ~ "'" }
    method value:sym<quoted>($/) { make "'" ~ $0.Str ~ "'" }
    method value:sym<num>($/)    { make $/.Str }
    method value:sym<keyw>($/)   { make $/.Str }
}
