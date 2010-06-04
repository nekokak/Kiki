package Kiki::Model::DB::Row::Page;
use strict;
use warnings;
use base 'DBIx::Skinny::Row';
use Text::Xatena;

sub formatted_body {
    my $self = shift;
    my $thx = Text::Xatena->new;
    $thx->format($self->body);
}

1;

