#| a lightweight class for bundling resources associated with a particular CSS Syntax
unit class CSS::Module:ver<0.7.6>;

use CSS::Grammar;
use CSS::Module::Property;
use CSS::Writer;
has Str $.name;
has $.grammar is required  #| grammar
              handles <parse subparse parsefile>;
has $.actions is required  #| actions class
              handles <colors>;
has Hash %.property-metadata;
has %!prop-names;
has Code %.coerce is built;
method prop-names { %!prop-names }
has %!alias; # deprecated
has Bool %!is-expr;
has Bool $.vivify;
method property-number(Str:D $_ --> Int) {
    %!prop-names{.lc}
        // ($!vivify ?? self.extend(:name($_)) !! Int);
}
method property-name(UInt $_ --> Str) { .name with self.index[$_]; }
has &.index;
method index { &!index() }
has CSS::Module %.sub-module;

method !register-property(:$name!, :%metadata) {
    die "unable to register container property '$name' - NYI"
        if %metadata<children> || %metadata<box>;

    my $prop-num = self.property-number($name) // self.index.elems;
    %!prop-names{$name} = $prop-num;
    %!property-metadata{$name} = %metadata;
    my CSS::Module::Property $prop .= new: :$name, :$prop-num, |%metadata;
    self.index[$prop-num] = $prop;
    $prop-num;
}

multi method extend(
    Str:D :$name! is copy,
    Str:D :$like!,
    :&coerce,
    |c
) {
    $name .= lc;
    my $base-prop = $like.lc;
    die "unknown base property: $name"
        unless %!property-metadata{$base-prop}:exists;
    my %metadata = %!property-metadata{$base-prop};
    %metadata ,= c.hash;
    %!alias{$name} = $base-prop;
    %!coerce{$name} = $_ with &coerce;
    self!register-property: :$name, :%metadata;
}
multi method extend(
    Str:D :$name! is copy,
    :&coerce,
    :$prop-num = %!prop-names{$name.lc} // self.index.elems,
    Bool :$inherit = False,
    :$default,
    |c,
) {
    $name .= lc;
    %!prop-names{$name} = $prop-num;

    my %metadata = %( :$inherit, );
    %metadata ,= c.hash;

    if &coerce {
        %!coerce{$name} = &coerce;
        %metadata<default> = CSS::Writer.write(.&coerce)
           with $default;
    }
    else {
        %!is-expr{$name}++;
        %metadata<default> = .Str with $default;
    }

    self!register-property: :$name, :%metadata;
}

submethod TWEAK(:%alias, :%extensions, :$prop-names! is copy) {
    given $prop-names {
        %!prop-names = $_ ~~ Enumeration ?? .enums !! $_;
    }
    self.extend(name => .key, like => .value) for %alias.sort;
    self.extend(name => .key, |.value) for %extensions.sort;
}

multi method parse-property(Str:D $property-name where (%!coerce{.lc}:exists), $val, Bool :$warn = True) {
    my $prop = $property-name.lc;
    with try { %!coerce{$prop}.($val); } -> Pair:D $tk {
        $tk.value.so; # trigger failures
        $tk;
    }
    else {
        if $warn {
            note "unable to parse CSS property '$prop: $val;'";
            note .message with $!;
        }
        Nil;
    };
}

#| parse an individual property-specific expression
multi method parse-property(Str:D $property-name, Str() $val, Bool :$warn = True) {
    my $actions = $.actions.new;
    my $prop = $property-name.lc;
    $prop = $_ with %!alias{$prop};
    my $rule = %!is-expr{$prop} ?? 'expr' !! 'css-val-' ~ $prop;
    my $ast;

    if $.grammar.parse($val, :$rule, :$actions ) -> \p {
        $ast := $actions.build.list(p);
        $ast := Nil if $ast eqv [];
    }
    else {
        note "unable to parse CSS property '$property-name: $val;'"
            if $warn;
    }
    if $warn {
        note $_ for $actions.warnings;
    }

    $ast;
}
