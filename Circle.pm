package Shape::Circle;
use parent Shape;

sub new {
    my ($class, $args) = @_;
    my $self = {
        color    => $args->{color} || 'black',
        diameter => $args->{diameter} || 1,
    };
    my $object = bless $self, $class;
    $object->_set_datetime;
    return $object;
}

sub get_radius {
    my $self = shift;
    return $self->{diameter} * 0.5;
}

sub get_circumference {
    my $self = shift;
    return $self->{diameter} * 3.14;
}

sub get_area {
    my $self = shift;
    my $area = $self->get_radius ** 2 * 3.14;
}
1;