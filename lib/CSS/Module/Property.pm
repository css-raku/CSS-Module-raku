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

    has Str $!default-type;
    has Str $.default;

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

    has CArray $!children;
    method children { $!children }

    has CArray $!edges;
    method edges { $!edges }

    submethod BUILD(:$!inherit = 0, :$!initial = 0, :$!box = 0) {}
    submethod TWEAK(:$enums!, Str:D :$name!, List :$children, List :$edges, Str :$edge, List :$default, Str :$synopsis) {
        $!name := $name;
        $!prop-num = (my uint8 $ = $enums{$name});
        $!synopsis := $_ with $synopsis;
        $!children := CArray[uint8].new(|.map({$enums{$_}})) with $children;
        $!edges := CArray[uint8].new(|.map({$enums{$_}})) with $edges;
        $!edge = $enums{$_} with $edge;
        with $default {
            # kludgy default handling - part I
            when .[1].defined {
                $!default-type := .[1][0].keys[0];
                $!default := .[0].Str;
            }
        }
    }
}
