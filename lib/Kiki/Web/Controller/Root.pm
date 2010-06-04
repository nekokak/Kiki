package Kiki::Web::Controller::Root;
use Kamui::Web::Controller -base;
use Kiki::Container qw/api/;

sub do_index {
    my ($class, $c) = @_;

    $c->stash->{page} = api('Page')->front;
    return $c->redirect('/add', {title => 'FrontPage'}) unless $c->stash->{page};
}

sub do_show {
    my ($class, $c, $args) = @_;

    $c->stash->{page} = api('Page')->get($args->{rid});
    return $c->redirect('/') unless $c->stash->{page};
}

sub do_list {
    my ($class, $c) = @_;
    $c->stash->{list} = api('Page')->list;
}

sub do_add {
    my ($class, $c) = @_;

    if ( $c->req->is_post_request ) {

        my $page = api('Page')->add(
            $c->req->parameters
        );

        return $c->redirect('/'.$page->rid);
    }

    $c->fillin_fdat($c->req->parameters->as_hashref_mixed);
}

sub do_edit {
    my ($class, $c, $args) = @_;

    $c->stash->{page} = api('Page')->get($args->{rid});
    return $c->redirect('/') unless $c->stash->{page};

    if ( $c->req->is_post_request ) {

        api('Page')->edit_or_delete(
            $c->stash->{page} => $c->req->parameters
        );

        return $c->redirect('/'.$c->stash->{page}->rid);
    }

    $c->fillin_fdat($c->stash->{page}->get_columns);
}

1;
