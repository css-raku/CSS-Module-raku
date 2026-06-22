unit grammar CSS::Module::CSS4;
use CSS::Module::SVG;
also is CSS::Module::SVG;

use CSS::Module::CSS4::Backgrounds;
also is CSS::Module::CSS4::Backgrounds;

use CSS::Module::CSS4::Color;
also is CSS::Module::CSS4::Color;

use CSS::Module::CSS4::Images;
also is CSS::Module::CSS4::Images;

use CSS::Module::CSS4::Masking;
also is CSS::Module::CSS4::Masking;

use CSS::Module::CSS4::Shapes;
also is CSS::Module::CSS4::Shapes;

use CSS::Module::CSS4::Values;
also is CSS::Module::CSS4::Values;

use CSS::Module::CSS4::Backgrounds::Gen::External;
also does CSS::Module::CSS4::Backgrounds::Gen::External;
use CSS::Module::CSS4::Color::Gen::External;
also does CSS::Module::CSS4::Color::Gen::External;
use CSS::Module::CSS4::Masking::Gen::External;
also does CSS::Module::CSS4::Masking::Gen::External;
use CSS::Module::CSS4::Shapes::Gen::External;
also does CSS::Module::CSS4::Shapes::Gen::External;
use CSS::Module::CSS4::Values::Gen::External;
also does CSS::Module::CSS4::Values::Gen::External;

method module(|c) {
    use CSS::Module::CSS4::Actions;
    use CSS::Module::CSS4::Metadata;
    use CSS::Module::CSS3::Fonts::AtFontFace;
    my constant Metadata = CSS::Module::CSS4::Metadata;
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
