[[Raku CSS Project]](https://css-raku.github.io)
 / [[CSS-Module]](https://css-raku.github.io/CSS-Module-raku)

# CSS::Module

```
# Parse a sample stylesheet as CSS 2.1. Dump the AST.
use v6;
use CSS::Module::CSS21;
my $css = 'h1 { color: orange; text-align: center }';
my $module = CSS::Module::CSS21.module;
my $actions = $module.actions.new;
$module.grammar.parse( $css, :$actions);
say $/.ast.raku;
```

CSS::Module is a set of Raku classes for parsing and manipulation of CSS Levels 1, 2.1 and  3, and SVG.

It contains modules `CSS::Module::CSS1`, `CSS::Module::CSS21` and `CSS::Module::CSS3` for CSS levels 1.0, 2.1 and 3.0, along with `CSS::Module::SVG`, which is a CSS3 extension for [styling SVG](https://www.w3.org/TR/SVG2/styling.html).

Each of these classes has a `module` method which produces an object that encapsulates grammars, actions
and property metadata. It has a`property-metadata` method that can be used to introspect properties. For example

```
% raku -M CSS::Module::CSS3 -e'say CSS::Module::CSS3.module.property-metadata<azimuth>.raku'
{:default("center"), :inherit, :synopsis("<angle> | [[ left-side | far-left | left | center-left | center | center-right | right | far-right | right-side ] || behind ] | leftwards | rightwards")}
```

Note: `CSS::Module::CSS3.module` is composed from the following grammars.

- `CSS::Module::CSS3::Colors`     - CSS 3.0 Colors (@color-profile)
- `CSS::Module::CSS3::Fonts`      - CSS 3.0 Fonts (@font-face)
- `CSS::Module::CSS3::Selectors`  - CSS 3.0 Selectors
- `CSS::Module::CSS3::Namespaces` - CSS 3.0 Namespace (@namespace)
- `CSS::Module::CSS3::Media`      - CSS 3.0 Media (@media)
- `CSS::Module::CSS3::PagedMedia` - CSS 3.0 Paged Media (@page)
- `CSS::ModuleX::CSS21`           - the full set of CSS21 properties

This corresponds to the sub-modules described in [CSS Snapshot 2010](http://www.w3.org/TR/2011/NOTE-css-2010-20110512/).

## Installation

You can use the Raku `zef` module installer to test and install `CSS::Module`:

    % zef install CSS::Module

## Examples

- parse a stylesheet using the CSS2.1 grammar:

    % raku -MCSS::Module::CSS21 -e"say CSS::Module::CSS21.parse('h1 {margin:2pt; color: blue}')"


- compile a CSS2.1 stylesheet to an AST, using the module interface:

```
use v6;
use CSS::Module::CSS21;

my $css = 'H1 { color: blue; foo: bar; background-color: zzz }';
my $module  = CSS::Module::CSS21.module;
my $grammar = $module.grammar;
my $actions = $module.actions.new;
my $p = $grammar.parse($css, :$actions);
note $_ for $actions.warnings;
say "declaration: " ~ $p.ast[0]<ruleset><declarations>.raku;
# output:
# unknown property: foo - declaration dropped
# usage background-color: <color> | transparent | inherit
# declaration: {"color" => {"expr" => [{"rgb" => [{"num" => 0}, {"num" => 0}, {"num" => 255}]}]}
```

- parse an individual `azimuth` property expression via the module interface:

```
    use v6;
    use CSS::Module::CSS21;
    my $ast = CSS::Module::CSS21.module.parse-property('azimuth', 'center-left behind');
```

- Composition: A secondary aim is mixin style module composition. For example to create a module MyCSS3Subset::CSS3 comprising CSS2.1 properties + CSS3 Selectors + CSS3 Colors:

    ```
    use v6;

    use CSS::Module;
    use CSS::Module::CSS21::Actions;
    use CSS::Module::CSS21;

    use CSS::Module::CSS3::Selectors;
    use CSS::Module::CSS3::Colors;
    use CSS::Module::CSS3::_Base;

    class MyCSS3Subset::Actions
        is CSS::Module::CSS3::Selectors::Actions
        is CSS::Module::CSS3::Colors::Actions
        is CSS::ModuleX::CSS21::Actions
        is CSS::Module::CSS3::_Base::Actions {
    };
    grammar MyCSS3Subset::CSS3
        is CSS::Module::CSS3::Selectors
        is CSS::Module::CSS3::Colors
        is CSS::ModuleX::CSS21
        is CSS::Module::CSS3::_Base {

        #| a minimal module definition: grammar + actions
        method module {
	  state $this //= CSS::Module.new(
              :name<my-css3-subset>,
              :grammar($?CLASS),
              :actions(MyCSS3Subset::Actions) );
        }
    };

    ```

## Property Definitions

Property definitions are built from the sources in the `src` directory using the CSS::Specification tools. These implement the [W3C Property Definition Syntax](https://developer.mozilla.org/en-US/docs/Web/CSS/Value_definition_syntax).


Generated modules are written under the `gen/lib` directory.

For example [CSS::Module:CSS1::Spec::Grammar](gen/lib/CSS/Module/CSS1/Spec/Grammar.pm), [CSS::Module:CSS1::Spec::Actions](gen/lib/CSS/Module/CSS1/Spec/Actions.pm) and [CSS::Module:CSS1::Spec::Interface](gen/lib/CSS/Module/CSS1/Spec/Interface.pm) are generated from [etc/css1-properties.txt](etc/css1-properties.txt).

See `make-modules.pl`.

## Actions Options

- **`:lax`** Don't warn about, or discard, unknown properties, sub-rules. Pass back the elements with a classification
of unknown. E.g.
```
    my $module  = CSS::Module::CSS21.module;
    my $grammar = $module.grammar;
    my $actions = $module.actions.new( :lax );

    say $grammar.parse('{bad-prop: 12mm}', :$actions, :rule<declarations>).ast.raku;
    # output {"property:unknown" => {:expr[{ :mm(12) }], :ident<bad-prop>}}

    say $grammar.parse('{ @guff {color:red} }', :$actions, :rule<declarations>).ast.raku;
    # output: {"margin-rule:unknown" =>  { :declarations[ { :ident<color>,
                                                          :expr[ { :rgb[ { :num(255) }, { :num(0) }, { :num(0) } ] } ] } ],
                                         :at-keyw<guff> } }
```
`lax` mode likewise returns quantities with unknown dimensions:
```
    say $grammar.parse('{margin: 12mm .1furlongs}', :$actions, :rule<declarations>).ast.raku;
    # output {"property" => {:expr[{ :mm(12) }, { :num(0.12), "units:unknown" => <furlongs>}], :ident<margin>}}
```

## Custom Properties

Properties may be added, or overriden via an `:%extensions` option to the `new*()` method.

```
subset MyAlignment of Str where 'left'|'middle'|'right';
sub coerce(MyAlignment:D $keyw --> Pair) { :$keyw }

my %extensions =  %(
    '-my-align' => %(:synopsis("left | middle | right"), :default<middle>, :&coerce),
);

my $module = CSS::Module::CSS3.module: :%extensions;
say $module.property-metadata<-my-align>.raku;
```

## See Also

- [CSS::Properties](https://css-raku.github.io/CSS-Properties-raku) - property-set manipulation module
- [CSS::Specification](https://css-raku.github.io/CSS-Specification-raku) - property definition syntax
- [CSS::Grammar](https://css-raku.github.io/CSS-Grammar-raku) - base grammars
- [CSS::Writer](https://css-raku.github.io/CSS-Writer-raku) - AST reserializer

## References

- CSS Snapshot 2010 - http://www.w3.org/TR/2011/NOTE-css-2010-20110512/
- CSS1 - http://www.w3.org/TR/2008/REC-CSS1-20080411/#css1-properties
- CSS21 - http://www.w3.org/TR/2011/REC-CSS2-20110607/propidx.html
- CSS3
  - CSS Color Module Level 3 - http://www.w3.org/TR/2011/REC-css3-color-20110607/
  - CSS Fonts Module Level 3 - http://www.w3.org/TR/2013/WD-css3-fonts-20130212/
  - CSS3 Namespaces Module - http://www.w3.org/TR/2011/REC-css3-namespace-20110929/
  - CSS3 Media Query Extensions - http://www.w3.org/TR/2012/REC-css3-mediaqueries-20120619/
  - CSS3 Module: Paged Media - http://www.w3.org/TR/2006/WD-css3-page-20061010/
  - CSS Selectors Module Level 3 - http://www.w3.org/TR/2011/REC-css3-selectors-20110929/
- SVG - https://www.w3.org/TR/SVG2/styling.html https://www.w3.org/TR/SVG/propidx.html

