use v6;
class CSS::Module:ver<0.5.1> {
    #= a lightweight class for bundling resources associated with a particular CSS Syntax
    use CSS::Module::Property;
    has $.name;
    has $.grammar is required  #| grammar
                  handles <parse subparse parsefile>;
    has $.actions is required  #| actions class
                  handles <colors>;
    has %.property-metadata;
    has %!prop-names;
    method prop-names { %!prop-names }
    has %!alias;
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
            my $prop-num = self.index.elems;
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
    submethod TWEAK(:%alias, :$prop-names! is copy) {
        given $prop-names {
            %!prop-names = $_ ~~ Enumeration ?? .enums !! $_;
        }
        self.alias(name => .key, |.value) for %alias.sort;
    }

    #| parse an individual property-specific expression
    method parse-property(Str() $property-name, Str() $val, Bool :$warn = True) {
        my $actions = $.actions.new;
        my $prop = $property-name.lc;
        $prop = $_ with %!alias{$prop};
        my $rule = 'expr-' ~ $prop;
        my \p = $.grammar.parse($val, :$rule, :$actions );

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
