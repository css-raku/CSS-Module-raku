CSS::Language
=============

CSS::Language is under construction as a validating parser for CSS1 CSS2.1
and CSS3. This is not ready for general consumption yet.

CSS::Language is an extension of CSS::Grammar, but is able to parse
specific properties along with functions and other arguments. Because of this
it is able validate properties and produce meaningful property specific
messages. A second benefit is simpler and more specific ASTs.

This module implements the following grammars and actions:

- CSS::Language::CSS1 + CSS::Language::CSS1::Actions
- CSS::Language::CSS21 + CSS::Language::CSS21::Actions
- CSS::Language::CSS3 + CSS::Language::CSS3::Actions

Extension Modules
------------------
CSS levels 1 an 2 have a single specification; whereas CSS level 3 is
decomposed into a number of modules. CSS::Language::CSS3 is comprised
of the following extension modules. These are under construction and
are also included in this distribution:

- `CSS::Extensions::CSS3::Colors`     - CSS 3.0 Colors (@color-profile)
- `CSS::Extensions::CSS3::Selectors`  - CSS 3.0 Selectors
- `CSS::Extensions::CSS3::Fonts`      - CSS 3.0 Fonts (@font-face)
- `CSS::Extensions::CSS3::Media`      - CSS 3.0 Media (@media)
- `CSS::Extensions::CSS3::Namespaces` - CSS 3.0 Namespace (@namespace)
- `CSS::Extensions::CSS3::PagedMedia` - CSS 3.0 Paged Media (@page)

There are a number of other CSS level 3 modules. 

To Do
=====
My initial aim is to pass most or of the tests in W3C CSS Validator test
suite https://github.com/w3c/css-validator.git

- ~~Complete CSS1 property vocabulary~~ (done)
- Complete CSS21 property vocabulary
- Complete CSS3 extensions vocabulary (Colors, Fonts, Namespaces, Paged-media and Selectors)
- Testing via W3C CSS Validator test suite and/or specifications (etc/css1-prpoerties.txt, etc/css21-properties.txt)
- Pass most of the W3C CSS Validator tests

Specification Grammar
---------------------
CSS::Language::Specification is also included in this distribution.

It implements the synopsis grammar used throughout the W3C documents to specify
properties and functions. For example, the specification for `border-color` is:

    'border-color' [ <color> | transparent ]{1,4} | inherit

References
==========
- CSS1 - http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
- CSS21 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html
- CSS3 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html
- CSS Selectors Module Level 3 - http://www.w3.org/TR/2011/REC-css3-selectors-20110929/
- CSS Color Module Level 3 - http://www.w3.org/TR/2011/REC-css3-color-20110607/
- CSS Fonts Module Level 3 - http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
- CSS Namespaces Module - http://www.w3.org/TR/2011/REC-css3-namespace-20110929/
- CSS3 Media Query Extensions - http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/




