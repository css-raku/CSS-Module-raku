use v6;

grammar CSS::Language::_Base {
    # definitions common to CSS1, CSS21 and CSS3 Languages
    rule declaration:sym<validated> { <.ws>? <decl> <prio>**0..1 <any-arg>* <end-decl> }
    proto rule decl {*}

    # For handling undimensioned numbers and angles
    token length:sym<num> {<number>}
    token angle:sym<num>  {<number>}

    token integer     {[\+|\-]?\d+ <!before ['%'|\w|'.']>}
    token number      {<num> <!before ['%'|\w]>}
    token uri         {<url>}
    token keyw        {<ident>}             # keywords (case insensitive)
    token identifier  {<name>}              # identifiers (case sensitive)
    rule identifiers  {[ <identifier> ]+}   # sequences of identifiers

}
