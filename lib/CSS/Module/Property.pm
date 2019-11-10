use v6;
use NativeCall;
# native representation of a property;
class CSS::Module::Property is repr('CStruct') {
    has uint8 $.prop-num;
    has uint8 $.inherit;
    has uint8 $.initial;
    has uint8 $.box;
    has uint8 $!edge;
    method edge { $!edge }

    has CArray[uint8] $!children;
    method children { $!children }

    has CArray[uint8] $!edges;
    method edges { $!edges }

    submethod TWEAK(:$prop-names!, :$prop-num, List :$children, List :$edges, Str :$edge, *%etc) {
        my %prop-map = $prop-names.enums;
        $!children := CArray[uint8].new(|.map({%prop-map{$_}})) with $children;
        $!edges := CArray[uint8].new(|.map({%prop-map{$_}})) with $edges;
        $!edge = %prop-map{$_} with $edge;
    }
}
