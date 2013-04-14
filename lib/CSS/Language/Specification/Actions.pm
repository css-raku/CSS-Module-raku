use v6;

class CSS::Language::Specification::Actions {

    # these actions translate a css property specification to Perl 6
    # rules or actions.

    method property-spec($/) {
        my @props = @($<prop-names>.ast);
        my $sym = @props.join('|');
        my $sym_esc = $sym.subst(/\-/, '\-'):g;
        my $grammar = $<synopsis>.ast;
        # snick in ... || <any_args>
        $grammar ~~ s!\s*\]\s*$! || <any_args> ]!;

        my %prop_def;
        %prop_def<sym> = $sym;
        %prop_def<props> = @props;
        %prop_def<grammar> = '{:i (' ~ $sym_esc ~ ") ':' " ~ $grammar ~ ' }';
        %prop_def<synopsis> = $<synopsis>.Str;

        make %prop_def;
    }

    method prop-names($/) {
        my @prop_names = $<prop-name>.map({$_.ast});
        make @prop_names;
    }

    method id($/)     { make $/.Str }
    method keyw($/)   { make $<id>.subst(/\-/, '\-'):g }
    method digits($/) { make $/.Int }

    method values($/) {
        make $<value-inst>.map({$_.ast}).join(' ');
    }
    method value-inst($/) {
        my $value = $<value>.ast;
        $value ~= $<occurs>[0].ast
            if $<occurs>;
        make $value;
    }

    method terms($/) {
        make $<list>.map({$_.ast}).join(' ');
    }

    method list($/) {
        my $choices = @$<either-or>.Int;
        return make @$<either-or>[0].ast
            unless $choices > 1;
        # a || b || c represents combinations of a, b and c
        # This production is a slightly more liberal approximation
        # it allows elements to be repeated
        
        make '[ ' ~ $<either-or>.map({$_.ast}).join(' | ') ~ ' ]';
    }

    method either-or($/) {
        my $choices = @$<values>.Int;
      return make $<values>[0].ast
          unless $choices > 1;
        make '[ ' ~ $<values>.map({$_.ast}).join(' | ') ~ ' ]**1..' ~ $choices;
    }

    method occurs:sym<maybe>($/)     { make '?' }
    method occurs:sym<once_plus>($/) { make '+' }
    method occurs:sym<zero_plus>($/) { make '*' }
    method occurs:sym<range>($/) {
        make '**' ~ $<min>.ast ~ '..' ~ $<max>.ast;
    }

    method value:sym<func>($/)     {
        make "<?before '" ~ $<keyw>.ast ~ "('><function>";
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
        my $val = $<terms>.ast;
        make '[ ' ~ $val ~ ' ]';
    }
    method value:sym<rule>($/)     { make '<' ~ $<id>.ast ~ '>' }

    method value:sym<punc>($/)     { make "'" ~ $/.Str ~ "'" }
    method value:sym<quoted>($/)   {
        make $<property-ref>
            ?? '<' ~ $<property-ref>.ast ~ '>'
            !! "'" ~ $0.Str ~ "'"
    }
            
    method value:sym<num>($/)      { make $/.Str }
    method value:sym<keyw>($/)     { make $/.Str }
}
