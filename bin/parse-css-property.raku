use CSS::Module;
use CSS::Module::CSS1;
use CSS::Module::CSS21;
use CSS::Module::CSS3;
use CSS::Module::Snapshot2026;
use CSS::Writer;

sub MAIN(
    *@input,
    Str:D :$property!,
    Str:D :$level = 'Snapshot2026',
    Bool  :$trace = True,
    Bool  :$warn = True,
    Str   :$at-rule,
    Bool  :$rewrite,
    Bool  :$color-names = True,
    Bool  :$terse
) {
    my $class = do given $level {
        when /^[:i css]?1/      { CSS::Module::CSS1 }
        when /^[:i css]?2\.?1?/ { CSS::Module::CSS21 }
        when /^[:i css]?3/ { CSS::Module::CSS3 }
        when /^[:i css|snapshot]?2026/ { CSS::Module::Snapshot2026 }
        default {
            fail "usage --level css?[1|2.1|3]|snapshot2026";
        }
    }
    my CSS::Module:D $module = $class.module;
    if $at-rule {
        my $module-name = $module.name;
        my $submodule-name = '@' ~ $at-rule.subst(/^\@/, '').lc;
        $module = $module.sub-module{ $submodule-name }
            // fail "no such $module-name sub-module: $submodule-name" 
    }
    my $expr = $module.parse-property($property.lc, @input.join(' '), :$warn, :$trace);
    dd $expr;
    if $rewrite {
        say CSS::Writer.new(:$color-names, :$terse).write-property: %( :ident($property), :$expr );
    }
}
                          
