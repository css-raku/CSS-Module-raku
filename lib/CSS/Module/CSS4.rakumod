unit grammar CSS::Module::CSS4;
use CSS::Module::CSS3;
also is CSS::Module::CSS3;

use CSS::Module::CSS4::Colors;
also is CSS::Module::CSS4::Colors;

use CSS::Module::CSS4::Masking;
also is CSS::Module::CSS4::Masking;

use CSS::Module::CSS4::Shapes;
also is CSS::Module::CSS4::Shapes;

use CSS::Module::CSS4::Masking::Gen::External;
also does CSS::Module::CSS4::Masking::Gen::External;
use CSS::Module::CSS4::Shapes::Gen::External;
also does CSS::Module::CSS4::Shapes::Gen::External;

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
