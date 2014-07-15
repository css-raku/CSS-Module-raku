use v6;

# css3 - css21 base properties + css3 extensions
grammar CSS::Module::CSS3 {...};
class   CSS::Module::CSS3::Actions {...};

use CSS::Module::CSS21::Actions;
use CSS::Module::CSS21;

use CSS::Module::CSS3::Colors;
use CSS::Module::CSS3::Fonts;
use CSS::Module::CSS3::MediaQueries;
use CSS::Module::CSS3::Namespaces;
use CSS::Module::CSS3::PagedMedia;
use CSS::Module::CSS3::Selectors;
use CSS::Module::CSS3::_Base;

class CSS::Module::CSS3::Actions
    is CSS::Module::CSS3::Colors::Actions
    is CSS::Module::CSS3::Fonts::Actions
    is CSS::Module::CSS3::MediaQueries::Actions
    is CSS::Module::CSS3::Namespaces::Actions
    is CSS::Module::CSS3::PagedMedia::Actions
    is CSS::Module::CSS3::Selectors::Actions
    is CSS::ModuleX::CSS21::Actions
    is CSS::Module::CSS3::_Base::Actions
{};

grammar CSS::Module::CSS3
    is CSS::Module::CSS3::Colors
    is CSS::Module::CSS3::Fonts
    is CSS::Module::CSS3::MediaQueries
    is CSS::Module::CSS3::Namespaces
    is CSS::Module::CSS3::PagedMedia
    is CSS::Module::CSS3::Selectors
    is CSS::ModuleX::CSS21
    is CSS::Module::CSS3::_Base
{};

