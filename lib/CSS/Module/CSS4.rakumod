unit grammar CSS::Module::CSS4;
use CSS::Module::CSS3;
also is CSS::Module::CSS3;

use CSS::Module::CSS4::Colors;
also is CSS::Module::CSS4::Colors;

use CSS::Module::CSS4::Masking;
also is CSS::Module::CSS4::Masking;


method module(|c) {
    use CSS::Module::CSS4::Actions;
    use CSS::Module::CSS3::Metadata;
    use CSS::Module::CSS3::Fonts::AtFontFace;
    my constant Metadata = CSS::Module::CSS3::Metadata;
    CSS::Module.new(
        :name<CSS4>,
        :grammar($?CLASS),
        :actions(CSS::Module::CSS4::Actions),
        :property-metadata($Metadata::property),
        :prop-names(Metadata::prop-names),
        :index(&Metadata::index),
        :sub-module('@font-face' => CSS::Module::CSS3::Fonts::AtFontFace.module),
        |c
        );
}
