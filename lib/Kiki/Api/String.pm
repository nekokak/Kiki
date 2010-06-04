package Kiki::Api::String;
use strict;
use warnings;
use String::Random qw/random_regex/;

sub new { bless {}, +shift }

sub gen_unique {
    my ($self, $db, $table, $col, $rule) = @_;

    for my $i (1 .. 1000) {
        my $random_str = random_regex($rule);
        my $row = $db->single($table, { $col => $random_str });
        unless ($row) {
            return $random_str;
        }
    }

    die "Failed to generate unique random string";
}

1;

