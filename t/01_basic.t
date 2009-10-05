use strict;
use Test::More tests => 6 * 1;

use IO::File::WithPath;
use FindBin;
my $script_path = "$FindBin::Bin/01_basic.t";

check(IO::File::WithPath->new($script_path));


sub check {
    my $f = shift;

    is ref $f => 'IO::File::WithPath';
    ok $f->can('path');
    is $f->path => $script_path;

    is $f->getline => "use strict;\n";

    while ( my $line = <$f> ) {
        is $line => "use Test::More tests => 6 * 2;\n";
        last;
    }

    my @lines = <$f>;
    is $lines[1] => "use IO::File::WithPath;\n";
}
