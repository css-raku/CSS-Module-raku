use v6;

use CSS::Specification::_Base;

grammar CSS::Module::_Base 
    is CSS::Specification::_Base {
    # definitions common to CSS1, CSS21 and CSS3 Modules
    rule declaration { <decl> <prio>? <any-arg>* <end-decl> || <dropped-decl> }
    proto rule decl {*}

    token length:sym<zero> {<number> <?{ +$<number> == 0 }> }
    token angle:sym<zero>  {<number> <?{ +$<number> == 0 }> }

    token integer     {$<sign>=< + - >?<uint>}
    token uint        {\d+}
    token number      {<num> <!before ['%'|\w]>}
    token uri         {<url>}
    multi token keyw  {<id=.Ident>}         # keyword (case insensitive)
    # work-around for RT#117955 - conjunctive '&&' capture"
    multi token keyw($rx) {<id={$rx}>}          # keyword (case insensitive)
    token identifier  {<name>}              # identifier (case sensitive)
    rule identifiers  {[ <identifier> ]+}   # E.g. font name: Times New Roman

}
