use v6;

# specification: http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html


grammar CSS::Module::CSS21 {

    our grammar _Body {
        use CSS::Module::CSS21::Gen::Grammar;
        also is CSS::Module::CSS21::Gen::Grammar;

        token proforma:sym<inherit> {:i inherit}

        # allow color names and define our vocabulary
        rule color:sym<named> {:i [ aqua | black | blue | fuchsia | gray | green | lime | maroon | navy | olive | orange | purple | red | silver | teal | white | yellow ] & <keyw> }

        # system colors are a css2 anachronism
        rule color:sym<system> {:i [ ActiveBorder | ActiveCaption | AppWorkspace | Background | ButtonFace | ButtonHighlight | ButtonShadow | ButtonText | CaptionText | GrayText | Highlight | HighlightText | InactiveBorder | InactiveCaption | InactiveCaptionText | InfoBackground | InfoText | Menu | MenuText | Scrollbar | ThreeDDarkShadow | ThreeDFace | ThreeDHighlight | ThreeDLightShadow | ThreeDShadow | Window | WindowFrame | WindowText ] & <system=.keyw> }

        # --- Functions --- #

        rule attr     {:i'attr(' [ <attribute_name=.qname> || <any-args>] ')'}

        rule counter  {:i'counter(' [ <identifier> [ ',' <expr-list-style-type> ]* || <any-args> ] ')'}
        rule counters {:i'counters(' [ <identifier> [ ',' <string> [ ',' <expr-list-style-type> ]* ]? || <any-args> ] ')' }
        rule shape    {:i'rect(' [ [ <length> | auto & <keyw> ]**4 %',' || <any-args> ] ')'     }
    }
    also is _Body;

    use     CSS::Module;

    use     CSS::Specification::Defs;
    also is CSS::Specification::Defs;

    use     CSS::Grammar::CSS21;
    also is CSS::Grammar::CSS21;

    use       CSS::Module::CSS21::Gen::Interface;
    also does CSS::Module::CSS21::Gen::Interface;

    method module(|c) {
        use CSS::Module::CSS21::Actions;
        use CSS::Module::CSS21::Metadata;
        my constant Metadata = CSS::Module::CSS21::Metadata;

        CSS::Module.new(
            :name<CSS2.1>,
            :grammar($?CLASS),
	    :actions(CSS::Module::CSS21::Actions),
            :property-metadata($Metadata::property),
            :prop-names(Metadata::prop-names),
            :index(&Metadata::index),
            |c
        );
    }

}
