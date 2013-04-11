use v6;

# CSS3 Font Extension Module
# specification: http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
#
# nb this standard is under revision (as of Feb 2013). Biggest change
# is the proposed at-rule @font-feature-values

grammar CSS::Extensions::CSS3::Fonts::Syntax {
    rule at_rule:sym<font_face> {(:i'font-face') <declarations> }
}

grammar CSS::Extensions::CSS3::Fonts:ver<20130212.000> 
    is CSS::Extensions::CSS3::Fonts::Syntax {

    # functions
    # ---------
    rule function:sym<fmt-or-loc> {:i(format|local)'(' [ <string> || <any_args> ] ')'}
}

class CSS::Extensions::CSS3::Fonts::Actions {
    method at_rule:sym<font_face>($/) { make $.at_rule($/) }

    method function:sym<fmt-or-loc>($/) {
        my $func = $0.Str.lc;
        return $.warning("usage: $func(<string>)")
            if $<any_args>;

        make {ident => $func, args => $.list($/)}
    }

}

