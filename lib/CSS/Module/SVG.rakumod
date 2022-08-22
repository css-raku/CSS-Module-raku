use v6;

# svg properties
# link: https://www.w3.org/TR/SVG/propidx.html
grammar CSS::Module::SVG {

    use     CSS::Module::SVG::Gen::Grammar;
    also is CSS::Module::SVG::Gen::Grammar;

    use     CSS::Module::CSS3;
    also is CSS::Module::CSS3;

    use CSS::Module;

    method module(|c) {
        use CSS::Module::SVG::Actions;
        use CSS::Module::SVG::Metadata;
        my constant Metadata = CSS::Module::SVG::Metadata;
        CSS::Module.new(
            :name<SVG>,
            :grammar($?CLASS),
	    :actions(CSS::Module::SVG::Actions),
	    :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names),
            :index(&Metadata::index),
            |c
	);
    }

};

