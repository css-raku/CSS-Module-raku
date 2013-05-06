use v6;

# css3 - css21 base properties + css3 extensions
grammar CSS::Language::CSS3 {...};
class   CSS::Language::CSS3::Actions {...};

use CSS::Language::CSS3::Colors;
use CSS::Language::CSS3::Fonts;
use CSS::Language::CSS3::MediaQueries;
use CSS::Language::CSS3::Namespaces;
use CSS::Language::CSS3::PagedMedia;
use CSS::Language::CSS3::Selectors;
use CSS::Language::CSS3::CSS21_Imported;

class CSS::Language::CSS3::Actions
    is CSS::Language::CSS3::Colors::Actions
    is CSS::Language::CSS3::Fonts::Actions
    is CSS::Language::CSS3::MediaQueries::Actions
    is CSS::Language::CSS3::Namespaces::Actions
    is CSS::Language::CSS3::PagedMedia::Actions
    is CSS::Language::CSS3::Selectors::Actions
    is CSS::Language::CSS3::CSS21_Imported::Actions
{};

grammar CSS::Language::CSS3
    is CSS::Language::CSS3::Colors
    is CSS::Language::CSS3::Fonts
    is CSS::Language::CSS3::MediaQueries
    is CSS::Language::CSS3::Namespaces
    is CSS::Language::CSS3::PagedMedia
    is CSS::Language::CSS3::Selectors
    is CSS::Language::CSS3::CSS21_Imported::Grammar
{};

