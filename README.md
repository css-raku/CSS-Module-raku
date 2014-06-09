CSS::Language
=============

CSS::Language is experimental and under construction as a Perl 6 validating parser
for CSS Levels 1 and 2.1 and stable/complete Level 3 modules.

CSS::Language extends [CSS::Grammar](https://github.com/p6-css/perl6-CSS-Grammar). 
It performs property-specific parsing and validation of declarations.

This module implements the following grammars and actions:

- `CSS::Language::CSS1` + `CSS::Language::CSS1::Actions`
- `CSS::Language::CSS21` + `CSS::Language::CSS21::Actions`
- `CSS::Language::CSS3` + `CSS::Language::CSS3::Actions`

Parser Actions
--------------
`CSS::Language::CSS1::Actions`, `CSS::Language::CSS21::Actions` or `CSS::Language::CSS3::Actions`
perform validation and abstract syntax tree (AST) construction. Warnings are
produced for any unexpected input.

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

CSS3 Extension Modules
----------------------
CSS Level 3 inherits all CSS2.1 properties and definitions. These are then
extended via CSS3 Extension Modules that are at
various levels of maturity. Furthermore, modules may be domain
or media specific - see http://www.css3.info/modules/

`CSS::Langauge::CSS3` mirrors, this structure, inheriting from CSS2.1, then
extending the language through a number of loosely coupled extension
modules.

- `CSS::Langauge::CSS3::CSS21_Imported` - the full set of CSS21 properties
- `CSS::Language::CSS3::Colors`     - CSS 3.0 Colors (@color-profile)
- `CSS::Language::CSS3::Fonts`      - CSS 3.0 Fonts (@font-face)
- `CSS::Language::CSS3::Selectors`  - CSS 3.0 Selectors
- `CSS::Language::CSS3::Namespaces` - CSS 3.0 Namespace (@namespace)
- `CSS::Language::CSS3::Media`      - CSS 3.0 Media (@media)
- `CSS::Language::CSS3::PagedMedia` - CSS 3.0 Paged Media (@page)

Specification Grammar
---------------------
`CSS::Language::Specification` is also included in this distribution.

It implements the synopsis grammar used throughout the W3C documents to specify
properties and functions. For example, the specification for `border-color` is:

    'border-color' [ <color> | transparent ]{1,4} | inherit

It was used to generate the initial grammars and actions in this module.
Example usage:

    % etc/gen-properties.pl gen grammar etc/css21-properties.txt

Installation
------------
This module works with Rakudo Star 2013.02 [download from http://rakudo.org/downloads/star/ - don't forget the final `make install`]:

Ensure that `perl6` and `panda` are available on your path, e.g. :

    % export PATH=~/src/rakudo-star-2013.02/install/bin:$PATH

You can then use `panda` to test and install `CSS::Language`:

    % panda install CSS::Language

To try parsing some content:

    % perl6 -MCSS::Language::CSS21 -e"say CSS::Language::CSS21.parse('h1 {margin:2pt; color: blue}')"

See Also
========
- [CSS::Grammar](https://github.com/p6-css/perl6-CSS-Grammar) - base grammars
- [CSS::Drafts](https://github.com/p6-css/perl6-CSS-Drafts) - CSS draft extension modules

References
==========
- CSS1 - http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
- CSS21 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html
- CSS3
  - CSS Snapshot 2010 - http://www.w3.org/TR/2011/NOTE-css-2010-20110512/
  - CSS Color Module Level 3 - http://www.w3.org/TR/2011/REC-css3-color-20110607/
  - CSS Fonts Module Level 3 - http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
  - CSS3 Namespaces Module - http://www.w3.org/TR/2011/REC-css3-namespace-20110929/
  - CSS3 Media Query Extensions - http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/
  - CSS3 Module: Paged Media - http://www.w3.org/TR/2006/WD-css3-page-20061010/
  - CSS Selectors Module Level 3 - http://www.w3.org/TR/2011/REC-css3-selectors-20110929/


