use v6;

# CSS3 Namespaces Extension Module
# specification: http://www.w3.org/TR/2011/REC-css3-namespace-20110929/
#

grammar CSS::Extensions::CSS3::Namespaces::Syntax {

    rule at_decl:sym<namespace> {(:i'namespace') <prefix=.ident>? [<url=.string>|<url>] ';' }

}

grammar CSS::Extensions::CSS3::Namespaces:ver<20110929.000>
    is CSS::Extensions::CSS3::Namespaces::Syntax {
}

class CSS::Extensions::CSS3::Namespaces::Actions {
    method at_decl:sym<namespace>($/) { make $.at_rule($/) }
}

