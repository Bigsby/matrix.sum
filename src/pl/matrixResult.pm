package MatrixResult;
use Carp;

sub new {
    my $class = shift;
    my $self  = { @_ };
    croak "bad arguments" unless defined $self->{firstname} and defined $self->{lastname}; 
    return bless $self, $class;
}

sub name {
    my $self = shift;
    return "$self->{firstname} $self->{lastname}";
}
1;