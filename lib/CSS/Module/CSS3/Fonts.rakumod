use v6;

# CSS3 Font Extension Module
# specification: http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
#
# nb this standard is under revision (as of Feb 2013). Biggest change
# is the proposed at-rule @font-feature-values
grammar CSS::Module::CSS3::Fonts {

    use     CSS::Module::CSS3::Fonts::Variants;
    also is CSS::Module::CSS3::Fonts::Variants;

    use     CSS::Module::CSS3::Fonts::Gen::Grammar;
    also is CSS::Module::CSS3::Fonts::Gen::Grammar;

    use     CSS::Module::CSS3::Values_and_Units;
    also is CSS::Module::CSS3::Values_and_Units;

    use       CSS::Module::CSS3::Fonts::Gen::External;
    also does CSS::Module::CSS3::Fonts::Gen::External;

    use CSS::Module::CSS3::Fonts::AtFontFace;

    rule at-rule:sym<font-face> { \@<at-rule-font-face> }
    rule at-rule-font-face {(:i'font-face') <font-face-declarations> }
    # declaration list is scoped to @font-face module properties
    rule font-face-declarations { <declarations=.CSS::Module::CSS3::Fonts::AtFontFace::declarations> }
}

# ----------------------------------------------------------------------

