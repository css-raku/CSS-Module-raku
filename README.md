CSS::Language
=============

CSS::Language is under construction as a validating parser for CSS1 CSS2.1
and CSS3. It is based  on CSS::Grammar, but has a detailed knowledge of
individual properties syntax and can therefore validate to a deeper level and
build simpler higher-level ASTs.

This is not ready for general consumption yet.

My initial aim is to pass most or of the tests in W3C CSS Validator test
suite (source: CVS repository `:pserver:anonymous@dev.w3.org:/sources/public`, directory `./css-validator/autotest/testsuite/`).

To Do
=====
- Complete CSS1 property vocabulary (done)
- Complete CSS21 property vocabulary
- Complete CSS3 extensions vocabulary (Colors, Fonts, Namespaces, Paged-media and Selectors)
- Integrate with W3C CSS Validator test suite
- Pass most of the W3C CSS Validator tests

References
==========
- CSS1 - http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
- CSS21 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html
- CSS3 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html + extension modules (*)



