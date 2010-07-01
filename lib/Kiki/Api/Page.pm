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

my $LIMIT = 30;
sub search {
    my ($self, $args) = @_;

    my $rs = container('db')->resultset(
        {
            select => '*',
            from   => [qw/page/],
        }
    );

    $rs->limit($LIMIT+1);
    my $page = $args->{page} || 1;
    if ($page != 1) {
        $rs->offset($LIMIT*($page -1));
    }
    $rs->order({ column => 'updated_at', desc => 'DESC' });

    my @rows = $rs->retrieve('page')->all;
    my $has_next = scalar(@rows) > $LIMIT ? 1 : 0;
    if ($has_next) {
        pop @rows;
    }

    return (\@rows, $has_next);
}

1;

