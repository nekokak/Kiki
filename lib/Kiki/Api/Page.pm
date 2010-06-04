package Kiki::Api::Page;
use Kamui;
use Kiki::Container;

sub new { bless {}, +shift }

sub add {
    my ($self, $args) = @_;

    (my $body = $args->{body}) =~ s/\r//g;
    container('db')->insert('page',{
        title => $args->{title},
        body  => $body,
    });
}

sub edit_or_delete {
    my ($self, $page, $args) = @_;

    (my $body = $args->{body}) =~ s/\r//g;

    if ($body) {
        $page->update(
            {
                title => $args->{title},
                body  => $body,
            }
        );
    } else {
        $page->delete;
    }
}

sub get {
    my ($self, $rid) = @_;
    container('db')->single('page', {rid => $rid});
}

sub front {
    my ($self, ) = @_;
    container('db')->single('page', {title => 'FrontPage'});
}

sub list {
    my ($self, ) = @_;
    container('db')->search('page', {});
}

1;

