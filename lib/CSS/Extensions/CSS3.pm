use v6;

# css3 - with all extensions enabled
grammar CSS::Extensions::CSS3 {...};
class   CSS::Extensions::CSS3::Actions {...};

use CSS::Extensions::CSS3::Colors;
use CSS::Extensions::CSS3::Fonts;
use CSS::Extensions::CSS3::Media;
use CSS::Extensions::CSS3::Namespaces;
use CSS::Extensions::CSS3::PagedMedia;
use CSS::Extensions::CSS3::Selectors;

use CSS::Language::CSS21;
use CSS::Language::Actions;

grammar CSS::Extensions::CSS3
    is CSS::Extensions::CSS3::Colors
    is CSS::Extensions::CSS3::Fonts
    is CSS::Extensions::CSS3::Media
    is CSS::Extensions::CSS3::Namespaces
    is CSS::Extensions::CSS3::PagedMedia
    is CSS::Extensions::CSS3::Selectors
    is CSS::Language::CSS21
{};

class CSS::Extensions::CSS3::Actions
    is CSS::Extensions::CSS3::Colors::Actions
    is CSS::Extensions::CSS3::Fonts::Actions
    is CSS::Extensions::CSS3::Media::Actions
    is CSS::Extensions::CSS3::Namespaces::Actions
    is CSS::Extensions::CSS3::PagedMedia::Actions
    is CSS::Extensions::CSS3::Selectors::Actions
    is CSS::Language::Actions
{};