#!/usr/bin/env perl6

use Test;

use CSS::Language::CSS21;
use CSS::Language::CSS21::Actions;
use lib '.';
use t::AST;

my $css_actions = CSS::Language::CSS21::Actions.new;

for (
    decl => {input => 'azimuth: 30deg',       ast => {property => 'azimuth', expr=> [angle => 30]},
    },
    decl => {input => 'Azimuth : far-right',  ast => {property => 'azimuth', expr  => [angle => 60]},
    },
    decl => {input => 'azimuth: center-left behind',  ast => {property => 'azimuth', expr => [angle => 200]},
    },
    decl => {input => 'AZIMUTH : Rightwards',  ast => {property => 'azimuth', expr => [delta => 20]},
    },
    decl => {input => 'azimuth: inherit',     ast => {property => 'azimuth', inherit => True},
    },
    # background-* - covered by css1
    decl => {input => 'border-collapse: collapse',     ast => {property => 'border-collapse', expr => [ident => 'collapse']},
    },
    decl => {input => 'border-spacing: 2px .1cm',     ast => {property => 'border-spacing', expr => [length => 2, length => .1]},
    },
    decl => {input => 'border-right-color: green',     ast => {property => 'border-right-color', expr => [color => {r => 0, g => 128, b => 0}]},
    },
    decl => {input => 'border-bottom-style: outset',     ast => {property => 'border-bottom-style', expr => [ident => 'outset']},
    },
    decl => {input => 'bottom: 5%',     ast => {property => 'bottom', expr => [percentage => 5]},
    },
    decl => {input => 'caption-side: top',     ast => {property => 'caption-side', expr => [ident => 'top']},
    },
# ...
    decl => {input => 'elevation: 65DEG',     ast => {property => 'elevation', expr => [angle => 65]},
    },
    decl => {input => 'elevation:above',      ast => {property => 'elevation', expr => [angle => 90]},
    },
    decl => {input => 'elevation : LOWER',    ast => {property => 'elevation', expr => [delta => -10]},
    },
    decl => {input => 'background-attachment: FiXed',   ast => {property => 'background-attachment', expr => [ident => 'fixed']},
    },
    decl => {input => 'Background-Attachment :inherit', ast => {property => 'background-attachment', inherit => True},
    },
    decl => {input => 'background-color : #37a', ast => {property => 'background-color', expr => [color => {r => 0x33, g => 0x77, b => 0xAA}]},
    },
    decl => {input => 'background-image : url(images/ok.png)', ast => {property => 'background-image', expr => [url => 'images/ok.png']},
    },
    decl => {input => 'background-repeat : Repeat-x', ast => {property => 'background-repeat', expr => [ident => 'repeat-x']},
    },
    decl => {input => 'background-position : 100% 90%', ast => {"property" => "background-position", "expr" => [["percentage" => 100, "percentage" => 90]]},
    },
    decl => {input => 'border-collapse: separate',   ast => {property => 'border-collapse', expr => [ident => 'separate']},
    },
    decl => {input => 'border-spacing: 3em',   ast => {property => 'border-spacing', expr => [length => 3]},
    },
    decl => {input => 'border-bottom:thick dotted red',
             ast => {"property" => "border-bottom",
                     "expr" => ["border-width" => ["ident" => "thick"],
                                "border-style" => ["ident" => "dotted"],
                                "border-color" => ["color" => {"r" => 255, "g" => 0, "b" => 0}]]},
    },
    decl => {input => 'margin:inherit',
             ast => {"property" => "margin", inherit => True},
    },
    decl => {input => 'size:3ex', ast => {"property" => "size",
                                          "expr" => ["length" => 3]},
    },
    decl => {input => 'visibility:hidden', ast => {"property" => "visibility",
                                                   "expr" => ["ident" => "hidden"]},
    },
    decl => {input => 'page-break-after:auto', ast => {"property" => "page-break-after",
                                                       "expr" => ["ident" => "auto"]},
    },
   ) {

    my $rule = $_.key;
    my %test = $_.value;
    my $input = %test<input>;

    $css_actions.reset;
     my $p = CSS::Language::CSS21.parse( $input, :rule($rule), :actions($css_actions));
    t::AST::parse_tests($input, $p, :rule($rule), :suite('css21'),
                         :warnings($css_actions.warnings),
                         :expected(%test) );
}

done;
