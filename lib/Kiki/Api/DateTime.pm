package Kiki::Api::DateTime;
use strict;
use warnings;
use Kiki::Container;
use DateTime;
use DateTime::Format::Strptime;
use DateTime::Format::MySQL;

sub new { bless {}, +shift }

sub now {
    DateTime->now(time_zone => container('timezone'));
}

sub today {
    DateTime->today(time_zone => container('timezone'));
}

sub strptime {
    my ($self, $str, $pattern) = @_;

    my $dt = DateTime::Format::Strptime->new(
        pattern   => $pattern,
        time_zone => container('timezone'),
    )->parse_datetime($str);

    DateTime->from_object( object => $dt );
}

sub inflate_date {
    my ($self, $str) = @_;

    return unless $str;
    return if $str eq '0000-00-00';
    return $self->strptime($str, '%Y-%m-%d');
}

sub inflate_datetime {
    my ($self, $str) = @_;

    return unless $str;
    return if $str eq '0000-00-00 00:00:00';
    return $self->strptime($str, '%Y-%m-%d %H:%M:%S');
}

sub deflate_date {
    my ($self, $dt) = @_;

    return $dt unless ref $dt eq 'DateTime';
    DateTime::Format::MySQL->format_date($dt);
}

sub deflate_datetime {
    my ($self, $dt) = @_;

    return $dt unless ref $dt eq 'DateTime';
    DateTime::Format::MySQL->format_datetime($dt);
}

1;

