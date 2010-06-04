package Kiki::Container;
use Kamui::Container -base;

register db => sub {
    my $self = shift;
    $self->load_class('Kiki::Model::DB');
    Kiki::Model::DB->new($self->get('conf')->{datasource});
};

register timezone => sub {
    my $self = shift;
    $self->load_class('DateTime::TimeZone');
    DateTime::TimeZone->new(name => 'Asia/Tokyo');
};

1;

