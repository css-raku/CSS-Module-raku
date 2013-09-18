use v6;

class CSS::Language::Specification::Actions {

    # these actions translate a CSS property specification to Perl 6
    # rules or actions.
    has %.prop-refs is rw;

    method TOP($/) { make $<property-spec>>>.ast };

    # condensation eg: 'border-top-style' ... 'border-left-style' 
    # ==> pfx='border' props=<top right bottom left> sfx='-style'

    sub _right-condense( @props ) {
        return ('', @props)
            unless @props > 1;

        my $pfx;
        my $pfx-len;
        for 1..@props[0].chars -> $try-len {
            my $try-pfx = @props[0].substr(0, $try-len);
            last if @props.grep({ .substr(0, $try-len) ne $try-pfx });
            $pfx = $try-pfx;
            $pfx-len = $try-len;
        }
        return ('', @props)
            unless $pfx-len;

        my @remainder = @props>>.substr($pfx-len);
        return $pfx, @remainder;
    }

    sub _left-condense( @props ) {
        return ('', @props)
            unless @props > 1;

        my $sfx;
        my $sfx-len;
        for 1..@props[0].chars -> $try-len {
            my $try-sfx = @props[0].substr(* - $try-len);
            last if @props.grep({ .substr(* - $try-len) ne $try-sfx });

            $sfx = $try-sfx;
            $sfx-len = $try-len;

            # stop on a '-'
            last if $try-sfx.substr(0,1) eq '-';
        }
        return ('', @props)
            unless $sfx-len;

        my @remainder = @props>>.substr(0, * - $sfx-len);
        return $sfx, @remainder;
    }

    method property-spec($/) {
        my @props = @($<prop-names>.ast);
        my ($pfx, @props-condensed) = _right-condense( @props );
        (my $sfx, @props-condensed) = _left-condense( @props-condensed );

        my $sym = @props-condensed.join('|');
        $sym = $pfx ~ '[' ~ $sym ~ ']' ~ $sfx
            unless $pfx eq '' && $sfx eq '';

        my $match = $sym.subst(/\-/, '\-'):g;
        my $grammar = $<synopsis>.ast;

        my %prop-def = (
            sym      => $sym,
            props    => @props,
            match    => $match,
            defn     => $grammar,
            synopsis => $<synopsis>.Str,
            );

        make %prop-def;
    }

    method prop-names($/) {
        my @prop_names = $<id>>>.ast;
        make @prop_names;
    }

    method id($/)        { make $/.Str }
    method id-quoted($/) { make $<id>.ast }
    method keyw($/)      { make $<id>.subst(/\-/, '\-'):g }
    method digits($/)    { make $/.Int }

    method values($/) {
        make $<term>>>.ast.join(' ');
    }
    method term($/) {
        my $value = $<value>.ast;
        if $<occurs> {
            my $occurs = $<occurs>.ast;
            if $occurs eq '#' {         # a list
                $value = "$value +% ','";
            }
            else {
                $value ~= $occurs;      # quantifier
            }
        }
        make $value;
    }

    method terms($/) {
        make $<term>>>.ast.join(' ');
    }

    method options($/) {
        my @choices = @$<term>>>.ast;
        return make @choices[0]
            unless @choices > 1;
        
        make '[ ' ~ @choices.join(' | ') ~ ' ]';
    }

    method combo($/) {
        my @choices = @$<term>>>.ast;
        return make @choices[0]
            unless @choices > 1;
        make '[ ' ~ @choices.join(' | ') ~ ' ]**1..' ~ @choices.Int;
    }

    method required($/) {
        my @choices = $<term>>>.ast;
        return make @choices[0]
            unless @choices > 1;
        make '[ ' ~ @choices.join(' | ') ~ ' ]**' ~ @choices.Int
    }

    method occurs:sym<maybe>($/)     { make '?' }
    method occurs:sym<once-plus>($/) { make '+' }
    method occurs:sym<zero-plus>($/) { make '*' }
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
            ?? '[ ' ~ $<keyw>>>.ast.join(' | ') ~ ' ]'
            !! $<keyw>[0].ast;

        make $keywords ~ ' & <keyw>';
    }

    method value:sym<numbers>($/) {
        my $keywords = @$<digits> > 1
            ?? '[ ' ~ $<digits>>>.ast.join(' | ') ~ ' ]'
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

    method value:sym<literal>($/)  { make "'" ~ $0.Str ~ "'"}
            
    method value:sym<num>($/)      { make $/.Str }

    method value:sym<keyw>($/)     { make $/.Str }
}
