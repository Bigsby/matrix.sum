package ParseSideResult;

use strict;
use warnings;
use Carp;

sub new {
    my $class = shift;
    my ($args) = @_;
    my $self = {};
    
    if ($args->{errorMessage}){
        $self = {
            success => 0,
            errorMessage => $args->{errorMessage}
        };
    }else{
        $self = {
            success => 1,
            side => $args->{side}
        }
    }

    return bless $self, $class;
}

1;