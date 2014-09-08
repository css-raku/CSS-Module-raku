use v6;

use CSS::Specification::Build;

multi MAIN( Bool :$interfaces=True, Bool :$grammars=True, Bool :$actions=True ) {

    our &build = &CSS::Specification::Build::generate;

    for ('etc/css1-properties.txt' => <CSS1>,
         'etc/css21-properties.txt' => <CSS21>,
         'etc/css3x-font-properties.txt' => <CSS3 Fonts>,
         'etc/css3x-font-@fontface-properties.txt' => <CSS3 Fonts AtFontFace>,
         'etc/css3x-paged-media.txt' => <CSS3 PagedMedia>,
        ) {
        my ($input-spec, $class-isa) = .kv;

        my @productions;

        @productions.push: 'interface'    => 'Interface'
            if $interfaces;

        @productions.push: 'actions'   => 'Actions'
            if $actions;

        @productions.push: 'grammar' => 'Grammar'
            if $grammars;

        for @productions {
            my ($type, $subclass) = .kv;
            my $name = (<CSS Module>, @$class-isa, <Spec>,  $subclass).join('::');
            my $class-path = (<lib CSS Module>, @$class-isa, <Spec>, $subclass).join('/') ~ '.pm';
            my %opts = proforma  =>  $class-isa !=== <CSS1>
                if $type eq 'grammar';

            note "building $input-spec => $type: $name";
            temp $*IN  = open $input-spec, :r;
            temp $*OUT = open $class-path, :w;

            build( $type, $name, |%opts );
        }
    }
}
     
