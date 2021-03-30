use v6;
use NativeCall;
# native representation of a property;
class CSS::Module::Property is repr('CStruct') {
    has Str $.name;
    has uint8 $.prop-num;

    has uint8 $.inherit;
    method inherit { ? $!inherit }

    has uint8 $.initial;
    method initial { ? $!initial }

    has uint8 $.box;
    method box { ? $!box }

    has uint8 $.edge;
    has Str $.synopsis;

    has Str $.default-type;
    has Str $.default;

    has CArray[uint8] $.children;
    has CArray[Str] $.child-names;
    has CArray[uint8] $.edges;
    has CArray[Str] $.edge-names;

    submethod BUILD(:$!inherit = 0, :$!initial = 0, :$!box = 0) {}
    submethod TWEAK(:$enums, Str:D :$name!, :$!prop-num = (my uint8 $ = $enums{$name}), List :$children, List :$edges, Str :$edge, List :$default, Str :$synopsis) {
        $!name := $name;
        $!synopsis := $_ with $synopsis;
        with $children {
            $!child-names := CArray[Str].new(|$_);
            $!children := CArray[uint8].new(|.map({$enums{$_}}))
        }
        with $edges {
            $!edge-names := CArray[Str].new(|$_);
            $!edges := CArray[uint8].new(|.map({$enums{$_}}));
        }
        $!edge = $enums{$_} with $edge;
        with $default {
            $!default := .[0].Str;
            when .[1].defined {
                $!default-type := .[1][0].keys[0];
            }
        }
    }

    multi method COERCE(%meta) { self.new: |%meta }
}
