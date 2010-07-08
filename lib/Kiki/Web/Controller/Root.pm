package Kiki::Web::Controller::Root;
use Kamui::Web::Controller -base;
use Kiki::Container qw/api/;
__PACKAGE__->authorizer('+Kiki::Web::Authorizer::BasicAuth');

sub do_index : Auth('Null') {
    my ($class, $c) = @_;

    $c->stash->{page} = api('Page')->front;
    return $c->redirect('/add', {title => 'FrontPage'}) unless $c->stash->{page};
}

sub do_show : Auth('Null') {
    my ($class, $c, $args) = @_;

    $c->stash->{page} = api('Page')->get($args->{rid});
    return $c->redirect('/') unless $c->stash->{page};
}

sub do_list : Auth('Null') {
    my ($class, $c) = @_;

    ($c->stash->{list}, $c->stash->{has_next_page}) = api('Page')->search(
        +{
            page => $c->req->param('page') || 0,
        }
    );
}

sub do_rss : Auth('Null') {
    my ($class, $c) = @_;

    ($c->stash->{list}, ) = api('Page')->search(
        +{
            page => 0,
        }
    );

    $c->stash->{today} = api('DateTime')->today;

    $c->add_filter(
        sub {
            my ($context, $res) = @_;
            $res->headers([ 'Content-Type' => 'application/rss+xml' ]);
            $res;
        }
    );
}

sub do_search : Auth('Null') {
    my ($class, $c) = @_;

    return unless $c->req->param('keyword');
    $c->fillin_fdat($c->req->parameters->as_hashref_mixed);
    ($c->stash->{list}, $c->stash->{has_next_page}) = api('Page')->search(
        +{
            page    => $c->req->param('page') || 0,
            keyword => $c->req->param('keyword') || '',
        }
    );
}

sub do_add {
    my ($class, $c) = @_;

    if ( $c->req->is_post_request ) {

        my $validator = $c->validator->valid('page')->add;
        if ($validator->has_error) {
            $c->stash->{validator} = $validator;
            $c->fillin_fdat($c->req->parameters->as_hashref_mixed);
            return;
        }

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

        my $validator = $c->validator->valid('page')->edit_or_delete;
        if ($validator->has_error) {
            $c->stash->{validator} = $validator;
            $c->fillin_fdat($c->req->parameters->as_hashref_mixed);
            return;
        }

        api('Page')->edit_or_delete(
            $c->stash->{page} => $c->req->parameters
        );

        return $c->redirect('/'.$c->stash->{page}->rid);
    }

    $c->fillin_fdat($c->stash->{page}->get_columns);
}

1;

