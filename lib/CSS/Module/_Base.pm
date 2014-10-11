use v6;

use CSS::Specification::_Base;

grammar CSS::Module::_Base 
    is CSS::Specification::_Base {
    # definitions common to CSS1, CSS21 and CSS3 Languages
    rule module-declaration:sym<validated> {:my $*USAGE; <.ws>? <decl> <prio>? <any-arg>* <end-decl> }
    proto rule decl {*}

    token length:sym<zero> {<number> <?{ +$<number> == 0 }> }
    token angle:sym<zero>  {<number> <?{ +$<number> == 0 }> }

    token integer     {< + - >?<uint>}
    token uint        {\d+}
    token number      {<num> <!before ['%'|\w]>}
    token uri         {<url>}
    token keyw        {<ident>}             # keyword (case insensitive)
    token identifier  {<name>}              # identifier (case sensitive)
    rule identifiers  {[ <identifier> ]+}   # E.g. font name: Times New Roman

}
