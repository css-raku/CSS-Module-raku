use v6;
class CSS::Module:ver<0.5.0> {
    #= a lightweight class for bundling resources associated with a particular CSS Syntax
    has $.name;
    has $.grammar is required  #| grammar
                  handles <parse subparse parsefile>;
    has $.actions is required  #| actions class
                  handles <colors>;
    has %.property-metadata;
    has $.prop-names;
    method property-number(Str $_ --> Int) { $!prop-names.enums{$_} // Int }
    method property-name(UInt $_ --> Str) { (.key with $!prop-names($_)) // Str; }
    has &.index;
    method index { &!index() }
    has CSS::Module %.sub-module;

    #| parse an individual property-specific expression
    method parse-property(Str() $property-name, Str() $val, Bool :$warn = True) {
        my $actions = $.actions.new;
        my \p = $.grammar.parse($val, :rule('expr-' ~ $property-name.lc), :$actions );

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
