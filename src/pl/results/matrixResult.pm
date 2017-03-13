use strict;
use warnings;
use Carp;

package MatrixResult;

sub new {
    my $class = shift;
    my ($args) = @_;
    my $self = {
        matrix => $args->{matrix},
        sum => $args->{sum},
        side => $args->{side},
        success => $args->{success}
    };
    
    return bless $self, $class;
}

1;