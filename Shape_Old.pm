package Shape;

# class with static attributes.
=begin comment
sub new {
    my $class = shift;
    my $self  = {
        color => 'black',
        length => 1,
        width  => 1,
    };
    return bless $self, $class;
}
=end comment
=cut

# class with flexiable attributes.
=begin comment
sub new {
    my ($class, $args) = @_;
    my $self = {
        color  => $args->{color},
        length => $args->{length},
        width  => $args->{width},
    };
    return bless $self, $class;
}
=end comment
=cut

# class with default value attributes.
# new sub is constructor of the class.
sub new {
    my ($class, $args) = @_;
    my $self = {
        color  => $args->{color} || 'black',
        length => $args->{length} || 1,
        width  => $args->{width} || 1,
    };
    return bless $self, $class;
}

# adding new sub to the class, getter functions...
sub get_area {
    my $self = shift;
    my $area = $self->{length} * $self->{width};
    return $area;
}

sub get_color {
    my $self = shift;
    return $self->{color};
}

sub set_color {
    my ($self, $color) = @_;
    $self->{color} = $color;
}


# by default perl package must return true value so by default we will use ..
1;