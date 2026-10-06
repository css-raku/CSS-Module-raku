use v6;
use NativeCall;
# native representation of a property;
class CSS::Module::Property is repr('CStruct') {
    has Str $.name;
    has uint16 $.prop-num;

    has bool $.inherit;
    method inherit { ? $!inherit }

    has bool $.initial;
    method initial { ? $!initial }

    has bool $.box;
    method box { ? $!box }

    has uint16 $.edge;
    has Str $.synopsis;

    has Str $.default;

    has CArray[uint16] $.children;
    has CArray[Str] $.child-names;
    has CArray[uint16] $.edges;
    has CArray[Str] $.edge-names;

    submethod BUILD(:$!inherit = 0, :$!initial = 0, :$!box = 0) {}
    submethod TWEAK(:$enums, Str:D :$name!, :$!prop-num = (my uint16 $ = $enums{$name}), List :$children, List :$edges, Str :$edge, Str :$default, Str :$synopsis) {
        $!name := $name;
        $!synopsis := $_ with $synopsis;
        with $children {
            $!child-names := CArray[Str].new(|$_);
            $!children := CArray[uint16].new(|.map({$enums{$_}}))
        }
        with $edges {
            $!edge-names := CArray[Str].new(|$_);
            $!edges := CArray[uint16].new(|.map({$enums{$_}}));
        }
        $!edge = $enums{$_} with $edge;
        $!default := $_ with $default;
    }

    multi method COERCE(%meta) { self.new: |%meta }
}
