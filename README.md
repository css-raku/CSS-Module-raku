CSS::Language
=============

CSS::Language is under construction as a validating parser for CSS1 CSS2.1
and CSS3. It is based on CSS::Grammar, but has a detailed knowledge of
individual properties syntax and can therefore validate to a deeper level and
build simpler higher-level ASTs.

This is not ready for general consumption yet.

My initial aim is to pass most or of the tests in W3C CSS Validator test
suite https://github.com/w3c/css-validator.git

To Do
=====
- ~~Complete CSS1 property vocabulary~~ (done)
- Complete CSS21 property vocabulary
- Complete CSS3 extensions vocabulary (Colors, Fonts, Namespaces, Paged-media and Selectors)
- Integrate with W3C CSS Validator test suite
- Pass most of the W3C CSS Validator tests

Extension Modules
------------------
This distribution includes the following optional CSS3 extension modules:

- `CSS::Extensions::CSS3::Colors`     - CSS 3.0 Colors (@color-profile)
- `CSS::Extensions::CSS3::Selectors`  - CSS 3.0 Selectors
- `CSS::Extensions::CSS3::Fonts`      - CSS 3.0 Fonts (@font-face)
- `CSS::Extensions::CSS3::Media`      - CSS 3.0 Media (@media)
- `CSS::Extensions::CSS3::Namespaces` - CSS 3.0 Namespace (@namespace)
- `CSS::Extensions::CSS3::PagedMedia` - CSS 3.0 Paged Media (@page)

To enable all the above extensions, use the `CSS::Extensions::CSS3`
grammar and `CSS::Extensions::CSS3::Actions` action class.

Enabling Specific CSS3 Extensions
---------------------------------
CSS3 is evolving into a core grammar plus a comprehensive set of extension
[modules](http://www.css3.info/modules/). Most are optional and may extend
both the grammar and generated Abstract Syntax Tree (AST). This leads to a
large number of possible grammar combinations.

If you wish to use a subset of the available extensions, you'll need to
construct a custom grammar and actions that include just the particular CSS3
extension modules that you intend to support.

E.g. to support the CSS3 Core grammar plus Paged Media and Fonts modules:

    use CSS::Language::CSS3;
    use CSS::Extensions::CSS3::Fonts;
    use CSS::Extensions::CSS3::PagedMedia;
    use CSS::Grammar::Actions;

    grammar My_CSS3_Grammar
        is CSS::Extensions::CSS3::Fonts
        is CSS::Extensions::CSS3::PagedMedia
        is CSS::Language::CSS3 {};

    class My_CSS3_Actions
        is CSS::Extensions::CSS3::Fonts::Actions
        is CSS::Extensions::CSS3::PagedMedia::Actions
        is CSS::Language::Actions {};

This gives you a customised grammar and parser that understands the
core CSS3 language, plus Fonts and Paged Media extensions

    my $actions = My_CSS3_Actions.new;
    my $parse = My_CSS3_Grammar.parse( $css_input, :actions($actions) );

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




