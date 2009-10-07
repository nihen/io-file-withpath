package IO::File::WithPath;
use strict;
use warnings;
our $VERSION = '0.03';

use base qw/IO::File/;
use File::Spec;

sub new {
    my $class = shift;
    my $path  = File::Spec->rel2abs(shift);

    my $io = IO::File->new($path, @_);

    # symboltable hack
    ${*$io}{+__PACKAGE__} = $path;

    bless $io => $class;
}

sub path { 
    my $io = shift;
    ${*$io}{+__PACKAGE__};
}


1;
__END__

=encoding utf8

=head1 NAME

IO::File::WithPath - IO::File remember file path

=head1 SYNOPSIS

  use IO::File::WithPath;
  my $io = IO::File::WithPath->new('/path/to/file');
  print $io->path; # print '/path/to/file'
  print $io->getline; # IO::File-method

=head1 DESCRIPTION

IO::File::WithPath is IO::File remember file path.

=head1 METHODS

=over 4

=item new

create object from file-path as IO::File->new().
but file-path not include MODE.(e.g. '</path/to/file')

=item path

file-path

=back

=head1 AUTHOR

Masahiro Chiba E<lt>chiba@geminium.comE<gt>

=head1 THANKS

miyagawa
nothingmuch

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
