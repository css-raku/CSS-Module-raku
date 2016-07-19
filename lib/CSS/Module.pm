use v6;
class CSS::Module {
    #= a lightweight class for bundling resources associated with a particular CSS Syntax
    has $.grammar is required;  #| grammar
    has $.actions is required   #| actions class
                  handles <colors>;
    has %.property-metadata;
    has CSS::Module %.sub-module;
}
