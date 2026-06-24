unit grammar CSS::Module::CSS4;

use CSS::Snapshot2026::Backgrounds;
also is CSS::Snapshot2026::Backgrounds;

use CSS::Snapshot2026::Box;
also is CSS::Snapshot2026::Box;

use CSS::Snapshot2026::Color;
also is CSS::Snapshot2026::Color;

use CSS::Snapshot2026::Images;
also is CSS::Snapshot2026::Images;

use CSS::Snapshot2026::Masking;
also is CSS::Snapshot2026::Masking;

use CSS::Snapshot2026::Shapes;
also is CSS::Snapshot2026::Shapes;

use CSS::Snapshot2026::Values;
also is CSS::Snapshot2026::Values;

use CSS::Module::SVG;
also is CSS::Module::SVG;

use CSS::Snapshot2026::Backgrounds::Gen::External;
also does CSS::Snapshot2026::Backgrounds::Gen::External;

use CSS::Snapshot2026::Box::Gen::External;
also does CSS::Snapshot2026::Box::Gen::External;

use CSS::Snapshot2026::Color::Gen::External;
also does CSS::Snapshot2026::Color::Gen::External;

use CSS::Snapshot2026::Masking::Gen::External;
also does CSS::Snapshot2026::Masking::Gen::External;

use CSS::Snapshot2026::Images::Gen::External;
also does CSS::Snapshot2026::Images::Gen::External;

use CSS::Snapshot2026::Shapes::Gen::External;
also does CSS::Snapshot2026::Shapes::Gen::External;

use CSS::Snapshot2026::Values::Gen::External;
also does CSS::Snapshot2026::Values::Gen::External;

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
