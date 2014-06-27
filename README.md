CSS::Language
=============

CSS::Language is a property-specific validator and parser for CSS Levels 1, 2.1 and  3.

This module implements the following grammars and actions:

- `CSS::Language::CSS1` + `CSS::Language::CSS1::Actions`
- `CSS::Language::CSS21` + `CSS::Language::CSS21::Actions`
- `CSS::Language::CSS3` + `CSS::Language::CSS3::Actions`

Example
-------

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
`CSS::Langauge::CSS3` is composed from a number of loosely coupled extension modules.

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

    % css-gen-properties.pl etc/css21-properties.txt --grammar=My::CSS > lib/My/CSS.pm

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


