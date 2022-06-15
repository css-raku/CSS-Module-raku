use v6;

class CSS::Module::CSS3::Actions {

    use     CSS::Module::CSS3::Colors;
    also is CSS::Module::CSS3::Colors::Actions;

    use     CSS::Module::CSS3::Fonts::Actions;
    also is CSS::Module::CSS3::Fonts::Actions;

    use     CSS::Module::CSS3::MediaQueries;
    also is CSS::Module::CSS3::MediaQueries::Actions;

    use     CSS::Module::CSS3::Namespaces;
    also is CSS::Module::CSS3::Namespaces::Actions;

    use     CSS::Module::CSS3::PagedMedia;
    also is CSS::Module::CSS3::PagedMedia::Actions;

    use     CSS::Module::CSS3::Selectors::Actions;
    also is CSS::Module::CSS3::Selectors::Actions;

    use     CSS::Module::CSS21::Actions;
    also is CSS::ModuleX::CSS21::Actions;

    use     CSS::Module::CSS3::_Base::Actions;
    also is CSS::Module::CSS3::_Base::Actions;
}
