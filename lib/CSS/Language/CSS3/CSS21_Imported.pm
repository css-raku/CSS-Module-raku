use v6;

use CSS::Language::CSS21::Actions;
use CSS::Language::CSS21;
use CSS::Language::CSS3::_Base;

# imports of all CSS21 properties to CSS3
# -- properties get some sugar in the process. e.g. use of the 'initial' keyword
# -- some property definitions get overridden by css3 extensions, so this
#    class should appear last in class ordering/hierarchy

grammar CSS::Language::CSS3::CSS21_Imported::Grammar
    is CSS::Language::CSS3::_Base
    is CSS::Extensions::CSS21
{};

class CSS::Language::CSS3::CSS21_Imported::Actions
    is CSS::Language::CSS21::Actions
{};

