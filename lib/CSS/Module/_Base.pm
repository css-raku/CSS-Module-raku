use v6;

use CSS::Specification::_Base;

grammar CSS::Module::_Base 
    is CSS::Specification::_Base {
    # definitions common to CSS1, CSS21 and CSS3 Modules
    rule declaration { <.ws>? <decl> <prio>? <any-arg>* <end-decl> || <dropped-decl> }
    proto rule decl {*}

    token length:sym<zero> {<number> <?{ +$<number> == 0 }> }
    token angle:sym<zero>  {<number> <?{ +$<number> == 0 }> }

    token integer     {$<sign>=< + - >?<uint>}
    token uint        {\d+}
    token number      {<num> <!before ['%'|\w]>}
    token uri         {<url>}
    token keyw        {<Ident>}             # keyword (case insensitive)
    token identifier  {<name>}              # identifier (case sensitive)
    rule identifiers  {[ <identifier> ]+}   # E.g. font name: Times New Roman

}
