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

    use     CSS::Module::CSS3::_Base;
    also is CSS::Module::CSS3::_Base;

    use       CSS::Module::CSS3::Fonts::Gen::Interface;
    also does CSS::Module::CSS3::Fonts::Gen::Interface;

    use CSS::Module::CSS3::Fonts::AtFontFace;

    rule font-description {<declarations=.CSS::Module::CSS3::Fonts::AtFontFace::declarations>}
    rule at-rule:sym<font-face> {\@(:i'font-face') <font-description> }
}

# ----------------------------------------------------------------------

