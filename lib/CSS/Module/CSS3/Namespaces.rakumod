use v6;

# CSS3 Namespaces Extension Module
# specification: http://www.w3.org/TR/2011/REC-css3-namespace-20110929/
#

class CSS::Module::CSS3::Namespaces {

    rule at-decl:sym<namespace> {'@'(:i'namespace') <ns-prefix=.Ident>? [<url=.url-string>|<url>] ';' }

    class Actions {
        use CSS::Grammar::Defs :CSSObject;
        method at-decl:sym<namespace>($/) { make $.build.at-rule($/) }
    }
}
