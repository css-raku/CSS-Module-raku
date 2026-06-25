unit grammar CSS::Module::CSS4;

use CSS::Snapshot2026::Backgrounds::Gen::Grammar;
also is CSS::Snapshot2026::Backgrounds::Gen::Grammar;

use CSS::Snapshot2026::Box::Gen::Grammar;
also is CSS::Snapshot2026::Box::Gen::Grammar;

use CSS::Snapshot2026::Color;
also is CSS::Snapshot2026::Color;

use CSS::Snapshot2026::Images::Gen::Grammar;
also is CSS::Snapshot2026::Images::Gen::Grammar;

use CSS::Snapshot2026::Masking::Gen::Grammar;
also is CSS::Snapshot2026::Masking::Gen::Grammar;

use CSS::Snapshot2026::Shapes::Gen::Grammar;
also is CSS::Snapshot2026::Shapes::Gen::Grammar;

use CSS::Snapshot2026::Values::Gen::Grammar;
also is CSS::Snapshot2026::Values::Gen::Grammar;

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
