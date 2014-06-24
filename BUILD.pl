use v6;

multi MAIN( Bool :$interfaces=True, Bool :$grammars=True, Bool :$actions=True ) {
    for ('etc/css1-properties.txt' => <CSS1>,
         'etc/css21-properties.txt' => <CSS21>,
         'etc/css3x-font-properties.txt' => <CSS3 Fonts>,
         'etc/css3x-font-\@fontface-properties.txt' => <CSS3 Fonts AtFontFace>,
         'etc/css3x-paged-media.txt' => <CSS3 PagedMedia>,
        ) {
        my ($spec, $class-isa) = .kv;

        my @productions;

        @productions.push: 'role'    => 'Interface'
            if $interfaces;

        @productions.push: 'class'   => 'Actions'
            if $actions;

        @productions.push: 'grammar' => 'Grammar'
            if $grammars;

        for @productions {
            my ($opt, $subclass) = .kv;
            my $class-name = (<CSS Language>, @$class-isa, <Spec>,  $subclass).join('::');
            my $class-path = (<lib CSS Language>, @$class-isa, <Spec>, $subclass).join('/');
            my $perl6 = $*EXECUTABLE_NAME;
            my $cmd = "$perl6 -Iblib/lib -Ilib etc/gen-properties.pl --{$opt}={$class-name} $spec > {$class-path}.pm";
            say $cmd;
            shell $cmd;
        }
    }
}
     
