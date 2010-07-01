package Kiki::Web::Authorizer::BasicAuth;
use Kamui;
use base 'Kamui::Web::Authorizer::BasicAuth';
use Kiki::Container;

sub authorize {
    my ($class, $context) = @_;

    my ($user, $passwd) = $class->basic_auth($context);
    if ($user && $passwd && container('conf')->{users}->{$user} eq $passwd) {
        return;
    } else {
        return $class->show_error_page($context);
    }
}

1;

