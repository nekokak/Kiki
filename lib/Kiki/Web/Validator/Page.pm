package Kiki::Web::Validator::Page;
use Kamui::Web::Validator -base;
use Kiki::Container qw/api/;

sub add {
    my $self = shift;
    $self->{engine}->check(
        title => [qw/NOT_NULL/],
        body  => [qw/NOT_NULL/],
    );
}

sub edit_or_delete {
    my $self = shift;
    $self->{engine}->check(
        title => [qw/NOT_NULL/],
    );
    if ( api('Page')->is_conflict($self->{context}->stash->{page}, $self->{context}->req->param('current_updated_at')) ) {
        $self->{engine}->set_error('update' => 'CONFLICT');
    }
    $self->{engine}
}

1;

