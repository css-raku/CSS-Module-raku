use v6;

class CSS::Language::Specification::Actions {

    # these actions translate a css property specification to Perl 6
    # rules or actions.
    has %.prop-refs is rw;

    method property-spec($/) {
        my @props = @($<prop-names>.ast);
        my $sym = @props.join('|');
        my $match = $sym.subst(/\-/, '\-'):g;
        my $grammar = $<synopsis>.ast;
        $grammar = $grammar.subst(/^\s*\[\*/,'').subst(/\s*\]\*$/,'');

        my %prop-def;
        %prop-def<sym> = $sym;
        %prop-def<props> = @props;
        %prop-def<match> = $match;
        %prop-def<defn> = $grammar;
        %prop-def<synopsis> = $<synopsis>.Str;

        make %prop-def;
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
        my $choices = @$<combo>.Int;
        return make @$<combo>[0].ast
            unless $choices > 1;
        # a || b || c represents a combination of one or more of a, b and c
        # This production is a slightly more liberal approximation:
        # it allows elements to be repeated
        
        make '[ ' ~ $<combo>.map({$_.ast}).join(' | ') ~ ' ]';
    }

    method combo($/) {
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
        # todo - save function prototype
        make '<' ~ $<keyw>.ast ~ '>';
    }
    method value:sym<inherit>($/)  { make '<inherit>' }
    method value:sym<keywords>($/) {
        my $keywords = @$<keyw> > 1
            ?? '[ ' ~ $<keyw>.map({$_.ast}).join(' | ') ~ ' ]'
            !! $<keyw>[0].ast;

        make $keywords ~ ' & <keyw>';
    }
    method value:sym<numbers>($/) {
        my $keywords = @$<digits> > 1
            ?? '[ ' ~ $<digits>.map({$_.ast}).join(' | ') ~ ' ]'
            !! $<digits>[0].ast;

        make $keywords ~ ' & <number>';
    }
    method value:sym<group>($/) {
        my $val = $<terms>.ast;
        make '[ ' ~ $val ~ ' ]';
    }
    method value:sym<rule>($/)     { make '<' ~ $<id>.ast ~ '>' }

    method value:sym<punc>($/)     { make "'" ~ $/.Str ~ "'" }
    method property-ref($/)        {
        my $prop-ref = $<id>.ast;
        %.prop-refs{ $prop-ref }++;
        make $prop-ref;
    }
    method value:sym<quoted>($/)   {
        make $<property-ref>
            ?? '<' ~ $<property-ref>.ast ~ '>'
            !! "'" ~ $0.Str ~ "'"
    }
            
    method value:sym<num>($/)      { make $/.Str }
    method value:sym<keyw>($/)     { make $/.Str }
}
