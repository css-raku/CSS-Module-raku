use v6;

use CSS::Specification::Build;
use Panda::Builder;
use Panda::Common;

class Build is Panda::Builder {

    method build($where, Bool :$interfaces=True, Bool :$grammars=True, Bool :$actions=True ) {

        indir $where, {
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

                    my $class-dir = (<lib CSS Module>, @$class-isa, <Spec>).join('/');
                    mkdir $class-dir;

                    my $class-path = $class-dir ~ '/' ~ $subclass ~ '.pm';

                    my %opts = proforma  =>  $class-isa !=== <CSS1>
                        if $type eq 'grammar';

                    say "Building $input-spec => $name";
                    {
                        my $*IN = open $input-spec, :r;
                        my $*OUT = open $class-path, :w;

                        CSS::Specification::Build::generate( $type, $name, |%opts );
                    }
                }
            }
        }
    }
}

# Build.pm can also be run standalone 
sub MAIN(Str $working-directory = '.', Bool :$interfaces=True, Bool :$grammars=True, Bool :$actions=True ) {
    Build.new.build($working-directory, :$interfaces, :$grammars, :$actions);
}
