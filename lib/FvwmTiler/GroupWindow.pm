package FvwmTiler::GroupWindow;
use strict;
use warnings;

=head1 NAME

FvwmTiler::GroupWindow - FvwmTiler class for windows.

=head1 VERSION

This describes version B<0.01> of FvwmTiler::GroupWindow.

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

    use FvwmTiler::GroupWindow;

=head1 DESCRIPTION

This module remembers information about windows.

=cut

use lib `fvwm-perllib dir`;
use FVWM::Module;

use base qw( Class::Base );

our $ERROR;
our $DEBUG = 0 unless defined $DEBUG;

=head2 init

Initialize.

=cut
sub init {
    my ($self, $config) = @_;
    
    $self->params($config,
	{
	    ID => '',
	    GID=>undef,
	})
	|| return undef;

    return $self;
} # init

=head2 set_group

Change the group of the window.

=cut
sub set_group {
    my $self = shift;
    my %args = (
	group=>undef,
	@_
    );
    $self->{GID} = $args{group};

} # set_group

=head2 arrange_self

Resize and move self.

$self->arrange_self(x=>$xpos,
y=>$ypos,
width=>$width,
height=>$height,
module=>$mod_ref,
);

=cut
sub arrange_self {
    my $self = shift;
    my %args = (
	x=>undef,
	y=>undef,
	width=>undef,
	height=>undef,
	module=>undef,
	@_
    );
    # Even though we are calling this by window-id, add the window-id condition
    # to prevent a race condition (i hope)
    $args{module}->postponeSend("WindowId " . $self->{ID} . " (Maximizable) ResizeMoveMaximize frame $args{width}p $args{height}p $args{x}p $args{y}p", 
				$self->{ID});
} # arrange_self

1; # End
__END__
