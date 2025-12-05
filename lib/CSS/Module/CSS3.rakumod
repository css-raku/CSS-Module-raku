use v6;

# css3 - css21 base properties + css3 extensions
# link: http://www.w3.org/TR/2011/NOTE-css-2010-20110512/#css3
grammar CSS::Module::CSS3 {

    use     CSS::Module::CSS3::Colors;
    also is CSS::Module::CSS3::Colors;

    use     CSS::Module::CSS3::Fonts;
    also is CSS::Module::CSS3::Fonts;

    use     CSS::Module::CSS3::MediaQueries;
    also is CSS::Module::CSS3::MediaQueries;

    use     CSS::Module::CSS3::Namespaces;
    also is CSS::Module::CSS3::Namespaces;

    use     CSS::Module::CSS3::PagedMedia;
    also is CSS::Module::CSS3::PagedMedia;

    use     CSS::Module::CSS3::Selectors;
    also is CSS::Module::CSS3::Selectors;

    use     CSS::Module::CSS21;
    also is CSS::Module::CSS21::_Body;

    use     CSS::Module::CSS3::Values_and_Units;
    also is CSS::Module::CSS3::Values_and_Units;

    use CSS::Module;

    method module(|c) {
        use CSS::Module::CSS3::Actions;
        use CSS::Module::CSS3::Metadata;
        use CSS::Module::CSS3::Fonts::AtFontFace;
        my constant Metadata = CSS::Module::CSS3::Metadata;
        CSS::Module.new(
            :name<CSS3>,
            :grammar($?CLASS),
	    :actions(CSS::Module::CSS3::Actions),
	    :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names),
            :index(&Metadata::index),
            :sub-module('@font-face' => CSS::Module::CSS3::Fonts::AtFontFace.module),
            |c
	    );
    }

};

