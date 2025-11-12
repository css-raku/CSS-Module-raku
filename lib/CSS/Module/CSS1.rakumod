use v6;

# references:
# -- http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
# -- http://129.69.59.141/css1pqre.htm

unit grammar CSS::Module::CSS1;

use CSS::Module;
use CSS::Specification::Base::Grammar;
use CSS::Grammar::CSS1;
# make-modules.raku targets
use CSS::Module::CSS1::Gen::Interface;
use CSS::Module::CSS1::Gen::Grammar;

also is CSS::Grammar::CSS1;
also is CSS::Module::CSS1::Gen::Grammar;
also does CSS::Specification::Base::Grammar;
also does CSS::Module::CSS1::Gen::Interface;

method module(|c) {
    use CSS::Module::CSS1::Actions;
    use CSS::Module::CSS1::Metadata;
    my constant Metadata = CSS::Module::CSS1::Metadata;
    CSS::Module.new(
        :name<CSS1>,
        :grammar($?CLASS),
        :actions(CSS::Module::CSS1::Actions),
        :property-metadata($Metadata::property),
        :prop-names(Metadata::prop-names),
        :index(&Metadata::index),
        |c
    );
}

# allow color names and define our vocabulary
rule color:sym<named>  {:i [aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | purple | red | silver | teal | white | yellow] & <keyw> }

