package Sort::Key::DateTime;

our $VERSION = '0.04';

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(dtkeysort dtcmpstr);

use Sort::Key;
use DateTime;
use Carp;

sub dtkeysort (&@) {
    my $k = shift;
    my @k = map {
	my $dt = &{$k};
	my $key = eval { sprintf("%010d%06d%010d", $dt->utc_rd_values) };
	$@ and croak "sorting key '$dt' generated for element '$_' is not a valid DateTime object ($@)";
	$key;
    } @_;
    Sort::Key::_keysort(Sort::Key::STR_SORT, \@k, \@_);
    wantarray ? @k : $k[0];
}

sub dtcmpstr ($) {
    my $dt=shift;
    my $key = eval { sprintf("%010d%06d%010d", $dt->utc_rd_values) };
    $@ and croak "sorting key '$dt' generated for element '$_' is not a valid DateTime object ($@)";
    $key;
}


1;
__END__

=head1 NAME

Sort::Key::DateTime - Perl extension for sorting objects by some DateTime key

=head1 SYNOPSIS


  use Sort::Key::DateTime qw(dtkeysort);
  my @sorted = dtkeysort { $_->date } @meetings;


=head1 DESCRIPTION

Sort::Key::DateTime allows to sort objects by some (calculated) key of
type DateTime.

=head2 EXPORTS

=over 4

=item dtkeysort { CALC_DT_KEY } @array

returns the elements on C<@array> sorted by the DateTime key
calculated applying C<{ CALC_DT_KEY }> to them.

Inside C<{ CALC_DT_KEY }>, the object is available as C<$_>.

NOTE: sorting order is undefined when floating and non floating
DateTime keys are mixed.

BTW, DateTime objects can be sorted as:

  my @sorted = dtkeysort { $_ } @unsorted;


=item dtcmpstr($dt)

generates string sorting keys for DateTime objects

=back


=head1 SEE ALSO

L<Sort::Key>, perl L<sort> function docs.

L<DateTime> module documentation and FAQ available from the DateTime
project web site at L<http://datetime.perl.org/>

=head1 AUTHOR

Salvador FandiE<ntilde>o, E<lt>sfandino@yahoo.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2005 by Salvador FandiE<ntilde>o

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.8.4 or,
at your option, any later version of Perl 5 you may have available.

=cut
