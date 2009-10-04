use strict;
use Test::More tests => 5 * 2;

use IO::File::WithPath;
use FindBin;
my $script_path = "$FindBin::Bin/01_basic.t";

check(IO::File::WithPath->new($script_path));

open my $fh, "<", $script_path;
check(IO::File::WithPath->from_open_handle($fh));


sub check {
    my $f = shift;

    is ref $f => 'IO::File::WithPath';
    is $f->path => $script_path;

    is $f->getline => "use strict;\n";

    while ( my $line = <$f> ) {
        is $line => "use Test::More tests => 5 * 2;\n";
        last;
    }

    my @lines = <$f>;
    is $lines[1] => "use IO::File::WithPath;\n";
}
