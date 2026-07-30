unit grammar CSS::Module::Snapshot2026::Colors;

use  CSS::Module::CSS3::Colors;
also is CSS::Module::CSS3::Colors;

rule color:sym<rgb>  {<rgb>}
rule color:sym<rgba> {<rgba>}
rule color:sym<hsl>  {<hsl>}
rule color:sym<hsla> {<hsla>}

class Actions {
    also is CSS::Module::CSS3::Colors::Actions;
    method color:sym<rgb>($/)  { make 'rgb'  => $<rgb>.ast<func><args> }
    method color:sym<rgba>($/) { make 'rgba' => $<rgba>.ast<func><args> }
    method color:sym<hsl>($/)  { make 'hsl'  => $<hsl>.ast<func><args> }
    method color:sym<hsla>($/) { make 'hsla' => $<hsla>.ast<func><args> }
}
