use v6;
use NativeCall;
# native representation of a property;
class CSS::Module::Property is repr('CStruct') {
    has Str $.prop-name;
    has uint8 $.prop-num;

    has uint8 $.inherit;
    method inherit { ? $!inherit }

    has uint8 $.initial;
    method initial { ? $!initial }

    has uint8 $.box;
    method box { ? $!box }

    has uint8 $!edge;
    method edge { $!edge }

    has Str $!synopsis;
    method synopsis { $!synopsis }

    has Str $!default-type;
    has Str $!default;
    method default { $!default }

    method default-value {
        # kludgy default handling - part II
        with $!default-type {
            when "keyw"                    { [$_ => $!default] }
            when "px" && $!default eq "0"  { :px(0) }
            when $!default eq '0% 0%'      { [:percent(0) xx 2] }
            default { warn "ignoring default value: $!default-type:$!default" }
        }
        else {
            Nil
        }
    }

    has CArray[uint8] $!children;
    method children { $!children }

    has CArray[uint8] $!edges;
    method edges { $!edges }

    submethod TWEAK(:$prop-names!, List :$children, List :$edges, Str :$edge, List :$default, Str :$synopsis) {
        my %prop-map = $prop-names.enums;
        $!prop-name := $prop-names($!prop-num).key;
        $!synopsis := $_ with $synopsis;
        $!children := CArray[uint8].new(|.map({%prop-map{$_}})) with $children;
        $!edges := CArray[uint8].new(|.map({%prop-map{$_}})) with $edges;
        $!edge = %prop-map{$_} with $edge;
        with $default {
            # kludgy default handling - part I
            when .[1].defined {
                $!default-type := .[1][0].keys[0];
                $!default := .[0].Str;
            }
        }
    }
}
