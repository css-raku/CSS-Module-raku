use v6;

class CSS::Language::Actions {

    method declaration:sym<raw>($/)        {
        $.warning('unknown property', $<property>.ast, 'declaration dropped');
    }

    method declaration:sym<validated>($/)        {
        warn "todo: declaration_validated: " ~ $/.Str;
        make $.node($/);
    }


};
