#!/usr/bin/env perl6

use Test;

use CSS::Module::CSS3::Colors;
use CSS::Grammar::Test;

my $actions = CSS::Module::CSS3::Colors::Actions.new;

for (
    term   => {input => 'rgb(70%, 50%, 10%)',
               ast => {r => 179, g => 128, b => 26},
               token => {type => 'color', units => 'rgb'},
    },
    term   => {input => 'rgba(100%, 50%, 0%, 0.1)',
               ast => {r => 255, g => 128, b => 0, a=> .1},
               token => {type => 'color', units => 'rgba'},
    },
    term   => {input => 'hsl(120, 100%, 50%)',
               ast => {h => 120, 's' => 100, 'l' => 50},
               token => {type => 'color', units => 'hsl'},
    },
    term   => {input => 'hsla( 180, 100%, 50%, .75 )',
               ast => {h => 180, 's' => 100, 'l' => 50, 'a' => .75},
               token => {type => 'color', units => 'hsla'},
    },
    # clipping of out-of-range values
    term   => {input => 'rgba(101%, 50%, -5%, +1.1)',
               ast => {r => 255, g => 128, b => 0, a => 1},
               token => {type => 'color', units => 'rgba'},
    },
    term   => {input => 'hsl(120, 110%, -50%)',
               ast => {h => 120, 's' => 100, 'l' => 0},
               token => {type => 'color', units => 'hsl'},
    },
    term   => {input => 'hsla( 180, -100%, 150%, 1.75 )',
               ast => {h => 180, 's' => 0, 'l' => 100, 'a' => 1},
               token => {type => 'color', units => 'hsla'},
    },
    # a few invalid cases
    term  => {input => 'rgba(10%,20%,30%)',
              ast => Mu,
              warnings => rx{^usage\: \s rgba\(},
    },
    term  => {input => 'hsl(junk)',
              ast => Mu,
              warnings => rx{^usage\: \s hsl\(},
    },
    term  => {input => 'hsla()',
              ast => Mu,
              warnings => rx{^usage\: \s hsla\(},
    },
    color => {input => 'orange', ast => {"r" => 255, "g" => 165, "b" => 0}},
    color => {input => 'hotpink', ast => {"r" => 255, "g" => 105, "b" => 180}},
    color => {input => 'lavenderblush', ast => {"r" => 255, "g" => 240, "b" => 245}},
    color => {input => 'currentcolor', ast => 'currentcolor'},
    color => {input => 'transparent', ast => 'transparent'},
# http://www.w3.org/TR/2011/REC-css3-color-20110607
# @color-profile is in the process of being dropped
##    at-rule => {input => 'color-profile { name: acme_cmyk; src: url(http://printers.example.com/acmecorp/model1234); }',
##                ast => {"declarations" => {"name" => {"expr" => ["term" => "acme_cmyk"]},
##                                           "src" => {"expr" => ["term" => "http://printers.example.com/acmecorp/model1234"]}},
##                        '@' => "color-profile"},
##    },
    ) {
    my $rule = .key;
    my %expected = @( .value );
    my $input = %expected<input>;

    CSS::Grammar::Test::parse-tests(CSS::Module::CSS3::Colors, $input,
				    :$rule,
				    :$actions,
				    :suite<css3-color>,
				    :%expected );
}

done;
