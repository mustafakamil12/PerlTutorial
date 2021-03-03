package Shape;
use Time::Piece;

sub new {
    my ($class, $args) = @_;
    my $self = {
        color    => $args->{color} || 'black',
        length   => $args->{length} || 1,
        width    => $args->{width} || 1,
    };
    my $object = bless $self, $class;
    $object->_set_datetime;
    return $object;
}

# The new destructor method, called automatically by Perl
sub DESTROY {
    my $self = shift;
    print "I have been garbage-collected!\n";
}

sub get_area {
    my $self = shift;
    return $self->{length} * $self->{width};
}

sub get_color {
    my $self = shift;
    return $self->{color};
}

sub set_color {
    my ($self, $color) = @_;
    $self->{color} = $color;
}

sub _set_datetime {
    my $self = shift;
    my $t = localtime;
    $self->{datetime} = $t->datetime;
}

sub get_datetime {
    my $self = shift;
    return $self->{datetime};
}

1;