unit grammar CSS::Module::CSS4::Colors;

use CSS::Module::CSS3::Colors;
also is CSS::Module::CSS3::Colors;

token color-delim {','?} # comma becomes optional in CSS4 rgb() rgba() and hsl()
