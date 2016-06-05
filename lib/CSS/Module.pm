use v6;
class CSS::Module {
    #= a lightweight class for bundling resources associated with a particular CSS Syntax
    has $.grammar is required;   #| grammar
    has $.actions is required;   #| actions class
    has $.metadata;  #| property metadata class
    has Str @specs;
}
