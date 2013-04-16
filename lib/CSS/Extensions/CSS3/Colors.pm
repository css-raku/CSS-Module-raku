use v6;

# CSS3 Color Module Extensions
# specification: http://www.w3.org/TR/2011/REC-css3-color-20110607/

grammar CSS::Extensions::CSS3::Colors::Syntax {

# extensions and at rules for CSS3 Color Module

    rule at-rule:sym<color-profile> {(:i'color-profile') <declarations> }

    rule color-angle{<num>$<percentage>=[\%]?}
    rule color-alpha{<num>$<percentage>=[\%]?}

    # <rgb> and <hex> are defined in CSS core grammar
    rule color:sym<rgba> {:i'rgba('
                              [ <r=.color-range> ','
                                <g=.color-range> ','
                                <b=.color-range> ','
                                <a=.color-alpha> || <any-args> ]
                   ')'
    }

    rule color:sym<hsl> {:i'hsl('
                             [ <h=.color-angle> ','
                               <s=.color-alpha> ','
                               <l=.color-alpha> || <any-args> ]
                    ')'
    }

    rule color:sym<hsla> {:i'hsla('
                              [ <h=.color-angle> ','
                                <s=.color-alpha> ','
                                <l=.color-alpha> ','
                                <a=.color-alpha> || <any-args> ]
                   ')'
    }

}

grammar CSS::Extensions::CSS3::Colors:ver<20110607.000>
    is CSS::Extensions::CSS3::Colors::Syntax {
        # nothing yet
}

class CSS::Extensions::CSS3::Colors::Actions {

    method at-rule:sym<color-profile>($/) { make $.at-rule($/) }

    method color-angle($/) {
        my $angle = %<num>.ast;
        $angle = ($angle * 3.6).round
            if $<percentage>.Str;
        make $.token($angle, :type('num'), :units('degrees'));
    }

    method color-alpha($/) {
        my $alpha = %<num>.ast;
        $alpha = ($alpha / 100)
            if $<percentage>.Str;
        make $.token($alpha, :type('num'), :units('alpha'));
    }

    method color:sym<rgba>($/) {
        return $.warning('usage: rgba(c,c,c,a) where c is 0..255 or 0%-100% and a is 0-1 or 0%-100%')
            if $<any-args>;
        make $.token($.node($/), :type<color>, :units<rgba>);
    }

    method color:sym<hsl>($/)  {
        return $.warning('usage: hsl(h,s,l) where h is 0..360  and s,l are 0-1 or 0%-100%')
            if $<any-args>;
        make $.token($.node($/), :type<color>, :units<hsl>);
    }

    method color:sym<hsla>($/) {
        return $.warning('usage: hsla(h,s,l,a) where h is 0..360  and s,l,a are 0-1 or 0%-100%')
            if $<any-args>;
        make $.token($.node($/), :type<color>, :units<hsla>);
    }
}

