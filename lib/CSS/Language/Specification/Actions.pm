use v6;

class CSS::Language::Specification::Actions {

    # these actions translate a css property specification to Perl 6
    # rules or actions.
    has %.prop-refs is rw;

    method TOP($/) { make $<property-spec>.map({$_.ast}) };

    # contraction eg: 'border-top-style' ... 'border-left-style' 
    # ==> pfx='border' props=<top right bottom left> sfx='-style'

    sub _right_contract( @props ) {
        return ('', @props)
            unless @props > 1;

        my $pfx;
        my $pfx-len;
        for 1..@props[0].chars -> $try-len {
            my $try-pfx = @props[0].substr(0, $try-len);
            last if @props.grep({$_.substr(0, $try-len) ne $try-pfx});
            $pfx = $try-pfx;
            $pfx-len = $try-len;
        }
        return ('', @props)
            unless $pfx-len;

        my @remainder = @props.map({$_.substr($pfx-len)});
        return $pfx, @remainder;
    }

    sub _left_contract( @props ) {
        return ('', @props)
            unless @props > 1;

        my $sfx;
        my $sfx-len;
        for 1..@props[0].chars -> $try-len {
            my $try-sfx = @props[0].substr(* - $try-len);
            last if @props.grep({$_.substr(* - $try-len) ne $try-sfx});

            $sfx = $try-sfx;
            $sfx-len = $try-len;

            # stop on a '-'
            last if $try-sfx.substr(0,1) eq '-';
        }
        return ('', @props)
            unless $sfx-len;

        my @remainder = @props.map({$_.substr(0, * - $sfx-len)});
        return $sfx, @remainder;
    }

    method property-spec($/) {
        my @props = @($<prop-names>.ast);
        my ($pfx, @props-contracted) = _right_contract( @props );
        (my $sfx, @props-contracted) = _left_contract( @props-contracted );

        my $sym = @props-contracted.join('|');
        $sym = $pfx ~ '[' ~ $sym ~ ']' ~ $sfx
            unless $pfx eq '' && $sfx eq '';

        my $match = $sym.subst(/\-/, '\-'):g;
        my $grammar = $<synopsis>.ast;

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
        if $<occurs> {
            my $occurs = $<occurs>[0].ast;
            if $occurs eq '#' {         # a list
                $value = "$value +% ','";
            }
            else {
                $value ~= $occurs;
            }
        }
        make $value;
    }

    method terms($/) {
        make $<list>.map({$_.ast}).join(' ');
    }

    method list($/) {
        my @choices = @$<pick>.map({$_.ast});
        return make @choices[0]
            unless @choices > 1;
        
        make '[ ' ~ @choices.join(' | ') ~ ' ]';
    }

    method pick($/) {
        my @choices = @$<required>.map({$_.ast});
        return make @choices[0]
            unless @choices > 1;
        make '[ ' ~ @choices.join(' | ') ~ ' ]**1..' ~ @choices.Int;
    }

    method required($/) {
        my @choices = $<values>.map({$_.ast});
        return make @choices[0]
            unless @choices > 1;
        make '[ ' ~ @choices.join(' | ') ~ ' ]**1..' ~ @choices.Int
    }

    method occurs:sym<maybe>($/)     { make '?' }
    method occurs:sym<once_plus>($/) { make '+' }
    method occurs:sym<zero_plus>($/) { make '*' }
    method occurs:sym<list>($/)      { make '#' }
    method occurs:sym<range>($/) {
        make '**' ~ $<min>.ast ~ '..' ~ $<max>.ast;
    }

    method value:sym<func>($/)     {
        # todo - save function prototype
        make '<' ~ $<id>.ast ~ '>';
    }

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

    method value:sym<punc>($/)     { make "'" ~ $/.Str.trim ~ "'" }

    method property-ref:sym<css21>($/) { make $<id>.ast }
    method property-ref:sym<css3>($/)  { make $<id>.ast }
    method value:sym<prop-ref>($/)        {
        my $prop-ref = $<property-ref>.ast;
        %.prop-refs{ $prop-ref }++;
        make '<' ~ $prop-ref ~ '>';
    }

    method value:sym<quoted>($/)   { make "'" ~ $0.Str ~ "'"}
            
    method value:sym<num>($/)      { make $/.Str }

    method value:sym<keyw>($/)     { make $/.Str }
}
