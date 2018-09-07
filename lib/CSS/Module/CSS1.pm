use v6;

# references:
# -- http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
# -- http://129.69.59.141/css1pqre.htm

use CSS::Module;
use CSS::Specification::Terms;
use CSS::Grammar::CSS1;
# make-modules.pl targets
use CSS::Module::CSS1::Spec::Interface;
use CSS::Module::CSS1::Spec::Grammar;

grammar CSS::Module::CSS1 #:api<css1-20080411>
    is CSS::Specification::Terms
    is CSS::Grammar::CSS1
    is CSS::Module::CSS1::Spec::Grammar
    does CSS::Module::CSS1::Spec::Interface {

        method module {
	    use CSS::Module::CSS1::Actions;
            use CSS::Module::CSS1::Metadata;
	    state $ = CSS::Module.new(
                :name<CSS1>,
                :grammar($?CLASS),
                :actions(CSS::Module::CSS1::Actions),
                :property-metadata($CSS::Module::CSS1::Metadata::property),
            );
        }

        # allow color names and define our vocabulary
        rule color:sym<named>  {:i [aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | purple | red | silver | teal | white | yellow] & <keyw> }
}
