CSS::Language
=============

CSS::Language is under construction as a Perl 6 validating parser for CSS
Levels 1 and 2.1.

CSS::Language extends [CSS::Grammar](https://github.com/p6-css/perl6-CSS-Grammar). 
It performs property-specific parsing and validation of declarations.

This module implements the following grammars and actions:

- `CSS::Language::CSS1` + `CSS::Language::CSS1::Actions`
- `CSS::Language::CSS21` + `CSS::Language::CSS21::Actions`

Parser Actions
--------------
`CSS::Language::CSS1::Actions` or `CSS::Language::CSS21::Actions` can be used
to validate and produce an abstract syntax tree (AST). Warnings are produced
for any unexpected input.

    use v6;
    use CSS::Language::CSS21;
    use CSS::Language::CSS21::Actions;

    my $css = 'H1 { color: blue; foo: bar; background-color: zzz }';

    my $actions =  CSS::Language::CSS21::Actions.new;
    my $p = CSS::Language::CSS21.parse($css, :actions($actions));
    note $_ for $actions.warnings;
    say "declaration: " ~ $p.ast[0]<ruleset><declarations>.perl;
    # output:
    # unknown property: foo - declaration dropped
    # usage background-color: <color> | transparent | inherit
    # declaration: {"color" => {"expr" => ["color" => {"r" => 0, "g" => 0, "b" => 255}]}}

Specification Grammar
---------------------
`CSS::Language::Specification` is also included in this distribution.

It implements the synopsis grammar used throughout the W3C documents to specify
properties and functions. For example, the specification for `border-color` is:

    'border-color' [ <color> | transparent ]{1,4} | inherit

It was used to generate the initial grammars and actions in this modules.
Example usage:

    % etc/gen-properties.pl gen grammar etc/css21-properties.txt

See Also
========
-- [CSS::Grammar](https://github.com/p6-css/perl6-CSS-Grammar) - base grammars
-- [CSS::Language::CSS3](https://github.com/p6-css/perl6-CSS-Language-CSS3)
- under construction as a CSS Level 3 validating parser

References
==========
- CSS1 - http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
- CSS21 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html




