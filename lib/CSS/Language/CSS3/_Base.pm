use v6;

use CSS::Grammar::CSS3;
use CSS::Language::Actions;

grammar CSS::Language::CSS3::_Base
    is CSS::Grammar::CSS3 {
        token integer     {[\+|\-]?\d+ <!before ['%'|\w|'.']>}
        token number      {<num> <!before ['%'|\w]>}
        token uri         {<url>}
        token keyw        {<ident>}           # keywords (case insensitive)
        token identifier  {<ident-cs>}        # identifiers (case sensitive)
        rule identifiers  {[ <identifier> ]+} # sequences of identifiers
}

class CSS::Language::CSS3::_Base::Actions 
    is CSS::Language::Actions {
}
