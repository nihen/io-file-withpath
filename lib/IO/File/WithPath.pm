package IO::File::WithPath;
use strict;
use warnings;
our $VERSION = '0.01';

use base qw/IO::File/;
use Path::Class;

our $path_guess_method;
BEGIN {
    $path_guess_method = sub {};
    if ( $^O eq 'MSWin32' ) {
        # TODO 
    }
    else {
        # TODO any platform support.
        # - MacOSX
        if ( -d "/proc/$$/fd/" ) {
            $path_guess_method = sub {
                my $fd = sprintf('/proc/%s/fd/%s', $$, fileno $_[0]);
                return if !-e $fd;
                return readlink($fd);
            };
        }
    }
}

sub new {
    my $class = shift;
    my $path  = shift;

    my $io = IO::File->new($path, @_);

    # symboltable hack
    ${*$io}{__PACKAGE__} = Path::Class::File->new($path)->resolve->absolute;

    bless $io, $class;
}

sub path { 
    my $io = shift;
    ${*$io}{__PACKAGE__};
}

sub from_open_handle {
    my $class = shift;
    my $io    = shift;

    my $path = $path_guess_method->($io);

    if ( !$path ) {
        return;
    }

    return __PACKAGE__->new($path);
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

  open my $fh, '<', '/path/to/file';
  $io = IO::File::WithPath->from_open_handle($fh);
  print $io->path; # print '/path/to/file'

=head1 DESCRIPTION

IO::File::WithPath is IO::File remember file path.

=head1 METHODS

=over 4

=item new

create object from file-path as IO::File->new().
but file-path not include MODE.(e.g. '</path/to/file')

=item from_open_handle

create object from filehandle.

=back

=head1 AUTHOR

Masahiro Chiba E<lt>chiba@geminium.comE<gt>

=head1 THANKS TODO

miyagawa
nothingmuch

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
