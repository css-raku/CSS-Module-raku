#| a lightweight class for bundling resources associated with a particular CSS Syntax
unit class CSS::Module:ver<0.7.0>;

use CSS::Grammar;
use CSS::Module::Property;
has $.name;
has $.grammar is required  #| grammar
              handles <parse subparse parsefile>;
has $.actions is required  #| actions class
              handles <colors>;
has Hash %.property-metadata;
has %!prop-names;
has Code %.coerce is built;
method prop-names { %!prop-names }
has %!alias; # deprecated
has Bool %!allow;
has Bool $.vivify;
method property-number(Str:D $_ --> Int) {
    %!prop-names{.lc}
        // ($!vivify ?? self.extend(:name($_)) !! Int);
}
method property-name(UInt $_ --> Str) { .name with self.index[$_]; }
has &.index;
method index { &!index() }
has CSS::Module %.sub-module;

my subset ExtensionName of Str where .starts-with('-');
proto method alias(|) is DEPRECATED('extend(:$name, :$like, ...)') {*};
multi method alias(ExtensionName :$name! is copy, Str :$like! is copy) is rw {
    $name .= lc;
    $like .= lc;
    my $metadata = %!property-metadata{$like}
        // die "unable to alias unknown property: '$like'";

    die "unable to alias container property '$like' - NYI"
        if $metadata<children> || $metadata<box>;

    with %!prop-names{$name} {
        die "conflicting property alias: '$name'"
            unless %!alias{$name} ~~ $like;
    }
    else {
        my UInt $prop-num = self.index.elems;
        %!alias{$name} = $like;
        %!prop-names{$name} = $prop-num;
        %!property-metadata{$name} = %!property-metadata{$like};
        %!property-metadata{$name}<default>:delete
            without %!property-metadata{$name}<default>[1];
        self.index[$prop-num] = CSS::Module::Property.new: :$name, :$prop-num, |%!property-metadata{$name};
    }
    %(:$name, :$like);
}
multi method alias($name) is default {
    my $like = %!alias{$name} // die "unknown property alias: '$name'";
    %(:$name, :$like);
}

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
    Str:D :like($base-prop)! is copy,
    :&coerce,
    |c
) {
    $name .= lc;
    $base-prop .= lc;
    die "unknown base property: $name"
        unless %!property-metadata{$base-prop}:exists;
    my %metadata = %!property-metadata{$base-prop};
    %metadata<default>:delete
        without %metadata<default>[1];
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
    :default($val),
    |c,
) {
    $name .= lc;
    %!prop-names{$name} = $prop-num;

    my %metadata = %( :$inherit, );
    %metadata ,= c.hash;
    with &coerce -> &c {
        %!coerce{$name} = &c;
        %metadata<default> //= [$_, [&c($_)]]
            with $val;
    }
    else {
        %!allow{$name}++;
    }
    self!register-property: :$name, :%metadata;
}

submethod TWEAK(:%alias, :%extensions, :$prop-names! is copy) {
    given $prop-names {
        %!prop-names = $_ ~~ Enumeration ?? .enums !! $_;
    }
    self.alias(name => .key, |.value) for %alias.sort;
    self.extend(name => .key, |.value) for %extensions.sort;
}

multi method parse-property(Str $property-name where (%!coerce{$_}:exists), $val, Bool :$warn = True) {
    with try { %!coerce{$property-name}.($val); } -> Pair:D $tk {
        $tk.value.so; # trigger failures
        $tk;
    }
    else {
        if $warn {
            note "unable to parse CSS property '$property-name: $val;'";
            note .message with $!;
        }
        Nil;
    };
}

#| parse an individual property-specific expression
multi method parse-property(Str $property-name, $val, Bool :$warn = True) {
    my $actions = $.actions.new;
    my $prop = $property-name.lc;
    $prop = $_ with %!alias{$prop};
    my $rule = %!allow{$prop} ?? 'expr' !! 'css-val-' ~ $prop;

    if $.grammar.parse($val.Str, :$rule, :$actions ) -> \p {
        $actions.build.list(p);
    }
    else {
        if $warn {
            note "unable to parse CSS property '$property-name: $val;'";
            note $_ for $actions.warnings;
        }
        Nil;
    }
}
