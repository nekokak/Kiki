package Kiki::Web::Validator::Page;
use Kamui::Web::Validator -base;

sub add {
    my $self = shift;
    $self->{engine}->check(
        title => [qw/NOT_NULL/],
        body  => [qw/NOT_NULL/],
    );
}

sub edit {
    my $self = shift;
    $self->{engine}->check(
        title => [qw/NOT_NULL/],
        body  => [qw/NOT_NULL/],
    );
}

1;

