package Kiki::Api::ValidatorMessage;
use strict;
use warnings;

sub new { bless {}, +shift }

sub set {
    my ($self, $validator) = @_;
    $self->{validator} = $validator;
    $self;
}

sub get_error_messages {
    my ($self, $param) = @_;

    return unless $self->{validator};
    return unless $param;

    my $message = join '<br />', $self->{validator}->get_error_messages_from_param($param);

    return qq{<span style="color: red;">$message</span><br />};
}

1;
