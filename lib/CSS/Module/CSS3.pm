use v6;

# css3 - css21 base properties + css3 extensions
# link: http://www.w3.org/TR/2011/NOTE-css-2010-20110512/#css3
use CSS::Module;
use CSS::Module::CSS21;

use CSS::Module::CSS3::Colors;
use CSS::Module::CSS3::Fonts;
use CSS::Module::CSS3::MediaQueries;
use CSS::Module::CSS3::Namespaces;
use CSS::Module::CSS3::PagedMedia;
use CSS::Module::CSS3::Selectors;
use CSS::Module::CSS3::_Base;

grammar CSS::Module::CSS3 #:api<css-2010-20110512>
    is CSS::Module::CSS3::Colors
    is CSS::Module::CSS3::Fonts
    is CSS::Module::CSS3::MediaQueries
    is CSS::Module::CSS3::Namespaces
    is CSS::Module::CSS3::PagedMedia
    is CSS::Module::CSS3::Selectors
    is CSS::ModuleX::CSS21
    is CSS::Module::CSS3::_Base {

    method module {
        use CSS::Module::CSS3::Actions;
        use CSS::Module::CSS3::Metadata;
        use CSS::Module::CSS3::Fonts::AtFontFace;
        state $ = CSS::Module.new(
            :name<CSS3>,
            :grammar($?CLASS),
	    :actions(CSS::Module::CSS3::Actions),
	    :property-metadata($CSS::Module::CSS3::Metadata::property),
            :sub-module('@font-face' => CSS::Module::CSS3::Fonts::AtFontFace.module),
	    );
    }

};

