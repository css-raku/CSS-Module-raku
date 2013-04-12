use v6;

# CSS3 Color Module Extensions
# specification: http://www.w3.org/TR/2011/REC-css3-color-20110607/

grammar CSS::Extensions::CSS3::Colors::Syntax {

# extensions and at rules for CSS3 Color Module

    rule at_rule:sym<color_profile> {(:i'color-profile') <declarations> }

    rule color_angle{<num>$<percentage>=[\%]?}
    rule color_alpha{<num>$<percentage>=[\%]?}

    # <rgb> and <hex> are defined in CSS core grammar
    rule color:sym<rgba> {:i'rgba('
                              [ <r=.color-range> ','
                                <g=.color-range> ','
                                <b=.color-range> ','
                                <a=.color_alpha> || <any_args> ]
                   ')'
    }

    rule color:sym<hsl> {:i'hsl('
                             [ <h=.color_angle> ','
                               <s=.color_alpha> ','
                               <l=.color_alpha> || <any_args> ]
                    ')'
    }

    rule color:sym<hsla> {:i'hsla('
                              [ <h=.color_angle> ','
                                <s=.color_alpha> ','
                                <l=.color_alpha> ','
                                <a=.color_alpha> || <any_args> ]
                   ')'
    }

}

grammar CSS::Extensions::CSS3::Colors:ver<20110607.000>
    is CSS::Extensions::CSS3::Colors::Syntax {
        # nothing yet
}

class CSS::Extensions::CSS3::Colors::Actions {

    method at_rule:sym<color_profile>($/) { make $.at_rule($/) }

    method color_angle($/) {
        my $angle = %<num>.ast;
        $angle = ($angle * 3.6).round
            if $<percentage>.Str;
        make $.token($angle, :type('num'), :units('degrees'));
    }

    method color_alpha($/) {
        my $alpha = %<num>.ast;
        $alpha = ($alpha / 100)
            if $<percentage>.Str;
        make $.token($alpha, :type('num'), :units('alpha'));
    }

    method color:sym<rgba>($/) {
        return $.warning('usage: rgba(c,c,c,a) where c is 0..255 or 0%-100% and a is 0-1 or 0%-100%')
            if $<any_args>;
        make $.token($.node($/), :type<color>, :units<rgba>);
    }

    method color:sym<hsl>($/)  {
        return $.warning('usage: hsl(h,s,l) where h is 0..360  and s,l are 0-1 or 0%-100%')
            if $<any_args>;
        make $.token($.node($/), :type<color>, :units<hsl>);
    }

    method color:sym<hsla>($/) {
        return $.warning('usage: hsla(h,s,l,a) where h is 0..360  and s,l,a are 0-1 or 0%-100%')
            if $<any_args>;
        make $.token($.node($/), :type<color>, :units<hsla>);
    }
}

