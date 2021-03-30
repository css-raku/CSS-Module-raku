use v6;
use CSS::Grammar;

class CSS::Module:ver<0.5.3> {
    #= a lightweight class for bundling resources associated with a particular CSS Syntax
    use CSS::Module::Property;
    has $.name;
    has $.grammar is required  #| grammar
                  handles <parse subparse parsefile>;
    has $.actions is required  #| actions class
                  handles <colors>;
    has %.property-metadata;
    has %!prop-names;
    has Code %!coerce;
    method prop-names { %!prop-names }
    has %!alias; # deprecated
    method property-number(Str $_ --> Int) { %!prop-names{.lc} // Int }
    method property-name(UInt $_ --> Str) { .name with self.index[$_]; }
    has &.index;
    method index { &!index() }
    has CSS::Module %.sub-module;

    my subset ExtensionName of Str where .starts-with('-');
    multi method alias(ExtensionName :$name!, Str :$like!) is rw {
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
    method extend(
        Str:D :$name!,
        :$prop-num = self.property-number($name) // self.index.elems,
        :&coerce!,
        Bool :$inherit = False,
        :default($val),
        |c,
    ) {
        %!prop-names{$name} = $prop-num;
        %!coerce{$name} = &coerce;

        my %metadata = %( :$inherit, ), c.hash;
        %metadata<default> //= [$_, [&coerce($_)]]
            with $val;

        %!property-metadata{$name} = %metadata;
        my CSS::Module::Property $prop .= new: :$name, :$prop-num, |%metadata;
        self.index[$prop-num] = $prop;
    }
    submethod TWEAK(:%alias, :%extensions, :$prop-names! is copy) {
        given $prop-names {
            %!prop-names = $_ ~~ Enumeration ?? .enums !! $_;
        }
        self.alias(name => .key, |.value) for %alias.sort;
        self.extend(name => .key, |.value) for %extensions.pairs;
    }

    multi method parse-property(Str $property-name where (%!coerce{$_}:exists), $val) {
         %!coerce{$property-name}.($val);
    }
    #| parse an individual property-specific expression
    multi method parse-property(Str $property-name, $val, Bool :$warn = True) {
        my $actions = $.actions.new;
        my $prop = $property-name.lc;
        $prop = $_ with %!alias{$prop};
        my $rule = 'expr-' ~ $prop;
        my \p = $.grammar.parse($val.Str, :$rule, :$actions );

        if p {
            $actions.list(p);
        }
        else {
            note "unable to parse CSS property '$property-name: $val;'"
                if $warn;
            Nil;
        }
    }
}
